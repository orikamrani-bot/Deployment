@echo off
set LOG=C:\Temp\SysAid_Task_Test.log

echo ==== START %date% %time% ==== > "%LOG%"
whoami >> "%LOG%" 2>&1
echo USERPROFILE=%USERPROFILE% >> "%LOG%" 2>&1
echo SESSIONNAME=%SESSIONNAME% >> "%LOG%" 2>&1

if not exist "C:\Temp\SysAidAgent.exe" (
    echo SysAidAgent.exe not found >> "%LOG%"
    exit /b 2
)

"C:\Temp\SysAidAgent.exe" /VERYSILENT /URL https://wizo.sysaidit.com /account wizo /serial 34A24AB423CA87B7 /AllowRemoteControl N /SubmitSRShortcut "HelpDesk" /HotKey 634 /Interval 30 /ConfirmRC N /RandomMachineID N /AllowSubmitSR Y >> "%LOG%" 2>&1

echo EXITCODE=%ERRORLEVEL% >> "%LOG%"
echo ==== END %date% %time% ==== >> "%LOG%"
exit /b %ERRORLEVEL%