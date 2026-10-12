@echo off
REM STPigator launcher.
REM Runs navigator.ps1 with an execution-policy bypass for this process only.
REM No system or user policy is changed and no administrator rights are needed.

cd /d "%~dp0Scripts"
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "navigator.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo STPigator exited with an error. Press any key to close this window.
    pause >nul
)
