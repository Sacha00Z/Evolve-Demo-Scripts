# Evolve PowerShell Demo

![version)](https://img.shields.io/github/v/tag/Sacha00z/Evolve-Demo-Scripts?label=version)
![open issues](https://img.shields.io/github/issues-raw/Sacha00Z/Evolve-Demo-Scripts)
![license](https://img.shields.io/github/license/Sacha00Z/Evolve-Demo-Scripts)

## Overview

A collection of demo scripts which can be executed to show how external systems can call the Evolve REST API to achieve outcomes.

You will need access to
[Quadient Inspire Evolve](https://www.quadient.com/en/customer-communications/inspire-evolve)
and the Generate service.

## Getting Started

### Prerequisites

In order to use these scripts, the following software must be
installed:

- [Powershell Core for MultiPlatforms](https://learn.microsoft.com/en-us/powershell/)

### Build and Use

No build is required. Just clone this repository, configure "settings.json", and run the scripts:

```bash
git clone https://github.com/Sacha00Z/Evolve-Demo-Scripts.git
```

In oder for the scripts to execute, you will need to update the `settings.json` file.

This file has the following structure:

- **local**: Local filenames. Update to match your input file (found in the `data` folder) and the name of the output file.
- **remote**: Evolve Generate Pipeline Settings
  - **workingFolderName**: Can be any string (best to avoid spaces and special characters) - should either identify you (as a developer) or the project (eg Q4-statements)
  - **pipelineName**: You need to build a pipeline in Evolve which executes the steps you need (EG: Print PDF). This setting should point to your named pipeline.
  - **templatePath**: `icm://` path to your template. Obtain from Content Author &rarr; Content Manager &rarr; Your Template &rarr; View Versions &rarr; Object Path
- **env**: Environment settings.
  - **baseUrl**: Url of your *Quadient Cloud* environment. Please ensure that the "baseUrl" ends with `.com.au`, `.com` or `.eu`. No trailing "`/`" character.
  - **bearerToken**: Obtain this from your *Quadient Cloud* User Interface (*Quadient Cloud Settings* App, Administration, API Keys)
- **blob**: Azure Blob Storage settings. Obtain this from your *Quadient Cloud* User Interface (*Generate* App, Administration, Company Storage, Azure Connections)
  - **sasUriRoot**: When you generate a *SAS URI* from the *Azure Connections* UI, you will be given a very long string. Split the string into 2, just before the "`?`" character, and place the first half here.
  - **sasUriAuth**: Place the second half of that string here, starting with the "`?`" character.
- **app**: Do not edit, unless cloud application specs change.
- **var**: Do not edit, these values get updated by scripts.

## Scripts

The repository contains the following scripts:

### `Call-HealthCheck.ps1`

Calls the Health Check API for Generate Batch, and displays results.

### `Call-CreateWorkingFolder.ps1`

Creates a Working Folder in Azure Blob Storage, and registers it with the Generate Application. Demo folders that are created with this script will be retained for 1 day before being purged (Demonstrating Data Retention Principals).

When this script executes the http request, it saves the name of the working folder to the settings file, so that subsequent scripts can *use* the folder for file storage.

### `Call-PutDataFile.ps1`

Stores a data file in the working folder (as created by `Call-CreateWorkingFolder.ps1`). This script will fail if you do not create a working folder first.

You can use any input file you like. Just save it in the data folder of this project and update the settings file so that `inputFilename` points to your file. Also make sure that the format of that file matches your template's expectations.

### `Call-StartBatchJob.ps1`

Starts a batch job and monitors the status of that batch job.

You can modify this script to either launch the GUI Job Status, or display the status in the terminal (or both).

Note that this script will fail, if you have not PUT a data file into a working folder within the last 24 hours.

This script requires:

- A pipeline, configured in your Evolve environment.
  - Your pipeline should expect to receive 3 parameters (`templatePath` in Content Manager, `dataInputFilename` in Azure Blob Storage, `outputFileName` to produce).
- A template, configured in Content Author
- Successful execution of `Call-PutDataFile.ps1` to upload the data file.

Ensure that you have configured the `remote` section of the `settings.json` file, to point to your pipeline and template.

## Roadmap

See the [open issues](https://github.com/Sacha00Z/Evolve-Demo-Scripts/issues)
for a list of proposed features (and known issues).

## Contributing

Contributions are what make the open source community such an amazing place
to learn, inspire, and create. Any contributions you make are sincerely
appreciated.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Copyright (c) 2023 Quadient Group AG and distributed under the MIT License.
See `LICENSE` for more information.

## Contact

Sacha Trube - [@Sacha00Z](https://twitter.com/Sacha00Z)

Project Link: [https://github.com/Sacha00Z/Evolve-Demo-Scripts](https://github.com/Sacha00Z/Evolve-Demo-Scripts)

Thanks to Robert Tucker - [@robertwtucker] for providing the outline of this README file. Aspiring to do things better is fun. Learning from legends is wise.
