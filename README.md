# Mini Enterprise IT & Security Lab

A hands-on Windows IT support and security monitoring lab built with PowerShell and native Windows tools. This personal learning project demonstrates Windows system auditing, network connectivity troubleshooting, service monitoring, security event analysis, and automated reporting.

## Project Objectives

- Collect basic Windows system health information.
- Test network connectivity, DNS resolution, and HTTPS access.
- Audit selected Windows services and their configurations.
- Analyze selected Windows Security event logs.
- Generate CSV audit reports and a combined summary.
- Practice practical IT support and defensive security workflows.

## Environment and Tools

- **Operating System:** Windows 11 Pro
- **Scripting:** Windows PowerShell
- **Tools:** CIM, Windows Event Logs, networking utilities, CSV reporting, batch automation
- **Project Type:** Personal learning and demonstration lab

## Repository Structure

```text
mini-enterprise-it-security-lab/
├── scripts/
│   ├── SystemHealthAudit.ps1
│   ├── NetworkConnectivityAudit.ps1
│   ├── ServiceAudit.ps1
│   ├── SecurityEventAudit.ps1
│   └── CombinedAuditSummary.ps1
├── README.md
└── Run-Lab.bat
```

## Implemented Components

### 1. System Health Audit

Collects basic Windows system information, including operating system details, computer information, memory figures, and system-drive capacity.

**Output:** `system-health.csv`

### 2. Network Connectivity Audit

Checks the default network gateway, DNS resolution, and HTTPS connectivity to help identify basic network configuration or connectivity issues.

**Output:** `network-connectivity.csv`

### 3. Windows Service Audit

Records the status and startup configuration of six selected Windows services.

**Output:** `service-audit.csv`

A stopped service does not automatically indicate a problem. Its expected behavior and system context should be checked before taking action.

### 4. Windows Security Event Analyzer

Reviews selected Windows Security log events to support basic security monitoring and investigation practice.

The audit includes these event IDs:

- **4624 — Successful logon**
- **4625 — Failed logon**
- **4672 — Special privileges assigned to a logon**

These events must be interpreted in context. A failed logon alone does not prove a brute-force attack, and Event ID 4672 is not inherently malicious.

**Output:** A timestamped CSV security event report.

### 5. Combined Audit Summary

Checks for generated audit reports and summarizes their availability and row counts, providing a quick overview of the lab run.

**Output:** `combined-audit-summary.txt`

## Test Results

During local testing on Windows 11 Pro, the lab recorded the following results:

- DNS resolution: **PASS**
- HTTPS connectivity: **PASS** — HTTP 200
- Selected Windows services: **6 services recorded**
- Security event audit: **500 rows exported** in the tested run
- Combined audit summary: **Generated successfully**

These results describe one test session and may vary with system configuration, connectivity, available event logs, and subsequent runs.

The 500 exported event records represent collected log data, not 500 confirmed security incidents or attacks.

## How to Run

1. Download or clone this repository to a Windows computer.
2. Review the scripts before executing them.
3. Run `Run-Lab.bat` to access the available audit options.
4. Alternatively, run an individual script from PowerShell.
5. Review the generated reports in the local project directory.

Some Windows Security log queries may require elevated PowerShell permissions. Run scripts only on systems you own or are authorized to administer.

## Safety and Limitations

- The scripts are intended for local, read-only auditing and report generation.
- Network results depend on DNS, firewall, proxy, and connectivity settings.
- The service audit covers selected services rather than every service on the system.
- Security events require contextual investigation before drawing conclusions.
- This is a personal learning lab, not a production SOC deployment or evidence of enterprise SOC employment.
- Generated reports may contain system-specific information. Review and sanitize them before sharing publicly.

## Skills Demonstrated

- PowerShell scripting and automation
- Windows system administration fundamentals
- Network connectivity and DNS troubleshooting
- Windows service auditing
- Security event log analysis
- CSV report generation
- Basic security monitoring and investigation
- Technical documentation

## Future Improvements

- Add more troubleshooting scenarios and investigation examples.
- Improve error handling and structured logging.
- Add sanitized screenshots and sample evidence.
- Explore optional SIEM integration for security event monitoring.

## Author

**Mohammad Azam Khan**

Cybersecurity | Windows Troubleshooting | PowerShell | Security Monitoring

GitHub: [@azamkhan-soc](https://github.com/azamkhan-soc)
