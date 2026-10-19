# Mini Enterprise IT & Security Lab

A hands-on Windows IT support and security monitoring lab built with PowerShell and native Windows tools.

## Objectives

- Collect basic Windows system health information.
- Validate DNS resolution and HTTPS connectivity.
- Audit selected Windows service states.
- Generate CSV evidence for troubleshooting.
- Document investigation steps and findings in a ticket format.

## Environment

- OS: Windows 11 Pro
- Shell: Windows PowerShell
- Tools: CIM, Event Viewer-compatible Windows logging, networking utilities, CSV reports

## Project Structure

```text
Mini-Enterprise-IT-Security-Lab/
├── scripts/
│   ├── SystemHealthAudit.ps1
│   ├── NetworkConnectivityAudit.ps1
│   └── ServiceAudit.ps1
├── reports/
│   ├── system-health.csv
│   ├── network-connectivity.csv
│   └── service-audit.csv
├── tickets/
│   └── IT-001-DNS-Troubleshooting.md
├── sample-logs/
├── detections/
├── screenshots/
└── README.md
```

## Implemented Components

### 1. System Health Audit

Collects the computer name, Windows version, OS build, manufacturer, RAM figures, and system drive capacity.

Output: `reports/system-health.csv`

### 2. Network Connectivity Audit

Checks the default gateway, DNS resolution for `example.com`, and an HTTPS request to the same destination.

Output: `reports/network-connectivity.csv`

### 3. Windows Service Audit

Records the state and startup mode of six selected Windows services.

Output: `reports/service-audit.csv`

A stopped service is not automatically a fault; its expected behavior must be assessed before taking action.

### 4. Troubleshooting Documentation

`IT-001-DNS-Troubleshooting.md` records the test scenario, diagnostic evidence, findings, and validation outcome.

## Test Results

The initial lab run recorded:

- DNS resolution: PASS
- HTTPS request: PASS (HTTP 200)
- Selected Windows services: 6 running
- CSV reports: Generated successfully

These results describe one test session and may change on subsequent runs.

## How to Run

Open PowerShell and set the project path:

```powershell
$root = "$HOME\Desktop\Mini-Enterprise-IT-Security-Lab"
```

Run each audit:

```powershell
& "$root\scripts\SystemHealthAudit.ps1"
& "$root\scripts\NetworkConnectivityAudit.ps1"
& "$root\scripts\ServiceAudit.ps1"
```

Review the generated reports in the `reports` directory.

## Safety and Limitations

- The scripts are intended for local, read-only auditing and report generation.
- Network results depend on current connectivity, DNS, proxy, and firewall configuration.
- The current service audit checks selected services only.
- No real user incident or DNS failure is claimed to have been resolved.
- Review scripts before running them on other systems.

## Planned Improvements

- Windows security event-log analysis.
- More troubleshooting tickets with reproducible test evidence.
- PowerShell error handling and structured logging.
- Screenshots and documented test cases.
- Optional integration with a SIEM for security-event investigations.

## Author

Mohammad Azam Khan

Cybersecurity | Windows Troubleshooting | PowerShell | Security Monitoring
