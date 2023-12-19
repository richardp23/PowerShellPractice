# https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip

$DownloadLocation = (New-Item -Path $PSScriptRoot -Name "Temp" -ItemType "Directory" -Force).FullName + "\";

Invoke-WebRequest -URI "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip" -OutFile ($DownloadLocation + "JetBrainsMono.zip")
Expand-Archive -Path ($DownloadLocation + "JetBrainsMono.zip") -DestinationPath ($DownloadLocation + "JetBrainsMono") -Force

$TempFiles = Get-ChildItem -Path ($DownloadLocation + "JetBrainsMono") -Filter "*.ttf"

foreach ($f in $TempFiles) {
    if (-not $f.Name.StartsWith("JetBrainsMonoNerdFontMono-")) {
        Remove-Item $f.FullName
    }
}
