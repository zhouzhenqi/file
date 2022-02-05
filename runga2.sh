cd /root
yum -y install bzip2 screen
curl -O https://raw.githubusercontent.com/zhouzhenqi/file/master/ct2.tar.bz2
sleep 1
tar -jxvf ct2.tar.bz2
mv cloudtorrent/ /etc/
cd /etc/cloudtorrent/
chmod +x *
echo "13.107.136.9 209zzq-my.sharepoint.com" >> /etc/hosts
name=$(cat /etc/hostname)
b=$(($RANDOM%10))
s=$(($RANDOM%10))
g=$(($RANDOM%10))
pport="$b$s$g"
sed -i "s/http-80/"$name"-80/g" /etc/cloudtorrent/frpc.ini
sed -i "s/tcp-5007/"$name"-5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/udp-5007/"$name"-u5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/6080/6"$pport"/g" /etc/cloudtorrent/frpc.ini
sed -i "s/5007/5"$pport"/g" /etc/cloudtorrent/frpc.ini
sed -i "s/5007/5"$pport"/g" /etc/cloudtorrent/cloud-torrent.yaml
./runct.sh &
/etc/cloudtorrent/frpc -c /etc/cloudtorrent/frpc.ini &

