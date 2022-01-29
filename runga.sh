cd /root
wget -O github-ct.rar https://raw.githubusercontent.com/zhouzhenqi/file/master/github-ct.rar
sleep 1
apt update
apt install -y unrar
sleep 1
unrar x github-ct.rar
mv cloudtorrent/ /etc/
cd /etc/cloudtorrent/
chmod +x *
./runct.sh &
name=$(cat /etc/hostname)
pport=$(echo $name | awk -F- '{print $3}')
sed -i "s/http-80/"$name"-80/g" /etc/cloudtorrent/frpc.ini
sed -i "s/tcp-5007/"$name"-5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/udp-5007/"$name"-u5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/6080/6"$pport"/g" /etc/cloudtorrent/frpc.ini
sed -i "s/remote_port = 5007/remote_port = 6"$pport"/g" /etc/cloudtorrent/frpc.ini
/etc/cloudtorrent/frpc -c /etc/cloudtorrent/frpc.ini &
sleep 2
apt -y autoremove docker docker-ce docker-engine  docker.io  containerd runc
apt -y autoremove git
rm -rf /var/lib/docker/*
apt -y remove git
apt -y purge git
apt -y autoremove
apt clean
apt autoclean
apt update
apt -y install nload
nload eth0 -m -u M
