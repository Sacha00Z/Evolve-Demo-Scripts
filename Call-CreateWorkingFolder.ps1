<#
This script calls the Evolve Generate Create Working Folder API.
You need to have a valid settings file for this script to work
This script is tested in PowerShell Core 7
#>

## initialise script
$configFile = ".\settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json


## initialise http request
$uri = $conf.env.baseUrl + $conf.app.generate + "/createWorkingFolder"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept", "application/json")
$headers.Add("Authorization", "Bearer " + $conf.env.bearerToken)

$body = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$body.Add("name", $conf.remote.workingFolderName)               # User preference: settings.json
$body.Add("expiration", (Get-Date).AddDays(1).ToString("o"))  # Data Retention Policy: Keep it until tomorrow.

## Execute http request
$response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers -Body ($body | ConvertTo-Json)
Write-Output $response | Format-List

## Save the response data "workingFolderId" to the settings file
$conf.var.latestWorkingFolderId = $response.workingFolderId
$conf | ConvertTo-Json | set-content $configFile


# Pause
#Read-Host "Press Enter to continue..."