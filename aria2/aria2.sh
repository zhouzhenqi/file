#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
ACTION=$1
#=================================================
#	System Required: CentOS/Debian/Ubuntu
#	Description: Aria2
#=================================================
file="/root/.aria2"
aria2_conf="${file}/aria2.conf"
aria2_log="/root/.aria2/aria2.log"
aria2c="/usr/local/bin/aria2c"

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

#检查系统
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}
check_installed_status(){
	[[ ! -e ${aria2c} ]] && echo -e "${Error} Aria2 没有安装，请检查 !" && exit 1
	[[ ! -e ${aria2_conf} ]] && echo -e "${Error} Aria2 配置文件不存在，请检查 !" && [[ $1 != "un" ]] && exit 1
}
check_pid(){
	PID=`ps -ef| grep "aria2c"| grep -v grep| grep -v ".sh"| grep -v "init.d"| grep -v "service"| awk '{print $2}'`
}
Download_aria2(){
	mkdir "${file}" && cd "${file}"
	if [ ${bit} == "x86_64" ]; then
	wget --no-check-certificate -N "https://coding.net/u/zhouzhenqi/p/shell-scripts/git/raw/master/aria2/aria2-64.tar.bz2"
	[[ ! -s "aria2-64.tar.bz2" ]] && echo -e "${Error} Aria2 压缩文件下载失败，重新下载!" && rm -rf "${file}"/* \
	&& wget --no-check-certificate -N "https://raw.githubusercontent.com/zhouzhenqi/file/master/aria2/aria2-64.tar.bz2"
	elif [ ${bit} == "i386" ]; then
	wget --no-check-certificate -N "https://coding.net/u/zhouzhenqi/p/shell-scripts/git/raw/master/aria2/aria2-32.tar.bz2"
	[[ ! -s "aria2-32.tar.bz2" ]] && echo -e "${Error} Aria2 压缩文件下载失败，重新下载 !" && rm -rf "${file}"/* \
	&& wget --no-check-certificate -N "https://raw.githubusercontent.com/zhouzhenqi/file/master/aria2/aria2-32.tar.bz2"
	elif [ ${bit} == "i686" ]; then
	wget --no-check-certificate -N "https://coding.net/u/zhouzhenqi/p/shell-scripts/git/raw/master/aria2/aria2-32.tar.bz2"
	[[ ! -s "aria2-32.tar.bz2" ]] && echo -e "${Error} Aria2 压缩文件下载失败，重新下载 !" && rm -rf "${file}"/* \
	&& wget --no-check-certificate -N "https://raw.githubusercontent.com/zhouzhenqi/file/master/aria2/aria2-32.tar.bz2"
	fi
	tar -jxvf aria2-*.tar.bz2
	[[ ! -s "aria2c" ]] && echo -e "${Error} Aria2 文件下载安装失败 !请检查网络和dns" && rm -rf "${file}" && exit 1
    echo '' > aria2.session
    mv -f aria2c  /usr/local/bin/
	mv -f ca-certificates.crt /etc/ssl/certs/
	chmod 755 /usr/local/bin/aria2c
}
Service_aria2(){
	if [[ ${release} = "centos" ]]; then
		if ! wget --no-check-certificate https://coding.net/u/zhouzhenqi/p/shell-scripts/git/raw/master/aria2/aria2_centos -O /etc/init.d/aria2; then
			echo -e "${Error} Aria2服务 管理脚本下载失败 ,重新下载!" \
			&& wget --no-check-certificate https://raw.githubusercontent.com/zhouzhenqi/file/master/aria2/aria2_centos -O /etc/init.d/aria2
		fi
		[[ ! -s "/etc/init.d/aria2" ]] && echo -e "${Error} Aria2服务 管理脚本下载失败 !" && exit 1
		chmod +x /etc/init.d/aria2
		chkconfig --add aria2
		chkconfig aria2 on
	else
		if ! wget --no-check-certificate https://coding.net/u/zhouzhenqi/p/shell-scripts/git/raw/master/aria2/aria2_debian -O /etc/init.d/aria2; then
			echo -e "${Error} Aria2服务 管理脚本下载失败 ,重新下载!" \
			&& wget --no-check-certificate https://raw.githubusercontent.com/zhouzhenqi/file/master/aria2/aria2_debian -O /etc/init.d/aria2
		fi
		[[ ! -s "/etc/init.d/aria2" ]] && echo -e "${Error} Aria2服务 管理脚本下载失败 !" && exit 1
		chmod +x /etc/init.d/aria2
		update-rc.d -f aria2 defaults
	fi
	echo -e "${Info} Aria2服务 管理脚本下载完成 !"
}
Installation_dependency(){
	if [[ ${release} = "centos" ]]; then
		yum update -y
		yum install curl unzip vim -y
	elif [[ ${release} = "debian" ]]; then
		apt-get update -y
		apt-get install  curl unzip vim -y
	else
		apt-get update -y
		apt-get install curl unzip vim -y
    fi
}
Install_aria2(){
	[[ -e ${aria2c} ]] && echo -e "${Error} Aria2 已安装，请检查 !" && exit 1
	check_sys
	echo -e "${Info} 开始安装/配置 依赖..."
	Installation_dependency
	echo -e "${Info} 开始下载/安装 配置文件..."
	Download_aria2
	echo -e "${Info} 开始下载/安装 服务脚本(init)..."
	Service_aria2
	Read_config
	echo -e "${Info} 开始设置 iptables防火墙..."
	Set_iptables
	echo -e "${Info} 开始添加 iptables防火墙规则..."
	Add_iptables
	echo -e "${Info} 开始保存 iptables防火墙规则..."
	Save_iptables
	echo -e "${Info} 所有步骤 安装完毕，开始启动..."
	Start_aria2
}
Start_aria2(){
	check_installed_status
	check_pid
	[[ ! -z ${PID} ]] && echo -e "${Error} Aria2 正在运行，请检查 !" && exit 1
	/etc/init.d/aria2 start
}
Stop_aria2(){
	check_installed_status
	check_pid
	[[ -z ${PID} ]] && echo -e "${Error} Aria2 没有运行，请检查 !" && exit 1
	/etc/init.d/aria2 stop
}
Restart_aria2(){
	check_installed_status
	check_pid
	[[ ! -z ${PID} ]] && /etc/init.d/aria2 stop
	/etc/init.d/aria2 start
}
Set_aria2(){
	check_installed_status
	vim ${aria2_conf}
	Restart_aria2
}
Read_config(){
	[[ ! -e ${aria2_conf} ]] && echo -e "${Error} Aria2 配置文件不存在 !" && exit 1
	conf_text=$(cat ${aria2_conf}|grep -v '#')
	aria2_dir=$(echo -e "${conf_text}"|grep "dir="|awk -F "=" '{print $NF}')
	aria2_rpc_port=$(echo -e "${conf_text}"|grep "rpc-listen-port="|awk -F "=" '{print $NF}')
	aria2_rpc_secret=$(echo -e "${conf_text}"|grep "rpc-secret="|awk -F "=" '{print $NF}')
}
View_Log(){
	[[ ! -e ${aria2_log} ]] && echo -e "${Error} Aria2 日志文件不存在 !" && exit 1
	echo && echo -e "${Tip} 按 ${Red_font_prefix}Ctrl+C${Font_color_suffix} 终止查看日志" && echo
	tail -f ${aria2_log}
}
Uninstall_aria2(){
	check_installed_status "un"
	echo "确定要卸载 Aria2 ? (y/N)"
	echo
	stty erase '^H' && read -p "(默认: n):" unyn
	[[ -z ${unyn} ]] && unyn="n"
	if [[ ${unyn} == [Yy] ]]; then
		check_pid
		[[ ! -z $PID ]] && kill -9 ${PID}
		check_sys
		if [[ ${release} = "centos" ]]; then
			chkconfig --del aria2
		else
		    update-rc.d -f aria2 remove
		fi
		rm -rf /etc/init.d/aria2
	    rm -rf /usr/local/bin/aria2c
		rm -rf /etc/ssl/certs/ca-certificates.crt
	    Read_config
		Del_iptables
		Save_iptables
		rm -rf ${file}

		echo && echo "Aria2 卸载完成 !" && echo
	else
		echo && echo "卸载已取消..." && echo
	fi
}
Add_iptables(){
	iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_rpc_port} -j ACCEPT
	iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${aria2_rpc_port} -j ACCEPT
}
Del_iptables(){
	iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${aria2_rpc_port} -j ACCEPT
	iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${aria2_rpc_port} -j ACCEPT
}
Save_iptables(){
	if [[ ${release} == "centos" ]]; then
		service iptables save
	else
		iptables-save > /etc/iptables.up.rules
	fi
}
Set_iptables(){
	if [[ ${release} == "centos" ]]; then
		service iptables save
		chkconfig --level 2345 iptables on
	elif [[ ${release} == "debian" ]]; then
		iptables-save > /etc/iptables.up.rules
		cat > /etc/network/if-pre-up.d/iptables<<-EOF
#!/bin/bash
/sbin/iptables-restore < /etc/iptables.up.rules
EOF
		chmod +x /etc/network/if-pre-up.d/iptables
	elif [[ ${release} == "ubuntu" ]]; then
		iptables-save > /etc/iptables.up.rules
		echo -e "\npre-up iptables-restore < /etc/iptables.up.rules
post-down iptables-save > /etc/iptables.up.rules" >> /etc/network/interfaces
		chmod +x /etc/network/interfaces
	fi
}
case $ACTION in
install)
	Install_aria2
	;;
unsitall)
	Uninstall_aria2
	;;
start)
    Start_aria2
	;;
stop)
	Stop_aria2
	;;
restart)
	Restart_aria2
	;;
set)
	Set_aria2
	;;
log)
	View_Log
	;;
*)
    echo && echo -e " Aria2 一键安装管理脚本
  
 ${Green_font_prefix}1.${Font_color_suffix} 安装 Aria2
 ${Green_font_prefix}2.${Font_color_suffix} 卸载 Aria2
————————————
 ${Green_font_prefix}3.${Font_color_suffix} 启动 Aria2
 ${Green_font_prefix}4.${Font_color_suffix} 停止 Aria2
 ${Green_font_prefix}5.${Font_color_suffix} 重启 Aria2
————————————
 ${Green_font_prefix}6.${Font_color_suffix} 修改 配置文件
 ${Green_font_prefix}7.${Font_color_suffix} 查看 日志信息
————————————" && echo
    if [[ -e ${aria2c} ]]; then
	    check_pid
	    if [[ ! -z "${PID}" ]]; then
		    echo -e " 当前状态: ${Green_font_prefix}已安装${Font_color_suffix} 并 ${Green_font_prefix}已启动${Font_color_suffix}"
	    else
		    echo -e " 当前状态: ${Green_font_prefix}已安装${Font_color_suffix} 但 ${Red_font_prefix}未启动${Font_color_suffix}"
	    fi
    else
	    echo -e " 当前状态: ${Red_font_prefix}未安装${Font_color_suffix}"
    fi
    echo
    stty erase '^H' && read -p " 请输入数字 [1-7]:" num
    case "$num" in
	1)
	  Install_aria2
	  ;;
	2)
	  Uninstall_aria2
	  ;;
	3)
	  Start_aria2
	  ;;
	4)
	  Stop_aria2
	  ;;
	5)
	  Restart_aria2
	  ;;
	6)
	  Set_aria2
	  ;;
	7)
	  View_Log
	  ;;
	*)
	  echo "请输入正确数字 [1-7]"
	  ;;
    esac
    ;;
esac