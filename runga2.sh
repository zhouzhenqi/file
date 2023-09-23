cd /root
mkdir -p /sys/fs/cgroup/downloads
curl -O https://raw.githubusercontent.com/zhouzhenqi/file/master/ct2.tar.xz
sleep 1
xz -z -d ct2.tar.xz
tar -xvf ct2.tar
mv cloudtorrent/ /etc/
cd /etc/cloudtorrent/
chmod +x *
echo "13.107.136.9 209zzq-my.sharepoint.com" >> /etc/hosts
name=$(cat /etc/hostname)
b=$(($RANDOM%10))
s=$(($RANDOM%10))
g=$(($RANDOM%10))
pport="$b$s$g"
echo $pport
sed -i "s/http-80/6"$pport"-80/g" /etc/cloudtorrent/frpc.ini
sed -i "s/tcp-5007/"$name"-5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/udp-5007/"$name"-u5007/g" /etc/cloudtorrent/frpc.ini
sed -i "s/6080/6"$pport"/g" /etc/cloudtorrent/frpc.ini
sed -i "s/5007/5"$pport"/g" /etc/cloudtorrent/frpc.ini
sed -i "s/5007/5"$pport"/g" /etc/cloudtorrent/cloud-torrent.yaml
#sed -i 's;/etc/cloudtorrent/downloads;/sys/fs/cgroup/downloads;g' /etc/cloudtorrent/cloud-torrent.yaml
./runct.sh &
/etc/cloudtorrent/frpc -c /etc/cloudtorrent/frpc.ini &
yum-config-manager --disable kubernetes
yum install passwd openssl openssh-server -y
ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo -e "Docker@1qaz\nDocker@1qaz" | (passwd root) 
echo 123456 | passwd --stdin root
killall sshd
/usr/sbin/sshd -D &
#yum clean all

