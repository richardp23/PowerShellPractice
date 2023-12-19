# PowerShell Practice
PowerShell Version: 7.4

## What is this?

This repository is used to store and track my personal progress in learning Microsoft's PowerShell CLI & scripting language.

## Projects:

### Downloading Fonts
Goal: Use PowerShell to automate downloading fonts over the internet, and install them onto local machine.

Completed:
* Create temp directory for process (New-Item, $PSScriptRoot)
* Download from URL (Invoke-WebRequest)
* Extract compressed font file into directory (Expand-Archive)
* \[Optional] Delete unneeded font files (Remove-Item, foreach)

To-Do:
1. Automate installation of fonts
2. Cleanup directory upon completion
3. \[Optional] Accept user input to query desired installation options.