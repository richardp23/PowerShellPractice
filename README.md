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

### Automate System File Repair
Goal: Use PowerShell to handle automatic repair using DISM and SFC.

Completed:
* Store list of commonly installed Windows editions & generic keys (arrays, nested arrays)
* Download Media Creation Tool based on detected Windows major version (Get-WmiObject, Invoke-WebRequest)
* Use Media Creation Tool to download ISO file corresponding to installed Windows edition (foreach)
* Create .WIM file from downloaded ISO's provided ESD file (Mount-DiskImage, Get-Volume, Get-WindowsImage, Export-WindowsImage, Dismount-DiskImage) 
* Invoke DISM to begin repair
* \[Optional] Silent output on certain commands/Wait for command to finish before progressing to next part of script (Out-Null, Out-Default)

To-Do:
* Move over all DISM invocations to PowerShell cmdlets
* Automate entirety of standard System File Repair process, progressing based on DISM output
* [Optional] Hands-free ISO download with Media Creation Tool 