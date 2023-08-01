<#
This script calls the Evolve Generate Create Working Folder API.
You need to have a valid settings file and data file for this script to work
This script is tested in PowerShell Core 7
#>

## initialise script
$configFile = ".\settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json

## initialise http request
$uri = $conf.blob.sasUriRoot + "/batch/" + $conf.var.latestWorkingFolderId + "/" + $conf.local.inputFilename + $conf.blob.sasUriAuth

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept", "application/json")
$headers.Add("x-ms-blob-type", "BlockBlob")

$body = Get-Content ("./data/" + $conf.local.inputFileName)

## Execute http request
$response = Invoke-WebRequest $uri -Method 'PUT' -Headers $headers -Body $body
Write-Output $response | Format-List -Property StatusCode, StatusDescription

# Pause
#Read-Host "Press Enter to continue..."