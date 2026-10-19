$ErrorActionPreference = "Stop"

$reportDir = Join-Path $PSScriptRoot "..\reports"
New-Item -ItemType Directory -Path $reportDir -Force | Out-Null

$serviceNames = @(
    "EventLog",
    "Dnscache",
    "Dhcp",
    "W32Time",
    "LanmanWorkstation",
    "Winmgmt"
)

$results = foreach ($name in $serviceNames) {
    $service = Get-CimInstance Win32_Service `
        -Filter "Name='$name'" `
        -ErrorAction SilentlyContinue

    if ($service) {
        [PSCustomObject]@{
            Timestamp     = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            ComputerName  = $env:COMPUTERNAME
            ServiceName   = $service.Name
            DisplayName   = $service.DisplayName
            State         = $service.State
            StartMode     = $service.StartMode
            Status        = if ($service.State -eq "Running") {
                "Running"
            } else {
                "Review"
            }
        }
    }
}

$file = Join-Path $reportDir "service-audit.csv"

$results | Export-Csv -Path $file `
    -NoTypeInformation -Encoding UTF8

$results | Format-Table ServiceName, State, StartMode, Status -AutoSize

Write-Host "Report saved to: $file" -ForegroundColor Green
