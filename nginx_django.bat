@echo off
if "%1"=="start" (
echo Starting django FastCGI...
cd /d I:\Workplace\leafos\
RunHiddenConsole python manage.py runfcgi method=threaded host=127.0.0.1 port=8051
REM cd /d "%HOMEDRIVE%%HOMEPATH%"

echo Starting nginx...
RunHiddenConsole E:\nginx-1.6.2\nginx.exe -p E:\nginx-1.6.2\
) 
if "%1"=="stop" (
echo Stopping nginx...  
taskkill /F /IM nginx.exe > nul
echo Stopping django FastCGI...
taskkill /F /IM python.exe > nul
)