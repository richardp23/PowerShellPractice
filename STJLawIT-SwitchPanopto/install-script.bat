@echo off
setlocal

:: Define paths
set "scriptSourcePath=%~dp0switch-panopto.ps1"  :: Dynamically reference the script in the same directory
set "hiddenDir=C:\ProgramData\SwitchPanopto"
set "scriptDestPath=%hiddenDir%\switch-panopto.ps1"
set "shortcutPath=%USERPROFILE%\Desktop\Switch Panopto.lnk"

:: Create hidden directory if it doesn't exist
if not exist "%hiddenDir%" (
    mkdir "%hiddenDir%"
)

:: Copy the script to the hidden directory
copy /Y "%scriptSourcePath%" "%scriptDestPath%"

:: Create a shortcut using PowerShell
set "shortcutTarget=powershell.exe"
set "shortcutArgs=-ExecutionPolicy Bypass -File \"%scriptDestPath%\""

:: Create the shortcut
powershell -command "New-Object -ComObject WScript.Shell | ForEach-Object { $_.CreateShortcut('%shortcutPath%') | ForEach-Object { $_.TargetPath='%shortcutTarget%'; $_.Arguments='%shortcutArgs%'; $_.IconLocation='powershell.exe'; $_.Save() } }"

:: Inform the user
echo The script has been installed and a shortcut named 'Switch Panopto' has been created on the desktop.

endlocal
pause