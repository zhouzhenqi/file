#!/bin/sh
export PATH='/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin'
export LD_LIBRARY_PATH=/lib:/opt/lib
echo "【hosts】" "开始更新hosts"
logger -t "【hosts】" "开始更新hosts"
cd /etc/storage/dnsmasq
wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt -O hostsnew
wget --no-check-certificate https://raw.githubusercontent.com/sy618/hosts/master/FQ -O fq
if [ -f hostsnew ] && [ -f fq ]
then
    echo "【hosts】" "下载最新hosts文件成功，开始合并更新hosts"
	logger -t "【hosts】" "下载最新hosts文件成功，开始合并更新hosts"
	cat fq >> hostsnew
	rm -rf fq
else
     echo "【hosts】" "下载最新hosts文件失败，请检查网络连接 "
	 logger -t "【hosts】" "下载最新hosts文件失败，请检查网络连接 "
	 exit 0
fi
mv hosts hostsold
cat hostsnew >> hosts
sed -i '/^#.*\|^$/d' hosts
sed -i '/^@.*\|^$/d' hosts
sed -i /doub.io/d hosts
echo "【hosts】" "更新host完成"
logger -t "【hosts】" "更新hosts完成"
rm -rf hostsnew
restart_dhcpd


