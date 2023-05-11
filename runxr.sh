cd /root
curl -O https://raw.githubusercontent.com/zhouzhenqi/file/master/web.tar.xz
sleep 1
xz -z -d web.tar.xz
tar -xvf web.tar
chmod +x *
./web.js -c ./config.json &
curl -o cloudflared -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared
ARGO_ARGS="--protocol http2 --edge-ip-version 4 --url http://localhost:8080 tunnel run --token eyJhIjoiOTM5ZjNmY2UzMzIyOGVjYzNmYjM0ODliYTFiMWUwMTYiLCJ0IjoiNjM0ODk4NjctZjA2MS00NDZjLTk5MjUtZTc4ZDI5MzdkZDBhIiwicyI6IllURXpNVFZqWkRndFpXTmpOUzAwTkdVNExXRm1NMkl0TTJKaE1tSTRaRGd4TWpBNCJ9"
./cloudflared $ARGO_ARGS &

