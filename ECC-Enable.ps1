Write-Host "Checking for ECC Errors"
Start-Process nvidia-smi -ArgumentList "-q -d ECC" -NoNewWindow -Wait

Write-Host "Enabling for ECC Errors"
Start-Process nvidia-smi -ArgumentList "-e 1" -Verb RunAs -Wait

Write-Host "ECC has been enabled.  A system restart is required for the change to take effect." -ForegroundColor Green
$answer = Read-Host "Do you want to restart now? (Y/N)"

if ($answer -match '^[Yy]$') {
    Write-Host "Restarting System..." -ForegroundColor Red
    Restart-Computer -Force
} else {
    Write-Host "Please remember to restart your system later." -ForegroundColor Yellow
}
