@echo OFF&CLS
color 0a
Title Ngrok��������
Mode con cols=109 lines=30
:START
ECHO.
Echo                   =====================================================================
ECHO.                                                                                                 
Echo                        Ngrok�ͻ����������� by zzq������QQ��823464517��
ECHO.
Echo                   =====================================================================
:TUNNEL
echo   ������Ҫת�������ͣ���������Ҫ�����������ַ���
echo.
echo      ����1��http
echo.
echo      ����2��https
echo.
echo      ����3��tcp
echo.
echo      ����4���˳�
echo.
echo.
set /p number=�������֣�
if /i "%number%"=="1" goto 1
if /i "%number%"=="2" goto 2
if /i "%number%"=="3" goto 3
if /i "%number%"=="4" goto 4
echo �������&pause&%0
:1
cls
echo    ��������Զ����������ӱ���������ַ�Ͷ˿�
echo.
set /p subdomain= ���ÿո������ www 192.168.1.1:80����
ngrok.exe -config=ngrok.cfg -proto=http -subdomain=%subdomain% 
PAUSE
goto TUNNEL
:2
cls
echo    ��������Զ����������ӱ���������ַ�Ͷ˿�
echo.
set /p subdomain= ���ÿո������ www 192.168.1.1:80����
ngrok.exe  -config=ngrok.cfg -proto=https -subdomain=%subdomain% 
PAUSE
goto TUNNEL
:3
cls
set /p port= ������ı���������ַ�Ͷ˿ڣ���192.168.1.1:22����
ngrok.exe  -config=ngrok.cfg -proto=tcp %port% 
PAUSE
goto TUNNEL
:4
cls
exit.

