@echo off
setlocal enabledelayedexpansion
set "TARGET_DIR=%SystemDrive%\Users\Public\DisableHFTOnStartup"
set "TASK_NAME=DisableHandsFreeTelephonyOnStartup"

:: Define ANSI Escape Codes for coloring text
set "ESC="
set "GREEN=%ESC%[92m"
set "YELLOW=%ESC%[93m"
set "RED=%ESC%[91m"
set "RESET=%ESC%[0m"

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%[CRITICAL ERROR] This script must be run as Administrator.
    echo Right-click the file and select "Run as administrator".%RESET%
    pause
    exit /b
)

:: Check if the scheduled task exists
schtasks /query /tn "%TASK_NAME%" >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%[INFO] Scheduled task "%TASK_NAME%" was not found. Nothing to remove.%RESET%
    goto :RemoveFolder
)

:: Delete the scheduled task
echo [INFO] Removing scheduled task "%TASK_NAME%"...
schtasks /delete /tn "%TASK_NAME%" /f
if %errorLevel% equ 0 (
    echo %GREEN%[SUCCESS] Scheduled task "%TASK_NAME%" removed successfully.%RESET%
) else (
    echo %RED%[ERROR] Failed to remove the scheduled task.%RESET%
)

:: Check if the target directory exists
if not exist "%TARGET_DIR%" (
    echo %YELLOW%[INFO] Folder "%TARGET_DIR%" was not found. Nothing to remove.%RESET%
    goto :End
)

:: Delete the folder and its contents
echo [INFO] Removing folder "%TARGET_DIR%"...
rmdir /s /q "%TARGET_DIR%"
if %errorLevel% equ 0 (
    echo %GREEN%[SUCCESS] Folder "%TARGET_DIR%" removed successfully.%RESET%
) else (
    echo %RED%[ERROR] Failed to remove the folder "%TARGET_DIR%".%RESET%
)

:End
echo %GREEN%[SUCCESS] ScheduledTask-DisableHands-FreeTelephony uninstall complete.%RESET%
pause