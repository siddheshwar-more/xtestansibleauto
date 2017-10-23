param(
[string]$installerdir 
)

Set-Location "$installerdir"

# command to install the UCD agent
$cmd = ""

Invoke-Expression $cmd 
