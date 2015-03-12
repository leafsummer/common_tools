@echo off
set a=%1
set temp=%a:I:\ESPP\=/opt/disk2/var/www/%
set b=%temp:\=/%
echo %b%
if exist %a%\. (
G:\ssh_tool\pscp.exe -p -i G:\ssh_tool\ssh_key\rsa_ppk.ppk -r %1 root@10.67.2.243:/opt/disk2/var/www/
) else (
G:\ssh_tool\pscp.exe -p -i G:\ssh_tool\ssh_key\rsa_ppk.ppk -f %1 root@10.67.2.243:/opt/disk2/var/www/
) 
exit /b 0