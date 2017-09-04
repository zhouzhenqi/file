#!/bin/sh
export PATH='/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin'
export LD_LIBRARY_PATH=/lib:/opt/lib
echo "【kcptun】" "更新开始"
logger -t "【kcptun】" "更新开始"
echo "【kcptun】" "正在查询最新kcptun版本"
logger -t "【kcptun】" "正在查询最新kcptun版本"
KCP_VER=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep 'tag_name' | head -n 1 | cut -d\" -f4)
if [ -z $KCP_VER ]
then
     echo "【kcptun】" "获取最新kcptun版本失败，请检查网络连接 "
	 logger -t "【kcptun】" "获取最新kcptun版本失败，请检查网络连接 "
     exit 0
else
     echo "【kcptun】" "最新的kcptun版本为$KCP_VER "
	 logger -t "【kcptun】" "最新的kcptun版本为$KCP_VER "
fi
echo "【kcptun】" "正在判断当前系统是否存在kcptun程序文件 "
logger -t "【kcptun】" "正在判断当前系统是否存在kcptun程序文件 "
kcptun="/opt/bin/client_linux_mips"
if [ -f $kcptun ]
then
    echo "【kcptun】" "存在kcptun程序文件，正在判断是否为最新版本"
	logger -t "【kcptun】" "存在kcptun程序文件，正在判断是否为最新版本"
	LOCAL_KCP_VER="v$($kcptun -v | cut -d " " -f3)"
    echo "【kcptun】" "当前系统kcptun版本为$LOCAL_KCP_VER"
	logger -t "【kcptun】" "当前系统kcptun版本为$LOCAL_KCP_VER"
    if [ "$LOCAL_KCP_VER" == "$KCP_VER" ]
    then
        echo "【kcptun】" "当前系统kcptun已是最新版本"
		logger -t "【kcptun】" "当前系统kcptun已是最新版本"
	    exit 0
    else
        echo "【kcptun】" "当前系统kcptun不是最新版本，需要更新"
        logger -t "【kcptun】" "当前系统kcptun不是最新版本，需要更新"		
    fi
else
    echo "【kcptun】" "当前系统不存在 kcptun程序 "
    logger -t "【kcptun】" "当前系统不存在 kcptun程序 "
fi
echo "【kcptun】" "正在获取最新版本kcptun程序 "
logger -t "【kcptun】" "正在获取最新版本kcptun程序 "
kcp_linux_mipsle="kcptun-linux-mipsle-$(echo ${KCP_VER} | sed -e 's/^[a-zA-Z]//g')"
output=/opt/bin/kcptun-linux-mipsle.tar.gz
url1=https://github.com/xtaci/kcptun/releases/download/$KCP_VER/$kcp_linux_mipsle.tar.gz
url2=$2
[ -z "$url2" ] && url2=$url1
rm -f $output
if [ ! -f "/usr/sbin/curl" ] ; then
        /usr/sbin/curl -L -k -s -o $output $url1
fi
if [ -f "/opt/bin/curl" ] && [ ! -s "$output" ] ; then
        export LD_LIBRARY_PATH=/opt/lib:/lib
        /opt/bin/curl -L -k -s -o $output $url1
        export LD_LIBRARY_PATH=/lib:/opt/lib
fi
if [ ! -s "$output" ] ; then
        wget --continue --no-check-certificate  -O $output $url1
fi
if [ ! -s "$output" ] ; then
        echo "【下载】" "下载失败:【$output】 URL:【$url1】"
        echo "【下载】" "重新下载:【$output】 URL:【$url2】"
        logger -t "【下载】" "下载失败:【$output】 URL:【$url1】"
        logger -t "【下载】" "重新下载:【$output】 URL:【$url2】"
        rm -f $output
        if [ ! -f "/usr/sbin/curl" ] ; then
                /usr/sbin/curl -L -k -s -o $output $url2
        fi
        if [ -f "/opt/bin/curl" ] && [ ! -s "$output" ] ; then
                export LD_LIBRARY_PATH=/opt/lib:/lib
                /opt/bin/curl -L -k -s -o $output $url2
                export LD_LIBRARY_PATH=/lib:/opt/lib
        fi
        if [ ! -s "$output" ] ; then
                wget --continue --no-check-certificate  -O $output $url2
        fi
fi
if [ ! -s "$output" ] ; then
        echo "【下载】" "下载失败:【$output】 URL:【$url2】"
        logger -t "【下载】" "下载失败:【$output】 URL:【$url2】"
else
        chmod 777 $output
		echo "【kcptun】" "下载最新版本kcptun成功"
        logger -t "【kcptun】" "下载最新版本kcptun成功"
fi
tar zxvf /opt/bin/kcptun-linux-mipsle.tar.gz -C /opt/bin/ client_linux_mipsle 
mv /opt/bin/client_linux_mipsle /opt/bin/client_linux_mips && logger -t "【kcptun】" "解压最新版本kcptun程序成功"
echo "【kcptun】" "解压最新版本kcptun成功"
chmod 755 /opt/bin/client_linux_mips && logger -t "【kcptun】" "修改kcptun程序权限成功"
echo "【kcptun】" "修改kcptun程序权限成功"
rm -rf /opt/bin/kcptun-linux-mipsle.tar.gz && logger -t "【kcptun】" "删除下载的压缩包成功"
echo "【kcptun】" "删除下载的压缩包成功"
UP_KCP_VER="v$($kcptun -v | cut -d " " -f3)"
echo "【kcptun】" "更新kcptun程序完成，当前系统kcptun程序已更新为$UP_KCP_VER"
logger -t "【kcptun】" "更新kcptun程序完成，当前系统kcptun程序已更新为$UP_KCP_VER"
echo "【kcptun】" "开始重启kcptun"
logger -t "【kcptun】" "开始重启kcptun"
/etc/storage/script/Sh14_kcp_tun.sh start &

