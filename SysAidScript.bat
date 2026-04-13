@echo off
echo Start script
pause

MsiExec.exe /X {FC5E1D1D-6D3F-4844-A937-567D589F655E} /qn /norestart
echo msiexec done, error=%errorlevel%
pause

IF EXIST "C:\Program Files\SysAid\uninstallagent.cmd" (
    call "C:\Program Files\SysAid\uninstallagent.cmd"
    echo uninstallagent done, error=%errorlevel%
) ELSE (
    echo uninstallagent.cmd not found
)
pause

sc stop SysAidAgent
echo sc stop error=%errorlevel%
pause

sc delete SysAidAgent
echo sc delete error=%errorlevel%
pause

IF EXIST "C:\temp\SysAidAgent.exe" (
    start /wait "" "C:\temp\SysAidAgent.exe" /VERYSILENT /URL https://wizo.sysaidit.com /account wizo /serial 34A24AB423CA87B7 /AllowRemoteControl N /SubmitSRShortcut "HelpDesk" /HotKey 634 /Interval 30 /ConfirmRC N /RandomMachineID N /AllowSubmitSR Y
    echo install done, error=%errorlevel%
) ELSE (
    echo SysAidAgent.exe not found
)
pause