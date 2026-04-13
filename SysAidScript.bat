

    start /wait "" "C:\temp\SysAidAgent.exe" /VERYSILENT /URL https://wizo.sysaidit.com /account wizo /serial 34A24AB423CA87B7 /AllowRemoteControl N /SubmitSRShortcut "HelpDesk" /HotKey 634 /Interval 30 /ConfirmRC N /RandomMachineID N /AllowSubmitSR Y
    echo install done, error=%errorlevel%
