# SecurityEventAudit.ps1
# Read-only review of recent Windows Security logon events.

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$reportDir = Join-Path $root 'reports'
New-Item -ItemType Directory -Path $reportDir -Force | Out-Null

$startTime = (Get-Date).AddHours(-24)
$reportPath = Join-Path $reportDir (
    'security-event-audit-{0}.csv' -f (Get-Date -Format 'yyyyMMdd-HHmmss')
)

$eventNames = @{
    4624 = 'Successful logon'
    4625 = 'Failed logon'
    4672 = 'Special privileges assigned'
}

try {
    $events = @(
        Get-WinEvent -FilterHashtable @{
            LogName   = 'Security'
            Id        = @(4624, 4625, 4672)
            StartTime = $startTime
        } -MaxEvents 500 -ErrorAction Stop
    )

    $results = foreach ($event in $events) {
        [pscustomobject]@{
            TimeCreated = $event.TimeCreated
            EventID     = $event.Id
            EventType   = $eventNames[[int]$event.Id]
            MachineName = $event.MachineName
            RecordID    = $event.RecordId
            Note        = 'Review event details before drawing conclusions'
        }
    }

    if ($results.Count -gt 0) {
        $results | Export-Csv -Path $reportPath -NoTypeInformation -Encoding UTF8
    }
    else {
        'No matching events were found in the last 24 hours.' |
            Set-Content -Path (Join-Path $reportDir 'security-event-audit-status.txt')
    }

    Write-Host "Security event query completed."
    Write-Host "Time window starts: $startTime"
    Write-Host "Matching events: $($events.Count)"

    if ($events.Count -gt 0) {
        Write-Host "Report saved to: $reportPath"
    }
    else {
        Write-Host "No matching events found. Check reports\security-event-audit-status.txt"
    }
}
catch {
    $message = "Security event audit failed: $($_.Exception.Message)"
    $statusPath = Join-Path $reportDir 'security-event-audit-status.txt'
    $message | Set-Content -Path $statusPath
    Write-Host $message -ForegroundColor Yellow
    Write-Host "Details saved to: $statusPath"
    exit 1
}
