$ErrorActionPreference = "Stop"

$reportDir = Join-Path $PSScriptRoot "..\reports"
New-Item -ItemType Directory -Path $reportDir -Force | Out-Null

$gateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" `
    -ErrorAction SilentlyContinue |
    Sort-Object RouteMetric |
    Select-Object -First 1

$dnsOK = $false
$httpsOK = $false
$dnsDetail = ""
$httpsDetail = ""

try {
    $dnsResult = Resolve-DnsName "example.com" -ErrorAction Stop |
        Select-Object -First 1
    $dnsOK = $true
    $dnsDetail = $dnsResult.Name
}
catch {
    $dnsDetail = $_.Exception.Message
}

try {
    $response = Invoke-WebRequest `
        -Uri "https://example.com" `
        -Method Head `
        -TimeoutSec 10 `
        -UseBasicParsing `
        -ErrorAction Stop

    $httpsOK = ($response.StatusCode -ge 200 -and
                $response.StatusCode -lt 400)
    $httpsDetail = "HTTP $($response.StatusCode)"
}
catch {
    $httpsDetail = $_.Exception.Message
}

$report = [PSCustomObject]@{
    Timestamp       = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Hostname        = $env:COMPUTERNAME
    DefaultGateway  = $gateway.NextHop
    GatewayInterface = $gateway.InterfaceAlias
    DNSResolution   = if ($dnsOK) { "PASS" } else { "FAIL" }
    DNSDetails      = $dnsDetail
    HTTPSConnection = if ($httpsOK) { "PASS" } else { "FAIL" }
    HTTPSDetails    = $httpsDetail
}

$file = Join-Path $reportDir "network-connectivity.csv"
$report | Export-Csv -Path $file -NoTypeInformation -Encoding UTF8

$report | Format-List
Write-Host "Report saved to: $file" -ForegroundColor Green
