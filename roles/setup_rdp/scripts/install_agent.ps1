param(
[string]$installerdir, 
[string]$notificationServer,
[string]$notificationWeb
)

Set-Location "$installerdir"

# Refer : https://support.symantec.com/en_US/article.HOWTO2852.html

$cmd = ".\aexnsc.exe -s -a ns=$notificationServer nsweb=$notificationWeb NOSTARTMENU NOTRAYICON OKTOREBOOT /s"

Invoke-Expression $cmd 
