#!/bin/bash  
  
while true  
do   
    procnum=` ps -ef|grep "ngrokd"|grep -v grep|wc -l`  
   if [ $procnum -eq 0 ]; then  
       /usr/local/ngrok/bin/ngrokd -domain="209zzq.cn" -httpAddr=":88" -httpsAddr=":8443" -tunnelAddr=":8008" > /dev/null 2>&1 &  
   fi  
   sleep 30  
done 
