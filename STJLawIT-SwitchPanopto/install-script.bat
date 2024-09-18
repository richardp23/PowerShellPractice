@echo off
:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges. Please run as administrator.
    pause
    exit /b
)

setlocal

:: Define paths
set "scriptSourcePath=%~dp0switch-panopto.ps1"
set "hiddenDir=C:\ProgramData\SwitchPanopto"
set "scriptDestPath=%hiddenDir%\switch-panopto.ps1"
set "startMenuPath=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Switch Panopto.lnk"

:: Create hidden directory if it doesn't exist
if not exist "%hiddenDir%" (
    mkdir "%hiddenDir%"
)

:: Copy the script to the hidden directory
copy /Y "%scriptSourcePath%" "%scriptDestPath%"

:: Create a shortcut using PowerShell
set "shortcutTarget=powershell.exe"
set "shortcutArgs=-ExecutionPolicy Bypass -File \"%scriptDestPath%\""

:: Create the shortcut in the Start Menu
powershell -command "$ws = New-Object -ComObject WScript.Shell; $shortcut = $ws.CreateShortcut('%startMenuPath%'); $shortcut.TargetPath = '%shortcutTarget%'; $shortcut.Arguments = '%shortcutArgs%'; $shortcut.IconLocation = 'powershell.exe'; $shortcut.Save()"

:: Inform the user
echo The script has been installed and a shortcut named 'Switch Panopto' has been created in the Start Menu.

endlocal
pause