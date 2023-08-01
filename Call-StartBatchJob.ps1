<#
This script calls the Evolve Generate startBatchJob API.
It then polls for the job status using the batchJobStatus API.
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
$body.Add("workingFolderId", $conf.var.latestWorkingFolderId)
$body.Add("expiration", (Get-Date).AddDays(1).ToString("o"))  # Data Retention Policy: Keep it until tomorrow.
$variables = @(
    [pscustomobject]@{codeName = 'templatePath'; value = $conf.remote.templatePath }
    [pscustomobject]@{codeName = 'dataInputFilename'; value = $conf.local.inputFilename }
    [pscustomobject]@{codeName = 'outputFileName'; value = $conf.local.outputFilename }
)
$body.Add("variables", $variables)

## Execute http request
$response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers -Body ($body | ConvertTo-Json)
Write-Output $response | Format-List

## Launch the GUI - deep link to the job
Start-Process ($conf.env.baseUrl + "/generate/#/jobs/view/" + $response.batchJobId + "//")


## Prepare the status service call
$statusUri = $conf.env.baseUrl + $conf.app.generate + "/batchJobStatus"
$statusBody = New-Object "System.Collections.Generic.Dictionary[[String],[PSObject]]"
$statusBody.Add("batchJobId", $response.batchJobId)

## Poll for the status of the job
while ($statusResponse.batchJob.state -ne "Finished") {
    $statusResponse = Invoke-RestMethod $statusUri -Method 'POST' -Headers $headers -Body ($statusBody | ConvertTo-Json)
    $i = $statusResponse.batchJob.progress
    Write-Progress -Activity "Progress" -Status "$i% Complete:" -PercentComplete $i
    Start-Sleep -Milliseconds 2
}

Start-Sleep -Milliseconds 100
Write-Progress -Activity "Progress" -Status "100% Complete:" -Completed
Write-Output "Processing Complete."

# Pause
#Read-Host "Press Enter to continue..."