@echo off
setlocal

:: Parse silent/auto argument
set "SILENT_MODE=0"
if "%~1"=="/silent" set "SILENT_MODE=1"
if "%~1"=="--silent" set "SILENT_MODE=1"
if "%~1"=="/auto" set "SILENT_MODE=1"
if "%~1"=="--auto" set "SILENT_MODE=1"

title Google Cloud Code Hosts Fix
color 0B

echo.
echo  ================================================================
echo   ^|                                                              ^|
echo   ^|        GOOGLE CLOUD CODE / ANTIGRAVITY HOSTS FIX             ^|
echo   ^|                                                              ^|
echo  ================================================================
echo.
echo   Target : cloudcode-pa.googleapis.com
echo   Action : remove broken hosts entry + flush DNS
echo.

:: Check Administrator permission
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 0E
    echo  [!] Administrator permission is required.
    echo  [*] Requesting Administrator access...
    echo.
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '%*' -Verb RunAs"
    exit /b
)

set "HOSTS_FILE=C:\Windows\System32\drivers\etc\hosts"
set "TARGET_DOMAIN=cloudcode-pa.googleapis.com"

echo  [1/3] Cleaning hosts file...
echo        Removing entries containing: %TARGET_DOMAIN%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$hosts='%HOSTS_FILE%';" ^
  "$domain='%TARGET_DOMAIN%';" ^
  "$content=Get-Content -Path $hosts -ErrorAction Stop;" ^
  "$filtered=$content | Where-Object { $_ -notmatch [regex]::Escape($domain) };" ^
  "Set-Content -Path $hosts -Value $filtered -Encoding ASCII;" ^
  "Write-Host '       Done.'"

if %errorlevel% neq 0 (
    color 0C
    echo.
    echo  [ERROR] Failed to update hosts file.
    echo          Please run this script as Administrator.
    echo.
    if "%SILENT_MODE%" neq "1" pause
    exit /b 1
)

echo.
echo  [2/3] Flushing DNS cache...
ipconfig /flushdns

echo.
echo  [3/3] Verifying result...
findstr /i "%TARGET_DOMAIN%" "%HOSTS_FILE%" >nul 2>&1

if %errorlevel% equ 0 (
    color 0C
    echo.
    echo  ================================================================
    echo   FIX FAILED
    echo  ================================================================
    echo.
    echo  The hosts file still contains: %TARGET_DOMAIN%
    echo.
    echo  Please open this file manually and remove that line:
    echo  %HOSTS_FILE%
) else (
    color 0A
    echo.
    echo  ================================================================
    echo   FIX COMPLETED SUCCESSFULLY
    echo  ================================================================
    echo.
    echo  Hosts file is clean.
    echo  Google Cloud Code / Antigravity sign-in should work normally
    echo  if the hosts entry was the cause.
)

if "%SILENT_MODE%" neq "1" (
    echo.
    echo  Press any key to exit...
    pause >nul
)
endlocal
