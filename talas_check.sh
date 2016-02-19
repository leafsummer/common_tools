#!/bin/bash

#
# Talas hosts
# collecting , spark cluster , hdfs/prestos
#
COLLECTING_HOSTS="10.7.107.102 10.7.107.103"
ZK_HOST="10.7.107.102"
KAFKA_TOPICS="PaaS.Streaming.Message.Entry PaaS.Streaming.Message.Bus PaaS.Streaming.Message.Store"

SPARK_MASTER="10.6.24.5"
#SPARK_SLAVERS="10.5.24.202 10.5.24.203 10.5.24.204 10.5.24.205"
SPARK_SLAVERS="distributed-computing-master-6-24-5.lab.intra.nsfocus.com"
SPARK_SLAVERS=${SPARK_SLAVERS}" distributed-computing-slave-1-6-24-6.lab.intra.nsfocus.com"
SPARK_SLAVERS=${SPARK_SLAVERS}" distributed-computing-slave-2-6-24-7.lab.intra.nsfocus.com"
SPARK_SLAVERS=${SPARK_SLAVERS}" distributed-computing-slave-3-6-24-8.lab.intra.nsfocus.com"

DBMASTER="10.6.31.239"
#DBWORKER="10.6.31.239 10.6.31.238 10.6.31.237 10.6.31.236"
DBWORKER="distributed-storage-master-6-31-239"
DBWORKER=${DBWORKER}" distributed-storage-slave-1-6-31-236"
DBWORKER=${DBWORKER}" distributed-storage-slave-2-6-31-237"
DBWORKER=${DBWORKER}" distributed-storage-slave-3-6-31-238"

TALAS_HOME="/opt/PaaS/Talas"

#
# add environments
#
function add_env(){
    export JAVA_HOME=${TALAS_HOME}"/lib/Java" # java 1.8
    export PATH=${JAVA_HOME}"/bin":${PATH}

    export KAFKA_HOME=${TALAS_HOME}"/lib/Kafka"
    export PATH=${KAFKA_HOME}"/bin":${PATH}

    export HADOOP_HOME=${TALAS_HOME}"/lib/Hadoop"
    export PATH=${HADOOP_HOME}"/bin":${PATH}

    export SPARK_HOME=${TALAS_HOME}"/lib/Spark"
    export PATH=${SPARK_HOME}"/bin":${PATH}

    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TALAS_HOME}"/lib/Qpid/lib"
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TALAS_HOME}"/lib/ZeroMQ/lib"
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TALAS_HOME}"/lib/Snappy/lib"
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TALAS_HOME}"/lib/zkc/lib"

    export PYTHONPATH=${TALAS_HOME}"/dev/lix":${PYTHONPATH}
    export PYTHONPATH=${TALAS_HOME}"/dev/python":${PYTHONPATH}
}
add_env

#
# output format
#
function blockmsg(){
    echo -e "\033[1m>>> $1\033[0m" ;
}

function infomsg(){
    echo " >> OK : $1" ;
}

function errmsg(){
    echo -e "\033[31m !! ERROR : $1\033[0m" ;
}

#
# connect (host , port)
#
function port_open(){
    R=`nc -vv -w 1 $1 $2 2>&1 | grep succeeded | wc -l` ;
    if [ ${R} -ne 1 ] ; then
        return 0 ;
    fi
    return 1 ;
}

#
# check host alive
#
blockmsg "Checking Host Alive / All"
for HT in ${COLLECTING_HOSTS} ${SPARK_SLAVERS} ${DBWORKER} ; do
    R=`ping ${HT} -c 2 2> /dev/null | grep ttl | wc -l`
    if [ ${R} -ne 0 ] ; then
        infomsg "${HT} alive"
    else
        errmsg "${HT} NOT ALIVE"
    fi
done

#
# check host alive
#
#blockmsg "Checking Disk Status / All"
#for HT in ${COLLECTING_HOSTS} ${SPARK_SLAVERS} ${DBWORKER} ; do
#    R=`ping 10.67.1.1 -c 3 2> /dev/null | grep ttl | wc -l`
#    if [ ${R} -ne 0 ] ; then
#        infomsg "${HT} alive"
#    else
#        errmsg "${HT} NOT ALIVE"
#    fi
#done

#
# checking collecting
#

# zk port : 2181
blockmsg "Checking Zookeeper Port / Collecting"
port_open ${ZK_HOST} 2181
if [ $? -ne 1 ] ; then
    errmsg "port for ZooKeeper ${ZK_HOST}:2181"
else
    infomsg "port for ZooKeeper ${ZK_HOST}:2181"
fi

# zk status
blockmsg "Checking Zookeeper Status / Collecting"
R=`echo conf | nc ${ZK_HOST} 2181 | grep "clientPort=2181" | wc -l`
if [ ${R} -ne 1 ] ; then
    errmsg "get zookeeper status failed ${ZK_HOST}:2181"
else
    infomsg "get zookeeper status done ${ZK_HOST}:2181"
fi

# kafka port : 9092
blockmsg "Checking Kafka Port / Collecting"
for HT in ${COLLECTING_HOSTS} ; do
    port_open ${HT} 9092
    if [ $? -ne 1 ] ; then
        errmsg "port for Kafka ${HT}:9092"
    else
        infomsg "port for Kafka ${HT}:9092"
    fi
done

# kafka staus
blockmsg "Checking Kafka Status / Collecting"
for HT in ${COLLECTING_HOSTS} ; do
    R=`python -c "from kafka.client import KafkaClient; kconn = KafkaClient('${HT}:9092' , timeout=3) ; print len([x for x in kconn.topic_partitions.keys() if x.startswith('PaaS.')])"`
    if [ ${R} -ne 4 ] ; then
        errmsg "get topic info failed ${HT}:9092"
    else
        infomsg "get topic info done ${HT}:9092"
    fi
done

# kafka topic
blockmsg "Checking Kafka Messages Lag / Collecting"
for KTP in ${KAFKA_TOPICS} ; do
    MLG=`kafka-consumer-offset-checker.sh --topic ${KTP} --zookeeper=${ZK_HOST}:2181 --group=${KTP} | tail -2 | awk '{print $3" : "$6" "}' | tr "\n" ","`
    infomsg "message lag for ${KTP} : ${MLG}"
done

# receiving device status
blockmsg "Checking Collecting Messages (3 seconds) / Collecting"
RF=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/collecting/zmq.log | md5sum" | awk '{print $1}'`
sleep 3
RS=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/collecting/zmq.log | md5sum" | awk '{print $1}'`
if [ ${RF} != ${RS} ] ; then
    infomsg "collecting messages ok"
else
    errmsg "collecting messages failed"
fi

#
# spark job port 7077
#
blockmsg "Checking Spark Master Port / Spark"
port_open ${SPARK_MASTER} 7077
if [ $? -ne 1 ] ; then
    errmsg "port for Spark ${SPARK_MASTER}:7077"
else
    infomsg "port for Spark ${SPARK_MASTER}:7077"
fi

#
# spark web ui port : 8080
#
blockmsg "Checking Spark Master WebUI Port / Spark"
port_open ${SPARK_MASTER} 8080
if [ $? -ne 1 ] ; then
    errmsg "port for Spark.WebUI ${SPARK_MASTER}:8080"
else
    infomsg "port for Spark.WebUI ${SPARK_MASTER}:8080"
fi

#
# spark slavers status
#
blockmsg "Checking Spark Status / Spark"
R=`curl http://${SPARK_MASTER}:8080/ 2>/dev/null | python -c "import sys ;import lxml.html ; root = lxml.html.fromstring(sys.stdin.read()) ; yy = ['|'.join([x.text.strip().lower().replace('\n' , '').split(':')[0] for x in n.getchildren()[1:3]]) for n in root.xpath('/html/body/div/div[3]/div/table/tbody')[0].getchildren()] ; print '\n'.join(yy)" | sort -u`

for SKS in ${SPARK_SLAVERS} ; do
    sksfound=0
    for er in ${R} ; do
        if [ "${SKS}|alive" = ${er} ] ; then
            sksfound=1
            infomsg ${er}
            break
        fi
        if [ "${SKS}|dead" = ${er} ] ; then
            sksfound=1
            errmsg ${er}
            break
        fi
    done
    if [ ${sksfound} -ne 1 ] ; then
        errmsg "${SKS}|gone"
    fi
done

#
# spark streaming running?
#
blockmsg "Checking Spark Streaming (5 seconds) / Spark"
RF=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_device_load.log | md5sum" | awk '{print $1}'`
sleep 5
RS=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_device_load.log | md5sum" | awk '{print $1}'`
if [ ${RF} != ${RS} ] ; then
    infomsg "spark streaming running"
else
    errmsg "spark streaming NOT RUNNING ???"
fi

#
# spark streaming stor running?
#
blockmsg "Checking Spark Streaming Stor (30 seconds) / Spark"
RF=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_streaming_stor.log | md5sum" | awk '{print $1}'`
sleep 3
RS=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_streaming_stor.log | md5sum" | awk '{print $1}'`
if [ ${RF} != ${RS} ] ; then
    infomsg "spark streaming stor running"
else
    errmsg "spark streaming stor NOT RUNNING ???"
fi

#
# spark streaming stor running?
#
blockmsg "Checking Spark Batching (80 seconds) / Spark"
RF=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_cpu_status.log | md5sum" | awk '{print $1}'`
sleep 5
RS=`ssh root@${SPARK_MASTER} "tail -100 /opt/PaaS/Talas/logs/streaming/pl_cpu_status.log | md5sum" | awk '{print $1}'`
if [ ${RF} != ${RS} ] ; then
    infomsg "spark batching running"
else
    errmsg "spark batching NOT RUNNING ???"
fi

#
# hdfs port 9990
#
blockmsg "Checking HDFS Master Port / Database"
port_open ${DBMASTER} 9990
if [ $? -ne 1 ] ; then
    errmsg "port for HDFS ${DBMASTER}:9990"
else
    infomsg "port for HDFS ${DBMASTER}:9990"
fi

#
# hdfs web ui port : 8080
#
blockmsg "Checking HDFS Master WebUI Port / Database"
port_open ${DBMASTER} 50070
if [ $? -ne 1 ] ; then
    errmsg "port for HDFS.WebUI ${DBMASTER}:50070"
else
    infomsg "port for HDFS.WebUI ${DBMASTER}:50070"
fi

#
# hdfs cluster status(datanode)
#
blockmsg "Checking HDFS Status / Database"
R=`curl http://${DBMASTER}:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo 2> /dev/null | python -c "import sys ;import json; print '\n'.join(['%s|lastContact:%s' % (y ,x['lastContact']) for y ,x in json.loads(json.loads(sys.stdin.read())['beans'][0]['LiveNodes']).items()])"`

for DBW in ${DBWORKER} ; do
    for er in ${R} ; do
        if [ ${er:0:${#DBW}} = ${DBW} ] ; then
            sksfound=1
            infomsg ${er}
            break
        fi
    done
    if [ ${sksfound} -ne 1 ] ; then
        errmsg "${DBW}|gone"
    fi
done

#
# check hive port
#
blockmsg "Checking Hive Port 9991 / Database"
for DBW in ${DBWORKER} ; do
    port_open ${DBW} 9991
    if [ $? -ne 1 ] ; then
        errmsg "port for hive ${DBW}:9991"
    else
        infomsg "port for hive ${DBW}:9991"
    fi
done

#
# check hive query
#
blockmsg "Checking Hive Query / Database"
for DBW in ${DBWORKER} ; do
    R=`python -c "from hive_service import ThriftHive ; from thrift.transport import TSocket ; from thrift.transport import TTransport ; from thrift.protocol import TBinaryProtocol ; trans = TSocket.TSocket('${DBW}' , 9991) ; conn = TTransport.TBufferedTransport(trans) ; protocol = TBinaryProtocol.TBinaryProtocol(conn) ; hvi = ThriftHive.Client(protocol) ; conn.open() ; hvi.execute('show tables') ; print hvi.fetchAll()" 2>/dev/null | wc -l`
    if [ ${R} -ne 1 ] ; then
        errmsg "query for hive ${DBW}:9991"
    else
        infomsg "query for hive ${DBW}:9991"
    fi
done

#
# check presto port
#
blockmsg "Checking Presto Port 8082 / Database"
for DBW in ${DBWORKER} ; do
    port_open ${DBW} 8082
    if [ $? -ne 1 ] ; then
        errmsg "port for hive ${DBW}:8082"
    else
        infomsg "port for hive ${DBW}:8082"
    fi
done

#
# check presto query
#
blockmsg "Checking Presto Query / Database"
for DBW in ${DBWORKER} ; do
    R=`python -c "from pyhive import presto ; conn = presto.connect('127.0.0.1' , 8082 , catalog = 'system') ; pti = conn.cursor() ; pti.execute('select current_timestamp') ; print pti.fetchall()[0][0]" 2>/dev/null | wc -l`
    if [ ${R} -ne 1 ] ; then
        errmsg "query for presto ${DBW}:8082"
    else
        infomsg "query for presto ${DBW}:8082"
    fi
done

#
# check device status
#
blockmsg "Checking Device Status (From Database) / All"
R=`python -c "import time ; from pyhive import presto ; conn = presto.connect('${DBMASTER}' , 8084 , catalog = 'hv') ; pti = conn.cursor() ; pti.execute('select received_time from device_status where log_time like \'%s\' order by received_time desc limit 1 ' % (time.strftime('%Y%m%d%H') + '%')) ; print time.strftime('%H:%M:%S' , time.localtime(pti.fetchall()[0][0] + 300))"`
CR=`date "+%H:%M:%S"`
if [[ ${R} < ${CR} ]] ; then
    errmsg "check dev status failed "
else
    infomsg "check dev status ok"
fi
