#!/bin/sh 
export PATH='/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin'
export LD_LIBRARY_PATH=/lib:/opt/lib

rm -rf /etc/storage/dnsmasq/hosts
cp /etc/storage/dnsmasq/hostsback /etc/storage/dnsmasq/hosts

#重启dnsmasq
restart_dhcpd
logger -t "【hosts】" "已还原 "
echo " 已还原"
