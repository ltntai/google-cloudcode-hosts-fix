@echo off
setlocal

set "SILENT_MODE=0"
if /i "%~1"=="/silent" set "SILENT_MODE=1"
if /i "%~1"=="--silent" set "SILENT_MODE=1"
if /i "%~1"=="/auto" set "SILENT_MODE=1"
if /i "%~1"=="--auto" set "SILENT_MODE=1"

title Google Cloud Code Hosts Fix
color 0B

if "%SILENT_MODE%" neq "1" (
    echo.
    echo  ================================================================
    echo   ^|                                                              ^|
    echo   ^|        GOOGLE CLOUD CODE / ANTIGRAVITY 9ROUTER FIX          ^|
    echo   ^|                                                              ^|
    echo  ================================================================
    echo.
)

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
set "DAILY_DOMAIN=daily-cloudcode-pa.googleapis.com"

echo  [1/4] Checking local 9Router HTTPS listener...
powershell -NoProfile -Command "$p=Get-NetTCPConnection -State Listen -LocalPort 443 -ErrorAction SilentlyContinue; if ($p) { exit 0 } else { exit 1 }" >nul 2>&1
if %errorlevel% equ 0 (
    echo        Found listener on port 443.
) else (
    color 0E
    echo        Warning: no local port 443 listener found.
    echo        Make sure 9Router is running before opening Antigravity.
)

echo.
echo  [2/4] Applying 9Router hosts route...
echo        Routing Cloud Code domains to localhost 9Router.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$hosts='%HOSTS_FILE%';" ^
  "$domains=@('%TARGET_DOMAIN%','%DAILY_DOMAIN%');" ^
  "$content=Get-Content -Path $hosts -ErrorAction Stop;" ^
  "$filtered=$content | Where-Object { $line=$_; -not ($domains | Where-Object { $line -match [regex]::Escape($_) }) };" ^
  "$routes=@('', '# 9Router route for Antigravity / Google Cloud Code');" ^
  "$routes += $domains | ForEach-Object { '127.0.0.1 ' + $_ };" ^
  "$routes += $domains | ForEach-Object { '::1 ' + $_ };" ^
  "Set-Content -Path $hosts -Value (@($filtered) + $routes) -Encoding ASCII;" ^
  "Write-Host '       Added IPv4 + IPv6 localhost routes.'"

if %errorlevel% neq 0 (
    color 0C
    echo.
    echo  [ERROR] Failed to update hosts file.
    if "%SILENT_MODE%" neq "1" pause
    exit /b 1
)

echo.
echo  [3/4] Flushing DNS cache...
ipconfig /flushdns
if %errorlevel% neq 0 (
    color 0E
    echo  [WARN] Failed to flush DNS cache. You may need to run ipconfig /flushdns manually.
)

echo.
echo  [4/4] Verifying result...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$hosts='%HOSTS_FILE%';" ^
  "$required=@('127.0.0.1 %TARGET_DOMAIN%','127.0.0.1 %DAILY_DOMAIN%','::1 %TARGET_DOMAIN%','::1 %DAILY_DOMAIN%');" ^
  "$content=(Get-Content -Path $hosts -ErrorAction Stop) -join [Environment]::NewLine;" ^
  "$missing=@($required | Where-Object { $content -notmatch ('(?m)^\s*' + [regex]::Escape($_) + '\s*$') });" ^
  "if ($missing.Count -eq 0) { Write-Host '       All required routes are present.'; exit 0 } else { Write-Host '       Missing routes:'; $missing | ForEach-Object { Write-Host ('       - ' + $_) }; exit 1 }"

if %errorlevel% equ 0 (
    color 0A
    echo.
    echo  ================================================================
    echo   9ROUTER ROUTE IS ENABLED
    echo  ================================================================
    echo.
    echo  Cloud Code domains now point to local 9Router.
    echo  Fully close Antigravity, then open it again.
) else (
    color 0C
    echo.
    echo  [ERROR] Route verification failed.
    if "%SILENT_MODE%" neq "1" pause
    exit /b 1
)

if "%SILENT_MODE%" neq "1" (
    echo.
    echo  Press any key to exit...
    pause >nul
)
endlocal
