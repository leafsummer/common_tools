#!/bin/bash
service dnsmasq start
sh /root/updateddnsmasq.sh
# Let the container live.
while [ 1 ];
do
  sleep 10
done