@echo off

:: עצירת שירותים ותהליכים קיימים
sc stop SysAidAgent >nul 2>&1
sc delete SysAidAgent >nul 2>&1
taskkill /f /im ilias.exe /t >nul 2>&1
taskkill /f /im SysAidWorker.exe /t >nul 2>&1
taskkill /f /im SysAidSM.exe /t >nul 2>&1

:: ניקוי תיקיות וקיצורי דרך
rd /S /Q "C:\Program Files\SysAid" >nul 2>&1
rd /S /Q "C:\Program Files (x86)\SysAid" >nul 2>&1
del /f /q "C:\Users\Public\Desktop\HelpDesk.lnk" >nul 2>&1

:: ההתקנה עצמה - שים לב לשינוי הפרמטרים לפורמט הסטנדרטי של SysAid
echo Starting Installation...
"c:\temp\SysAidAgent.exe" /i /quiet URL=https://wizo.sysaidit.com ACCOUNT=wizo SERIAL=34A24AB423CA87B7 ALLOWREMOTECONTROL=N SUBMITSRSHORTCUT="HelpDesk" HOTKEY=624 INTERVAL=30 CONFIRMRC=N RANDOMMACHINEID=N ALLOWSUBMITSR=Y

:: יצירת קובץ דגל לאישור התקנה
if not exist "C:\Program Files\SysAid" mkdir "C:\Program Files\SysAid"
echo Installed on %date% %time% > "C:\Program Files\SysAid\Flag.txt"

exit