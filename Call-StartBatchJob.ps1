<#
This script calls the Evolve Generate startBatchJob API.
You need to have a valid settings file for this script to work
This script is tested in PowerShell Core 7
#>

## initialise script
$configFile = ".\settings.json"
$conf = Get-Content $configFile | ConvertFrom-Json


## initialise http request
$uri = $conf.env.baseUrl + $conf.app.generate + "/startBatchJob"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept", "application/json")
$headers.Add("Authorization", "Bearer " + $conf.env.bearerToken)

## Create the http body
$body = New-Object "System.Collections.Generic.Dictionary[[String],[PSObject]]"
$body.Add("pipelineName", $conf.remote.pipelineName)            # User preference: settings.json
$body.Add("description", "Evolve Demo Scripts Request")       # User preference: settings.json
$body.Add("expiration", (Get-Date).AddDays(1).ToString("o"))  # Data Retention Policy: Keep it until tomorrow.
$variables = @(
    [pscustomobject]@{codeName = 'templatePath'; value = $conf.remote.template }
    [pscustomobject]@{codeName = 'dataInputFilename'; value = $conf.local.inputFilename }
    [pscustomobject]@{codeName = 'outputFileName'; value = $conf.local.outputFilename }
)
$body.Add("variables", $variables)

## Execute http request
$response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers -Body ($body | ConvertTo-Json)
Write-Output $response | Format-List

# Pause
Read-Host "Press Enter to continue..."