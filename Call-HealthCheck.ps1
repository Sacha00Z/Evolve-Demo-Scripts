<#
This script calls the Evolve Generate Healthcheck API.
You need to have a valid settings file and json* file for this script to work
This script is tested in PowerShell Core 7
#>

## initialise script
$configFile = ".\settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json


## initialise http request
$uri = $conf.env.baseUrl + $conf.app.generate + "/appHealth"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept", "application/json")
$headers.Add("Authorization", "Bearer " + $conf.env.bearerToken)

$body = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$body.Add("application", "GenerateBatch")


## Execute http request
$response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers -Body ($body | ConvertTo-Json)
Write-Output $response | Format-List


# Pause
Read-Host "Press Enter to continue..."