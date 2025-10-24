do {
    Clear-Host

    # LIST DISKS
    Write-Host "Available Physical Disks:"
    Get-Disk | ForEach-Object {
        Write-Host "Disk Number: $($_.Number) | Size: $([Math]::Round($_.Size / 1GB, 2)) GB | Status: $($_.OperationalStatus) | Media: $($_.MediaType)"
    }

    # PROMPT DISK NUMBER WITH 1 CHECK
    $diskNumber = Read-Host -Prompt "Enter the disk number to check (e.g. 0, 1, 2, 3, etc): "
    if (-not ($diskNumber -match '^\d+$')) {
        Write-Error "Input invalid. Please select a numerical Disk Number: "
        $diskNumber = Read-Host -Prompt "Enter the disk number to check (e.g. 0, 1, 2, 3, etc): "
    } 

    # SETTING VARIABLES
    $DiskPath = "\\.\PhysicalDrive$diskNumber"
    $sectorSize = 512
    $sectorCount = 100
    $totalBytes = $sectorSize * $sectorCount
    [byte[]]$buffer = New-Object byte[] $totalBytes

    # TRY READ DISK STATUS
    try {
        $fs = [System.IO.File]::Open($DiskPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)

        $bytesRead = $fs.Read($buffer, 0, $totalBytes)

        if ($bytesRead -ne $totalBytes) {
            Write-Error "Only read $bytesRead bytes. Expected $totalBytes. Check disk or permissions."
        } else {
            $allZero = $true
            $allOne = $true

            foreach ($b in $buffer) {
                if ($b -ne 0x00) { $allZero = $false }
                if ($b -ne 0xFF) { $allOne = $false }
                if (-not $allZero -and -not $allOne) { break }
            }

            if ($allZero -or $allOne) {
                Write-Output "Disk has been wiped."
            } else {
                Write-Output "Disk has not been wiped. Non-zero bits present."
            }
        }

        $fs.Close()

    } catch {
        Write-Error "Failed to read disk: $_"
    }

    # ASK TO RUN AGAIN
    $response = Read-Host "Check another disk? (Y/N)"
}
while ($response -match '^(Y|y)$')

Write-Host "Exiting..."