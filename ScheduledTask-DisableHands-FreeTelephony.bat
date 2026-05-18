@echo off
setlocal enabledelayedexpansion

set "TARGET_DIR=%SystemDrive%\Users\Public\DisableHFTOnStartup"
set "TARGET_FILE=%TARGET_DIR%\DisableHFTOnStartup_Script.bat"
set "TASK_NAME=DisableHandsFreeTelephonyOnStartup"
set "TASK_DESC=Applies a registry fix on every Windows startup to keep Bluetooth Hands-Free Telephony services (BthHFEnum and BthHFAud) disabled, preventing Windows 10/11 from automatically re-enabling them after reboots or updates. This task was scheduled by a batch script made by PixelIndieDev on Github."

:: Define ANSI Escape Codes for coloring text
set "ESC="
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "RED=%ESC%[91m"
set "BLUE=%ESC%[94m"
set "RESET=%ESC%[0m"

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%[CRITICAL ERROR] This setup script must be run as Administrator.
    echo Right-click the file and select "Run as administrator".%RESET%
    pause
    exit /b
)

:: Check if the scheduled task already exists
:: Don't do anything when it already exists
schtasks /query /tn "%TASK_NAME%" >nul 2>&1
if %errorLevel% equ 0 (
    echo %YELLOW%[INFO] The scheduled task "%TASK_NAME%" already exists. No action needed.%RESET%
    goto :End
)

echo [INFO] Startup task not found. Installing the "%TASK_NAME%" task...

:: Create the directory for the script, if it doesn't exist
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)

:: Write the registry code to the target file
echo @echo off > "%TARGET_FILE%"
:: Check and set BthHFEnum
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFEnum" /v "Start" /t REG_DWORD /d 4 /f >> "%TARGET_FILE%"
:: Check and set BthHFAud
echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFAud"  /v "Start" /t REG_DWORD /d 4 /f >> "%TARGET_FILE%"

echo %GREEN%[INFO] Created registry fix script at: %TARGET_FILE%%RESET%

:: Create the Scheduled Task to run at startup as SYSTEM
schtasks /create /tn "%TASK_NAME%" /tr "\"%TARGET_FILE%\"" /sc onstart /ru "NT AUTHORITY\SYSTEM" /rl highest /f

if %errorLevel% equ 0 (
    echo %GREEN%[SUCCESS] Task "%TASK_NAME%" successfully created!%RESET%
	:: Set task description via PowerShell since schtasks has no description flag
    powershell -Command "$task = Get-ScheduledTask -TaskName '%TASK_NAME%'; $task.Description = '%TASK_DESC%'; Set-ScheduledTask -InputObject $task"
) else (
    echo %RED%[ERROR] Failed to create the scheduled task.%RESET%
)

:: NEW: Run the task immediately once
echo %YELLOW%[INFO] Triggering the task to run immediately...%RESET%
schtasks /run /tn "%TASK_NAME%" >nul 2>&1

if %errorLevel% equ 0 (
    echo %GREEN%[SUCCESS] Task has executed in the background. Registry values are updated!%RESET%
    echo %BLUE%The scheduled task will now run silently every time the computer boots up.%RESET%
) else (
    echo %RED%[ERROR] Task was created but failed to trigger.%RESET%
)

:End
pause
