@echo off
if "%1"=="start" (
REM Windows 下无效
REM set PHP_FCGI_CHILDREN=5

REM 每个进程处理的最大请求数，或设置为 Windows 环境变量
set PHP_FCGI_MAX_REQUESTS=1000
 
echo Starting PHP FastCGI...
RunHiddenConsole E:\php-5.6.6-Win32-VC11-x64\php-cgi.exe -b 127.0.0.1:9000 -c E:\php-5.6.6-Win32-VC11-x64\php.ini
 
echo Starting nginx...
RunHiddenConsole E:\nginx-1.6.2\nginx.exe -p E:\nginx-1.6.2\
) 
if "%1"=="stop" (
echo Stopping nginx...  
taskkill /F /IM nginx.exe > nul
echo Stopping PHP FastCGI...
taskkill /F /IM php-cgi.exe > nul
)