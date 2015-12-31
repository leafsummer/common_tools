echo "iptables -F" >> /tmp/iptables.sh
echo "iptables -X" >> /tmp/iptables.sh
echo "iptables -Z" >> /tmp/iptables.sh
echo "iptables -t nat -F" >> /tmp/iptables.sh
echo "iptables -t mangle -F" >> /tmp/iptables.sh
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /tmp/chinadns_chnroute.txt
echo "iptables -t nat -N REDSOCKS" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -d 207.46.135.99 -j RETURN" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -p udp --dport 53 -j REDIRECT --to-ports 10053" >> /tmp/iptables.sh
for i in `cat /tmp/chinadns_chnroute.txt`
do
echo "iptables -t nat -A REDSOCKS -d $i -j RETURN" >> /tmp/iptables.sh
done
echo "iptables -t nat -A REDSOCKS -s 10.67.2.64/32 -p tcp --dport 80 -j REDIRECT --to-ports 12345" >> /tmp/iptables.sh
echo "iptables -t nat -A REDSOCKS -s 10.67.2.64/32 -p tcp --dport 443 -j REDIRECT --to-ports 12345" >> /tmp/iptables.sh
echo "iptables -t nat -A PREROUTING -p tcp -j REDSOCKS" >> /tmp/iptables.sh
# cat iptables.sh
