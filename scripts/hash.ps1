$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

$files = Get-ChildItem -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.Name -ne 'CHECKSUMS.sha256' } |
    Sort-Object FullName

$lines = foreach ($file in $files) {
    $hash = (Get-FileHash -Algorithm SHA256 $file.FullName).Hash.ToLower()
    $relative = $file.FullName.Substring($Root.Length + 1).Replace('\\','/')
    "$hash  ./$relative"
}

$lines | Set-Content -Encoding ASCII CHECKSUMS.sha256
Write-Host "Updated CHECKSUMS.sha256"
