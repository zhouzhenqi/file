#!/bin/bash  
  
while true  
do   
    procnum=` ps -ef|grep "haproxy"|grep -v grep|wc -l`  
   if [ $procnum -eq 0 ]; then  
   service haproxy-lkl start
   fi  
   sleep 5  
done 
