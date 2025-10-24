$mstOutput = mst status

# Step: Filter out headers and empty lines
$filteredOutput = $mstOutput | Where-Object {
    $_ -and ($_ -notmatch '^\s*$') -and ($_ -notmatch '^MST Devices:') -and ($_ -notmatch '^-+$')
}

# Step: Check if there is any remaining output
if ($filteredOutput) {
    foreach ($line in $filteredOutput) {
        # Extract just the device path (e.g., /dev/mst/mt4119_pciconf0)
        $devicePath = $line -split '\s+' | Select-Object -Last 1

        Write-Host "Running mlxconfig on $devicePath..."
        mlxconfig -d $devicePath -y set LINK_TYPE_P1=2
        mlxconfig -d $devicePath -y set LINK_TYPE_P2=2
    }
} else {
    Write-Host "No valid devices found in 'mst status' output. Nothing to configure."
}

$restartOrNah = Read-Host "Press [Enter] to CLOSE WINDOW, [Y] to RESTART"
if ($restartOrNah -eq 'y' -or $restartOrNah -eq 'Y') {
    Write-Host "Restarting Computer..."
    Restart-Computer -Force
} else {
    Write-Host "Closing Window..."
    Start-Sleep -Seconds 1
    exit
}