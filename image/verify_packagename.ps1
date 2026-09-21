Get-ChildItem "Registry::HKEY_CLASSES_ROOT\Installer\Products" | ForEach-Object {
    $sourceListPath = Join-Path $_.PSPath "SourceList"
    if (Test-Path $sourceListPath) {
        $pkg = Get-ItemProperty -Path $sourceListPath -Name PackageName -ErrorAction SilentlyContinue
        if ($pkg) {
            [PSCustomObject]@{
                ProductKey  = $_.PSChildName
                PackageName = $pkg.PackageName
            }
        }
    }
} | Where-Object { $_.PackageName -match "CsAgent" } #CsAgent