param([string]$sourcePath,[string]$dest)

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::ExtractToDirectory($sourcePath, $dest)


