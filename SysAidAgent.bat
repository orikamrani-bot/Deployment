@echo off
set "workDir=C:\temp"
cd /d "%workDir%"

echo Starting direct installation with logging...

:: הרצה ללא Start /wait כדי למנוע בעיות תזמון, ושימוש בפרמטרים של MSI בתוך ה-EXE
"C:\temp\SysAidAgent.exe" /s /v" /qn URL=https://wizo.sysaidit.com ACCOUNT=wizo SERIAL=34A24AB423CA87B7 ALLOWREMOTECONTROL=N /l*v C:\temp\sysaid_log.txt"

:: המתנה של 30 שניות לסיום התהליך ברקע
timeout /t 30 /nobreak >nul

:: בדיקה אם השירות נוצר
sc query SysAidAgent | find "SERVICE_NAME"
if %errorlevel% neq 0 (
    echo Installation failed or blocked. Check C:\temp\sysaid_log.txt
    exit /b 1
) else (
    echo SysAid Service is now running!
)