@echo off
echo Installing MSI...
start /wait msiexec.exe /i "C:\temp\SysAidAgent.msi" /qn URL="https://wizo.sysaidit.com" ACCOUNT="wizo" SERIAL="34A24AB423CA87B7" ALLOWREMOTECONTROL="N" /norestart

echo Configuring Registry...
set "REG_KEY=HKEY_LOCAL_MACHINE\SOFTWARE\SysAid"
reg add "%REG_KEY%" /v "ServerURL" /t REG_SZ /d "https://wizo.sysaidit.com" /f
reg add "%REG_KEY%" /v "AccountID" /t REG_SZ /d "wizo" /f
reg add "%REG_KEY%" /v "HotKey" /t REG_SZ /d "624" /f

net start SysAidAgent
exit /b 0