@echo off
setlocal

set "SERVER_URL=https://wizo.sysaidit.com"
set "ACCOUNT=wizo"
set "SERIAL=34A24AB423CA87B7"
set "HOTKEY=624"
set "MSI_FILE=C:\temp\SysAidAgent.msi"

echo --- Starting SysAid Installation Process ---

:: 1. התקנת ה-MSI
if exist "%MSI_FILE%" (
    echo Installing MSI package...
    start /wait msiexec.exe /i "%MSI_FILE%" /qn URL="%SERVER_URL%" ACCOUNT="%ACCOUNT%" SERIAL="%SERIAL%" ALLOWREMOTECONTROL="N" /norestart
)

:: המתנה של 10 שניות (שיטה שעובדת ב-Atera ללא Input Redirection)
ping 127.0.0.1 -n 10 > nul

:: 2. הזרקת הגדרות ל-Registry
echo Configuring Registry...
set "REG_KEY=HKEY_LOCAL_MACHINE\SOFTWARE\SysAid"
set "REG_KEY64=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SysAid"

for %%G in ("%REG_KEY%" "%REG_KEY64%") do (
    reg add %%G /v "ServerURL" /t REG_SZ /d "%SERVER_URL%" /f
    reg add %%G /v "AccountID" /t REG_SZ /d "%ACCOUNT%" /f
    reg add %%G /v "HotKey" /t REG_SZ /d "%HOTKEY%" /f
    reg add %%G /v "AllowSubmitSR" /t REG_SZ /d "Y" /f
)

:: 3. יצירת קיצור הדרך לכל המשתמשים
echo Creating Desktop Shortcut...
set "LNK_PATH=C:\Users\Public\Desktop\HelpDesk.lnk"
set "TARGET=C:\Program Files\SysAid\SysAidAgent.exe"
set "ARGS=-hotkey %HOTKEY% -url %SERVER_URL% -account %ACCOUNT%"

powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%LNK_PATH%');$s.TargetPath='%TARGET%';$s.Arguments='%ARGS%';$s.IconLocation='%TARGET%,0';$s.Save()"

:: 4. הפעלה מחדש של השירות (בצורה שקטה)
echo Restarting SysAid Service...
net stop SysAidAgent /y >nul 2>&1
ping 127.0.0.1 -n 5 > nul
net start SysAidAgent >nul 2>&1

echo --- SysAid Agent Setup Finished ---
endlocal
exit /b 0