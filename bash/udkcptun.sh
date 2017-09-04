#!/bin/sh
export PATH='/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin'
export LD_LIBRARY_PATH=/lib:/opt/lib
KCP_VER=$1
echo "【kcptun】" "当前设定kcptun版本 $KCP_VER "
logger -t "【kcptun】" "当前设定kcptun版本 $KCP_VER "
kcptun="/opt/bin/client_linux_mips"
if [ -f $kcptun ]
then
    rm -rf /opt/bin/client_linux_mips
	echo "【kcptun】" "删除原来的 client_linux_mips"
    logger -t "【kcptun】" "删除原来的 client_linux_mips"
else
    echo "【kcptun】" "不存在 client_linux_mips"
    logger -t "【kcptun】" "不存在 client_linux_mips"
fi
echo "【kcptun】" "获取最新 client_linux_mips"
logger -t "【kcptun】" "获取最新 client_linux_mips"
output=/opt/bin/kcptun-linux-mipsle.tar.gz
url1=https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-mipsle-$KCP_VER.tar.gz
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
		echo "【kcptun】" "下载最新 client_linux_mips 成功"
        logger -t "【kcptun】" "下载最新 client_linux_mips 成功"
fi
tar zxvf /opt/bin/kcptun-linux-mipsle.tar.gz -C /opt/bin/ client_linux_mipsle 
mv /opt/bin/client_linux_mipsle /opt/bin/client_linux_mips && logger -t "【kcptun】" "解压最新 client_linux_mips 成功"
echo "【kcptun】" "解压最新 client_linux_mips 成功"
chmod 755 /opt/bin/client_linux_mips && logger -t "【kcptun】" "修改 client_linux_mips 权限成功"
echo "【kcptun】" "修改 client_linux_mips 权限成功"
rm -rf /opt/bin/kcptun-linux-mipsle.tar.gz && logger -t "【kcptun】" "删除下载的压缩包成功"
echo "【kcptun】" "删除下载的压缩包成功"
logger -t "【kcptun】" "更新 client_linux_mips 完成"
echo "【kcptun】" "更新 client_linux_mips 完成"
