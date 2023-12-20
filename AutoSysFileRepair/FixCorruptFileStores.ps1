# Windows 10: https://go.microsoft.com/fwlink/?LinkId=691209
# Windows 11: https://go.microsoft.com/fwlink/?linkid=2156295

$DownloadLocation = (New-Item -Path $PSScriptRoot -Name "Temp" -ItemType "Directory" -Force).FullName + "\";

$editionsArray = @(
        ('Home', 'YTMG3-N6DKC-DKB77-7M9GH-8HVX7'),
        ('Professional', 'VK7JG-NPHTM-C97JM-9MPGT-3V66T'),
        ('Enterprise', 'XGVPP-NMH47-7TTHJ-W3FW7-8HV2C')
)

$InstalledVersion
$InstalledEdition

if ((Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11") {
    $InstalledVersion = "Windows 11"
    Invoke-WebRequest -URI "https://go.microsoft.com/fwlink/?linkid=2156295" -OutFile ($DownloadLocation + "MediaCreationTool.exe")
}
elseif ((Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 10") {
    $InstalledVersion = "Windows 10"
    Invoke-WebRequest -URI "https://go.microsoft.com/fwlink/?LinkId=691209" -OutFile ($DownloadLocation + "MediaCreationTool.exe")
}

foreach ( $edition in $editionsArray ) {
    if ((Get-WmiObject Win32_OperatingSystem).Caption -Match $edition[0]) {
        $InstalledEdition = $edition[0]

        Write-Host "The Media Creation Tool will now open up and prompt you to enter a license key."
        Write-Host ("Please enter this license key: " + $edition[1])
       
       & ($DownloadLocation + "MediaCreationTool.exe") /Eula Accept /Retail /MediaArch x64 /MediaLangCode en-US /MediaEdition $edition[0] | Out-Null
    }
}

$mountResult = Mount-DiskImage -ImagePath ($DownloadLocation + "Windows.iso") -PassThru
$mountDriveletter = ($mountResult | Get-Volume).DriveLetter

$sourcePath = $mountDriveletter + ":\sources\install.esd"
$destinationPath = $DownloadLocation + "install.wim"

Export-WindowsImage -SourceImagePath $sourcePath -SourceName "${InstalledVersion} ${InstalledEdition}" -DestinationImagePath ($DownloadLocation + "install.wim") | Out-Null
Dismount-DiskImage -InputObject $mountResult | Out-Null

Dism /Online /Cleanup-Image /RestoreHealth /Source:wim:"${DestinationPath}":1 /LimitAccess | Out-Default
sfc /scannow | Out-Null