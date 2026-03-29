cmd /c

MsiExec.exe /X{6E8FC8BD9D0A93CF} /norestart /qn
MsiExec.exe /X{FC5E1D1D-6D3F-4844-A937-567D589F655E} /q /passive

"C:\Program Files\SysAid\uninstallagent.cmd"

del "%userprofile%\Desktop\SysAid.lnk"
del "C:\Users\Public\Desktop\SysAid.lnk"
del "%userprofile%\Desktop\SysAid.lnk"

sc stop SysAidAgent
sc delete SysAidAgent

taskkill /f /im ilias.exe
taskkill /f /im SysAidWorker.exe
taskkill /F /IM SysAidSM.exe

rd /S /Q "C:\Program Files\SysAid"
rd /S /Q "C:\Program Files (x86)\SysAid"

start /wait "" "c:\temp\SysAidAgent.exe" /VERYSILENT /URL https://wizo.sysaidit.com /account wizo /serial 34A24AB423CA87B7 /AllowRemoteControl N /SubmitSRShortcut "HelpDesk" /HotKey 624 /Interval 30 /ConfirmRC N /RandomMachineID N /AllowSubmitSR Y

REM. > "C:\Program Files\SysAid\Flag.txt"

goto end

:end
exit