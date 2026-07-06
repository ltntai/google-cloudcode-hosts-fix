@echo off
setlocal

title Google Cloud Code Hosts Fix - Auto Run Setup
color 0B

:: Check Administrator permission
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0E
    echo  [!] Administrator permission is required.
    echo  [*] Requesting Administrator access...
    echo.
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo  ================================================================
echo   ^|                                                              ^|
echo   ^|         SETUP AUTO RUN FOR HOSTS FIX SCRIPT                  ^|
echo   ^|                                                              ^|
echo  ================================================================
echo.
echo   1. Enable Auto Run (Runs hidden on Windows Logon)
echo   2. Disable Auto Run (Remove scheduled task)
echo   3. Exit
echo.

set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" (
    echo.
    echo  Setting up Task Scheduler task...
    schtasks /create /tn "FixGoogleCloudCodeHosts" /tr "powershell.exe -NoProfile -WindowStyle Hidden -Command \"& '%~dp0fix-google-cloudcode.bat' /silent\"" /sc onlogon /rl highest /f
    if %errorlevel% equ 0 (
        color 0A
        echo.
        echo  [SUCCESS] Auto Run has been successfully enabled!
        echo  The fix will run automatically in the background every time you log in.
    ) else (
        color 0C
        echo.
        echo  [ERROR] Failed to create scheduled task.
    )
)

if "%choice%"=="2" (
    echo.
    echo  Removing Task Scheduler task...
    schtasks /delete /tn "FixGoogleCloudCodeHosts" /f
    if %errorlevel% equ 0 (
        color 0A
        echo.
        echo  [SUCCESS] Auto Run has been disabled (task removed).
    ) else (
        color 0C
        echo.
        echo  [ERROR] Failed to remove scheduled task or it didn't exist.
    )
)

echo.
echo  Press any key to exit...
pause >nul
endlocal
