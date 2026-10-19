@echo off
title Mini Enterprise IT and Security Lab
cd /d "%~dp0"

echo ==========================================
echo   MINI ENTERPRISE IT AND SECURITY LAB
echo ==========================================
echo.

echo [1/5] Running System Health Audit...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\SystemHealthAudit.ps1"

echo.
echo [2/5] Running Network Connectivity Audit...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\NetworkConnectivityAudit.ps1"

echo.
echo [3/5] Running Windows Service Audit...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\ServiceAudit.ps1"

echo.
echo [4/5] Running Security Event Analyzer...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\SecurityEventAudit.ps1"

echo.
echo [5/5] Generating Combined Audit Summary...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\CombinedAuditSummary.ps1"

echo.
echo ==========================================
echo Check the reports folder for results.
echo ==========================================
pause
