<#
This script calls the Azure Blob Storage API to download a file.
You need to have a valid settings file and data file for this script to work
This script is tested in PowerShell Core 7
#>

## initialise script
$configFile = ".\settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json

## initialise http request
$uri = $conf.blob.sasUriRoot + "/batch/" + $conf.var.latestWorkingFolderId + "/" + $conf.local.outputFilename + $conf.blob.sasUriAuth

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept", "application/json")
$headers.Add("x-ms-blob-type", "BlockBlob")

## Execute http request
$response = Invoke-WebRequest $uri -Method 'GET' -Headers $headers -OutFile ($ENV:Temp + "\" + $conf.local.outputFilename)
Write-Output $response | Format-List -Property StatusCode, StatusDescription

Start-Process ($ENV:Temp + "\" + $conf.local.outputFilename)

# Pause
#Read-Host "Press Enter to continue..."