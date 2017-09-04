@echo OFF&CLS
color 0a
Title Ngrok启动工具
Mode con cols=109 lines=30
:START
ECHO.
Echo                   =====================================================================
ECHO.                                                                                                 
Echo                        Ngrok客户端启动工具 by zzq制作（QQ：823464517）
ECHO.
Echo                   =====================================================================
:TUNNEL
echo   输入需要转发的类型？（就是你要发布内网哪种服务）
echo.
echo      输入1：http
echo.
echo      输入2：https
echo.
echo      输入3：tcp
echo.
echo      输入4：退出
echo.
echo.
set /p number=输入数字：
if /i "%number%"=="1" goto 1
if /i "%number%"=="2" goto 2
if /i "%number%"=="3" goto 3
if /i "%number%"=="4" goto 4
echo 输入错误&pause&%0
:1
cls
echo    输入你的自定义子域名加本地内网地址和端口
echo.
set /p subdomain= （用空格隔开如 www 192.168.1.1:80）：
ngrok.exe -config=ngrok.cfg -proto=http -subdomain=%subdomain% 
PAUSE
goto TUNNEL
:2
cls
echo    输入你的自定义子域名加本地内网地址和端口
echo.
set /p subdomain= （用空格隔开如 www 192.168.1.1:80）：
ngrok.exe  -config=ngrok.cfg -proto=https -subdomain=%subdomain% 
PAUSE
goto TUNNEL
:3
cls
set /p port= 输入你的本地内网地址和端口（如192.168.1.1:22）：
ngrok.exe  -config=ngrok.cfg -proto=tcp %port% 
PAUSE
goto TUNNEL
:4
cls
exit.

