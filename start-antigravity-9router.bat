@echo off
setlocal

title Start Antigravity with 9Router Route
color 0B

set "ROOT=%~dp0"
set "FIX=%ROOT%fix-google-cloudcode.bat"
set "ANTIGRAVITY=%LOCALAPPDATA%\Programs\Antigravity IDE\Antigravity IDE.exe"

echo.
echo  ================================================================
echo   ^|                                                              ^|
echo   ^|        START ANTIGRAVITY WITH 9ROUTER ROUTE                  ^|
echo   ^|                                                              ^|
echo  ================================================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [*] Requesting Administrator access...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo  [1/4] Closing Antigravity completely...
taskkill /f /im "Antigravity IDE.exe" >nul 2>&1
taskkill /f /im "language_server_windows_x64.exe" >nul 2>&1
timeout /t 2 /nobreak >nul

echo.
echo  [2/4] Applying 9Router route...
call "%FIX%" /silent
if %errorlevel% neq 0 (
    color 0C
    echo  [ERROR] Failed to apply route.
    pause
    exit /b 1
)

echo.
echo  [3/4] Checking local 9Router HTTPS listener...
powershell -NoProfile -Command "$p=Get-NetTCPConnection -State Listen -LocalPort 443 -ErrorAction SilentlyContinue; if ($p) { Write-Host '       Found listener on port 443.'; exit 0 } else { Write-Host '       Warning: no local port 443 listener found. Make sure 9Router is running.'; exit 1 }"

echo.
echo  [4/4] Starting Antigravity...
if exist "%ANTIGRAVITY%" (
    start "" "%ANTIGRAVITY%"
    color 0A
    echo  [SUCCESS] Done. If sign-in still fails, open 9Router first then run this again.
) else (
    color 0E
    echo  [WARN] Antigravity exe was not found at:
    echo         %ANTIGRAVITY%
    echo         Open Antigravity manually now.
)

echo.
echo  You can close this window.
pause
endlocal
