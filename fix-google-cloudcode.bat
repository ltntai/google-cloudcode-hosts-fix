@echo off
echo ========================================
echo   FIX Google Cloud Code Sign-In
echo ========================================
echo.

:: Check admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Dang yeu cau quyen Admin...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo [1/3] Xoa dong cloudcode-pa khoi hosts...
powershell -ExecutionPolicy Bypass -Command "$h='C:\Windows\System32\drivers\etc\hosts'; $c=Get-Content $h; $f=$c|Where-Object{$_ -notmatch 'cloudcode-pa\.googleapis\.com'}; Set-Content -Path $h -Value $f -Encoding UTF8; Write-Host '  -> Da xoa xong'"

echo [2/3] Flush DNS...
ipconfig /flushdns

echo [3/3] Kiem tra ket qua...
findstr /i "cloudcode" C:\Windows\System32\drivers\etc\hosts >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo [LOI] Van con dong cloudcode trong hosts!
) else (
    echo.
    echo [OK] Hosts sach! Google Cloud Code se hoat dong binh thuong.
)

echo.
echo ========================================
pause