$ServiceName = "Panopto Remote Recorder Service"

# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Relaunch as administrator
        Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs
        exit
    } catch {
        Write-Error "Failed to elevate privileges. Exiting script."
        exit
    }
}

try {
    $service = Get-Service -Name $ServiceName -ErrorAction Stop
    $status = $service.Status

    Write-Host "Current status of $ServiceName`: $status"

    if ($status -eq "Running") {
        $response = Read-Host "The service is running. Would you like to stop it? (y/n)"
        if ($response -eq 'y') {
            Stop-Service -Name $ServiceName -Force
            Write-Host "Panopto service has been stopped."
        }
    } else {
        $response = Read-Host "The service is not running. Would you like to start it? (y/n)"
        if ($response -eq 'y') {
            Start-Service -Name $ServiceName
            Write-Host "Panopto service has been started."
        }
    }
} catch {
    Write-Error "Error: $_"
}

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
