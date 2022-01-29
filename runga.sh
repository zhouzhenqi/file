cd /root
#wget https://zhouzhenqi.coding.net/p/file/d/file/git/raw/master/ct.tar.bz2
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

