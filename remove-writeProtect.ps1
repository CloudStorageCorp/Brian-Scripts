$writeProtectedDisk = get-disk|where-object isreadonly -eq $true

if (-not $writeProtectedDisk) {
    write-host "No write protected disk found"
    return
}

write-host "Found $($writeProtectedDisk.count) write protected disk"

$writeProtectedDisk | Select-Object number,isreadonly

Write-Host "Removing Write protect"
$writeProtectedDisk | set-disk -IsReadOnly $false
$writeProtectedDisk | Select-Object number,isreadonly