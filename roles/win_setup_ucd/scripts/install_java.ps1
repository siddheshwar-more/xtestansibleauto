Param(
  [string] $javaPkgPath = '',
  [string] $installerDir = "C:\setup",
)

Set-Variable regEnvPath -Option Constant -Value 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment'

function Get-PackageSetupLoc {
  $loc = $installerDir
  $loc
}

function Get-JdkPackagePath {
  $loc = "$(Get-PackageSetupLoc)\jre.zip"
  $loc
}

function SetEnv-JavaHome($jdkInstallLocation) {
  $homePath = $jdkInstallLocation 

  write-host "Setting JAVA_HOME in the registry to $homePath..."
  Set-ItemProperty -Path $regEnvPath -Name JAVA_HOME -Value $homePath | Out-Null

  write-host 'Setting JAVA_HOME for the current session...'
  Set-Item Env:JAVA_HOME "$homePath" | Out-Null

  # Additional check
  if ([environment]::GetEnvironmentVariable("JAVA_HOME","machine") -eq $null)
  {
    [environment]::setenvironmentvariable("JAVA_HOME",$homePath,"machine") | Out-Null
  }

  write-host 'Modifying path variable to point to java executable...'
  $currentPath = (Get-ItemProperty -Path $regEnvPath -Name PATH).Path
  $currentPath = $currentPath + ';' + "$homePath"
  Set-ItemProperty -Path $regEnvPath -Name PATH -Value $currentPath
  Set-Item Env:PATH "$currentPath"
}

function Install-JDK($java_pkg_path) {
  $jreZip = $java_pkg_path
  $destination = Get-PackageSetupLoc
  Unzip-Archive $jreZip $destination
  $jreSourceLoc = $(Get-ChildItem $destination\* | where {$_.name -like "jre-*"}).fullname

  $logPath = "$($env:tmp)\java_install_log.txt"
  $psLog = "$($env:tmp)\java_install_ps_log.txt"
  $psErr = "$($env:tmp)\java_install_ps_err.txt"

  try {
    write-host "Installing java on the box "
    Start-Process $jreSourceLoc -Wait -NoNewWindow  -ArgumentList "/s"
    write-host "JDK installed on box"
  }
  catch [System.Exception] 
  {
    lerr $_.Exception.Message
    lerr $_.Exception.StackTrace
    Break
  }

  $jDest = "C:\Program Files\Java"

  $installPath = $(Get-ChildItem $jDest\* | where {$_.name -like "jre*"}).FullName

  SetEnv-JavaHome $installPath

  return $installPath
}

## Execution starts from here

Install-JDK($javaPkgPath)
