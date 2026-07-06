@echo off
setlocal

title Fix Google Cloud Code Hosts Issue

echo ========================================
echo   Fix Google Cloud Code Sign-In Issue
echo ========================================
echo.

:: Check Administrator permission
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script needs Administrator permission.
    echo Requesting Administrator access...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "HOSTS_FILE=C:\Windows\System32\drivers\etc\hosts"
set "TARGET_DOMAIN=cloudcode-pa.googleapis.com"

echo [1/3] Removing entries containing %TARGET_DOMAIN% from hosts...

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$hosts='%HOSTS_FILE%';" ^
  "$domain='%TARGET_DOMAIN%';" ^
  "$content=Get-Content -Path $hosts -ErrorAction Stop;" ^
  "$filtered=$content | Where-Object { $_ -notmatch [regex]::Escape($domain) };" ^
  "Set-Content -Path $hosts -Value $filtered -Encoding ASCII;" ^
  "Write-Host '  -> Done'"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to update hosts file.
    pause
    exit /b 1
)

echo.
echo [2/3] Flushing DNS cache...
ipconfig /flushdns

echo.
echo [3/3] Checking result...
findstr /i "%TARGET_DOMAIN%" "%HOSTS_FILE%" >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo [ERROR] The hosts file still contains %TARGET_DOMAIN%.
    echo Please open this file manually and remove that line:
    echo %HOSTS_FILE%
) else (
    echo.
    echo [OK] Hosts file is clean.
    echo Google Cloud Code / Antigravity sign-in should work normally if this was the cause.
)

echo.
echo ========================================
pause
endlocal
