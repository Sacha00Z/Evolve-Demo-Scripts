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
$tempPath = Join-Path ([System.IO.Path]::GetTempPath()) $conf.local.outputFilename
$response = Invoke-WebRequest $uri -Method 'GET' -Headers $headers -OutFile $tempPath
Write-Output $response | Format-List -Property StatusCode, StatusDescription

if ($IsWindows) {
    Start-Process $tempPath
}
else {
    & open $tempPath
}

# Pause
#Read-Host "Press Enter to continue..."