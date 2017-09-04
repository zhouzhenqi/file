cd /root
wget https://zzqos.tk/ct.tar.gz
sleep 2
tar -zxvf ct.tar.gz
cd ct
mv cloudtorrent/ /etc/
cd /etc/cloudtorrent/
chmod 777 cloud-torrent runct.sh
sh runct.sh &
#sleep 5
#wget https://raw.githubusercontent.com/kuoruan/shell-scripts/master/ovz-bbr/ovz-bbr-installer.sh
#chmod +x ovz-bbr-installer.sh
#./ovz-bbr-installer.sh
#sleep 5
#apt-get update && apt-get install -y zip unzip
#wget --no-check-certificate -O backuptoqiniu.zip https://softs.fun/Website/backuptoqiniu.zip
#unzip backuptoqiniu.zip && cd backuptoqiniu
#python setup.py install
