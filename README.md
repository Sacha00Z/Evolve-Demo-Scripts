# Evolve PowerShell Demo

![version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FSacha00Z%2FEvolve-Demo-Scripts%2Fmaster%2Fpackage.json&query=%24.version&label=version)
![open issues](https://img.shields.io/github/issues-raw/Sacha00Z/Evolve-Demo-Scripts)
![license](https://img.shields.io/github/license/Sacha00Z/Evolve-Demo-Scripts)

## Overview

A collection of demo scripts which can be executed to show how external systems can call the Evolve REST API to achieve outcomes.

You will need access to
[Quadient Inspire Evolve](https://www.quadient.com/en/customer-communications/inspire-evolve)
and the Generate service.

## Getting Started

### Prerequisites

In order to build and use the connector, the following software must be
installed:

- [Powershell Core for MultiPlatforms](https://learn.microsoft.com/en-us/powershell/)

### Build and Use

No build is required. Just clone this repository, configure "settings.json", and run the scripts:

```bash
git clone https://github.com/Sacha00Z/Evolve-Demo-Scripts.git
```

In oder for the scripts to execute, you will need to either create or update a settings file, and place it in the same directory as these scripts:

Copy this and paste into `settings.json` file, if you don't already have one (shame on me):

```json
{
  "pref": {
    "_": "local settings",
    "inputFilename": "BatchInput.json",
    "outputFilename": "BatchSpoolFile.pdf",
    "workingFolderName": "myWorkingFolder"
  },
  "env": {
    "_": "To be obtained from Quadient Cloud Administration UI. Do not terminate with a '/' character",
    "baseUrl": "https://yourcompany.quadientcloud.com.au",
    "bearerToken": "ABCdef123/f8NoYouCantHaveMinealkjdhflkjsahdf"
  },
  "blob": {
    "_": "To be obtained from Generate Administration UI. Split the string into two, before the '?' character",
    "sasUriRoot": "https://quadientprodau732hjj.blob.core.windows.net/12345678-user-container",
    "sasUriAuth": "?sv=2020-08-04&si=sas-user-NoYouCantHaveMine-12345678&sr=c&sig=ABCdefHIJklmNoYouCantHaveMine847kaljdgf"
  },
  "app": {
    "_": "Do not edit, unless cloud application specs change",
    "authoring": "/authoring/api/system/v1",
    "frontOffice": "/frontoffice/api/system/v2",
    "generate": "/production/v3",
    "digitalDelivery": "/api/query/Messenger"
  },
  "var": {
    "_": "These values get updated by scripts",
    "latestWorkingFolderId": "",
    "latestBatchId": "",
    "expiration": ""
  }
}
```

This file has the following structure:

- **pref**: User Preferences. Update as required, but probably avoid spaces and special characters.
- **env**: Environment settings.
  - **baseUrl**: Url of your *Quadient Cloud* environment. Please ensure that the "baseUrl" ends with `.com.au`, `.com` or `.eu`. No trailing "`/`" character.
  - **bearerToken**: Obtain this from your *Quadient Cloud* User Interface (*Quadient Cloud Settings* App, Administration, API Keys)
- **blob**: Azure Blob Storage settings. Obtain this from your *Quadient Cloud* User Interface (*Generate* App, Administration, Company Storage, Azure Connections)
  - **sasUriRoot**: When you generate a *SAS URI* from the *Azure Connections* UI, you will be given a very long string. Split the string into 2, just before the "`?`" character, and place the first half here.
  - **sasUriAuth**: Place the second half of that string here, starting with the "`?`" character.
- **app**: Do not edit, unless cloud application specs change.
- **var**: Do not edit, these values get updated by scripts.

## History

See [CHANGELOG.md](https://github.com/Sacha00Z/Evolve-Demo-Scripts/blob/master/CHANGELOG.md)
for more information.

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
