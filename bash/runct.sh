#!/bin/bash

while true
do
    procnum=` ps -ef|grep "cloud-torrent"|grep -v grep|wc -l`
   if [ $procnum -eq 0 ]; then
       /etc/cloudtorrent/cloud-torrent -p 8000 -l >> /dev/null 2>&1 &
   fi
   sleep 30
done

