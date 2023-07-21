$configFile = "settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json

Write-Output $conf.pref.inputFilename

$conf.var.latestWorkingFolderId = "123456789abc"
$conf | ConvertTo-Json | set-content $configFile