$ErrorActionPreference = "Stop"

$reportDir = Join-Path $PSScriptRoot "..\reports"
New-Item -ItemType Directory -Path $reportDir -Force | Out-Null

$computer = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$($env:SystemDrive)'"

$report = [PSCustomObject]@{
    Timestamp       = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Hostname        = $env:COMPUTERNAME
    WindowsVersion  = $os.Caption
    OSBuild         = $os.BuildNumber
    Manufacturer    = $computer.Manufacturer
    TotalRAM_GB     = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
    FreeRAM_GB      = [math]::Round($os.FreePhysicalMemory * 1KB / 1GB, 2)
    SystemDrive     = $disk.DeviceID
    DiskTotal_GB    = [math]::Round($disk.Size / 1GB, 2)
    DiskFree_GB     = [math]::Round($disk.FreeSpace / 1GB, 2)
}

$file = Join-Path $reportDir "system-health.csv"
$report | Export-Csv -Path $file -NoTypeInformation -Encoding UTF8

$report | Format-List
Write-Host "Report saved to: $file" -ForegroundColor Green
