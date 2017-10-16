param(
[string]$installerdir, 
[string]$vncPkgName
)

Set-Location "$installerdir"

$cmd = "msiexec.exe /i $vncPkgName /q"

Invoke-Expression $cmd 
