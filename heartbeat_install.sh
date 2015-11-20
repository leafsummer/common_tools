#!/bin/bash
##因为切换后不会自动回主节点，所以脚本必需要先在主节点上运行，然后在备节点运行，才能保证heartbeat起来后vip在主节点。
##脚本需要7个参数，第一个为应用mysql/aaa,第二个为主机的角色master/slave，第三个为对方的IP，第四个为对方的主机名，第五个为虚拟 IP和app端口号，以减号相连以逗号分隔，例如10.5.31.1-10010,10.5.31.2-10011，第六个为切换后的报警对象，第七个为检测是否切换的命令,需返回status="ok"
##例：heartbeat_install.sh mysql master 10.0.0.0 hostname 10.0.0.1-mysql 13900000000 "result=\`ps aux | grep mysql | grep -v grep\`;if [ -n \"\$result\" ];then status=\"ok\";else echo \"service error\";fi"
app=$1
role=$2
other_ip=$3
other=$4
infos=$5
phone=$6
commond=$7
getway="10.6.31.254"

if [ "$role" = "master" ];then
primary=`uname -n`
backup=$other
elif [ "$role" = "slave" ];then
primary=$other
backup=`uname -n`
else
echo "Please select the role of the server master/slave"
exit 1
fi


remove_old_version() {
[ -f  /etc/init.d/heartbeat ] && /etc/init.d/heartbeat stop
apt-get remove --purge heartbeat -y
[ -f  /var/lib/heartbeat/crm/cib.xml ] && rm -f /var/lib/heartbeat/crm/cib.xml
}

install_heartbeat() {
apt-get install heartbeat -y
cat << EOF > /etc/heartbeat/ha.cf
crm on
logfile /var/log/ha-log
logfacility local0
keepalive 2
deadtime 15
warntime 5
initdead 30
udpport 694
ucast eth0 $other_ip
auto_failback off    
node    $primary
node    $backup
ping $getway
EOF
cat << EOF > /etc/heartbeat/authkeys
auth 1
1 crc
EOF
chmod 600 /etc/heartbeat/authkeys
host=`cat /etc/hosts | grep "$other_ip    $other"`
if [ -z "$host" ];then
	echo "$other_ip    $other" >> /etc/hosts
else
  echo "exist other hosts info"
fi
}

creat_monitor() {
/etc/init.d/heartbeat restart
sleep 90
if [ "$role" == "master" ];then
echo "yes" | crm configure property start-failure-is-fatal=true
echo "yes" | crm configure property stonith-enabled=false
echo "yes" | crm configure property no-quorum-policy=ignore
echo "yes" | crm configure rsc_defaults migration-threshold=1
fi
oldIFS=$IFS
IFS=","
for info in $infos
do
	vip=`echo $info | awk -F "-" '{print $1}'`
	port=`echo $info | awk -F "-" '{print $2}'`
cat << EOF > /etc/init.d/$app$port
#!/bin/bash
check_status() {
$commond
if [[ "\$status" = "ok" ]]
then
echo "port $port is OK"
else
echo "port $port is stop"
/usr/sbin/crm_resource -M -r $app-$port
curl http://10.7.101.57/index/?phone=$phone\&arg=1\&msg="vip $vip move to backup server"
fi
}
case \$1 in
status)
check_status
;;
*)
echo "usage:\$0 {status}"
esac
exit 0 
EOF
chmod 755 /etc/init.d/$app$port
[ -f  /etc/heartbeat/resource.d/$app$port ] && rm -rf /etc/heartbeat/resource.d/$app$port
ln -s /etc/init.d/$app$port /etc/heartbeat/resource.d/
if [ "$role" == "master" ];then
echo "yes" | crm configure primitive vip-$vip ocf:heartbeat:IPaddr2 params ip=$vip nic=eth0 op monitor interval=5s
echo "yes" | crm configure primitive $app-$port lsb:$app$port op monitor interval="5s"
echo "yes" | crm configure group vip-$app-$port vip-$vip $app-$port
fi
done
/etc/init.d/heartbeat restart
}

remove_old_version
install_heartbeat
creat_monitor
