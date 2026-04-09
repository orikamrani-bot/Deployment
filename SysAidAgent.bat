@echo off
set LOG=C:\Temp\SysAid_Atera.log

echo ==== START %date% %time% ==== >> "%LOG%"

whoami >> "%LOG%" 2>&1
echo USERPROFILE=%USERPROFILE% >> "%LOG%"
echo COMPUTERNAME=%COMPUTERNAME% >> "%LOG%"
echo. >> "%LOG%"

echo [1] Uninstall MSI >> "%LOG%"
MsiExec.exe /X {FC5E1D1D-6D3F-4844-A937-567D589F655E} /qn /norestart >> "%LOG%" 2>&1
echo ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"

echo [2] uninstallagent.cmd >> "%LOG%"
if exist "C:\Program Files\SysAid\uninstallagent.cmd" (
    call "C:\Program Files\SysAid\uninstallagent.cmd" >> "%LOG%" 2>&1
    echo ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"
) else (
    echo uninstallagent.cmd not found >> "%LOG%"
)

echo [3] Delete shortcuts >> "%LOG%"
del "%userprofile%\Desktop\SysAid.lnk" /f /q >> "%LOG%" 2>&1
del "C:\Users\Public\Desktop\SysAid.lnk" /f /q >> "%LOG%" 2>&1
echo ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"

echo [4] Stop/Delete service >> "%LOG%"
sc stop SysAidAgent >> "%LOG%" 2>&1
echo STOP ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"
sc delete SysAidAgent >> "%LOG%" 2>&1
echo DELETE ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"

echo [5] Kill processes >> "%LOG%"
taskkill /f /im ilias.exe >> "%LOG%" 2>&1
taskkill /f /im SysAidWorker.exe >> "%LOG%" 2>&1
taskkill /f /im SysAidSM.exe >> "%LOG%" 2>&1

echo [6] Remove folders >> "%LOG%"
rd /S /Q "C:\Program Files\SysAid" >> "%LOG%" 2>&1
rd /S /Q "C:\Program Files (x86)\SysAid" >> "%LOG%" 2>&1

echo [7] Install new agent >> "%LOG%"
if exist "C:\temp\SysAidAgent.exe" (
    start /wait "" "C:\temp\SysAidAgent.exe" /VERYSILENT /URL https://wizo.sysaidit.com /account wizo /serial 34A24AB423CA87B7 /AllowRemoteControl N /SubmitSRShortcut "HelpDesk" /HotKey 634 /Interval 30 /ConfirmRC N /RandomMachineID N /AllowSubmitSR Y >> "%LOG%" 2>&1
    echo INSTALL ERRORLEVEL=%ERRORLEVEL% >> "%LOG%"
) else (
    echo SysAidAgent.exe not found in C:\temp >> "%LOG%"
)

echo ==== END %date% %time% ==== >> "%LOG%"
exit /b 0