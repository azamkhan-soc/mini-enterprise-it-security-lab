# CombinedAuditSummary.ps1
# Read-only summary of the latest audit CSV reports.

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$reportDir = Join-Path $root 'reports'
$summaryPath = Join-Path $reportDir 'combined-audit-summary.txt'

$checks = @(
    [pscustomobject]@{
        Name = 'System Health Audit'
        Pattern = 'system-health.csv'
    },
    [pscustomobject]@{
        Name = 'Network Connectivity Audit'
        Pattern = 'network-connectivity.csv'
    },
    [pscustomobject]@{
        Name = 'Windows Service Audit'
        Pattern = 'service-audit.csv'
    },
    [pscustomobject]@{
        Name = 'Security Event Analyzer'
        Pattern = 'security-event-audit-*.csv'
    }
)

$lines = @(
    'MINI ENTERPRISE IT & SECURITY LAB'
    'COMBINED AUDIT SUMMARY'
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    ''
)

foreach ($check in $checks) {
    $file = Get-ChildItem -Path $reportDir -Filter $check.Pattern -File |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if ($null -eq $file) {
        $lines += "$($check.Name): REPORT NOT FOUND"
        continue
    }

    try {
        $rows = @(Import-Csv -Path $file.FullName)
        $lines += "$($check.Name): Report found"
        $lines += "  File: $($file.Name)"
        $lines += "  Rows: $($rows.Count)"
        $lines += "  Last updated: $($file.LastWriteTime)"
    }
    catch {
        $lines += "$($check.Name): Could not read report"
    }

    $lines += ''
}

$lines += 'Note: This summary checks report availability and row counts.'
$lines += 'It does not independently diagnose faults or confirm attacks.'

$lines | Set-Content -Path $summaryPath -Encoding UTF8

Write-Host 'Combined summary created.'
Write-Host "Location: $summaryPath"
