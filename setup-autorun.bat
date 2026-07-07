@echo off
setlocal

title Google Cloud Code Hosts Fix - Auto Run Setup
color 0B

set "TASK_LOGON=FixGoogleCloudCodeHosts"
set "FIX_COMMAND=powershell.exe -NoProfile -WindowStyle Hidden -Command \"& '%~dp0fix-google-cloudcode.bat' /silent\""

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
echo   ^|         SETUP AUTO RUN FOR 9ROUTER + ANTIGRAVITY             ^|
echo   ^|                                                              ^|
echo  ================================================================
echo.
echo   1. Enable Auto Run (Apply 9Router route on Windows login)
echo   2. Disable Auto Run (Remove scheduled task)
echo   3. Run Fix Now
echo   4. Exit
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" (
    echo.
    echo  Setting up Task Scheduler task...
    schtasks /create /tn "%TASK_LOGON%" /tr "%FIX_COMMAND%" /sc onlogon /rl highest /delay 0000:20 /f >nul
    if %errorlevel% neq 0 goto setup_failed

    color 0A
    echo.
    echo  [SUCCESS] Auto Run has been enabled!
    echo  On login, waits 20 seconds then applies 9Router route silently.
    echo  VS Code/Cursor can still use 9Router normally.
    goto done
)

if "%choice%"=="2" (
    echo.
    echo  Removing Task Scheduler task...
    schtasks /delete /tn "%TASK_LOGON%" /f >nul 2>&1
    color 0A
    echo.
    echo  [SUCCESS] Auto Run has been disabled.
    goto done
)

if "%choice%"=="3" (
    echo.
    echo  Running fix now...
    call "%~dp0fix-google-cloudcode.bat"
    goto done
)

goto done

:setup_failed
color 0C
echo.
echo  [ERROR] Failed to create scheduled task.
echo          Please make sure you ran this file as Administrator.

goto done

:done
echo.
echo  Press any key to exit...
pause >nul
endlocal
