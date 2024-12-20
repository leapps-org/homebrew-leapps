# Maintaining the Automated Homebrew Formula & Cask Update Process

This document provides guidelines for maintaining and extending the GitHub Actions workflow that automatically updates Homebrew formulae and casks for multiple tools, using a JSON configuration file.

## Overview

The workflow performs the following tasks:

1. **Reads a JSON configuration file (`tools.json`)** containing tool definitions (repo URLs, binary names, class names, etc.).
2. **Fetches the latest release tag** for each tool using the GitHub API.
3. **Compares the current installed URLs** in formulae/casks to the latest release URLs.
4. **If out-of-date**, downloads the new assets, calculates SHA256 checksums, and generates updated formulae and casks from template files.
5. **Runs `brew audit`** to ensure compliance.
6. **Commits and pushes changes** to the repository, maintaining up-to-date formulae and casks.

## Repository Structure
```
. 
├── .github/ 
│ └── workflows/ 
│   └── update_homebrew.yml # GitHub Action workflow 
├── Formula/ 
│ ├── ileapp.rb 
│ ├── aleapp.rb 
│ ├── vleapp.rb 
│ ├── tleapp.rb 
│ ... other formulae ... 
├── Casks/ 
│ ├── ileapp-gui.rb 
│ ├── aleapp-gui.rb 
│ ├── vleapp-gui.rb 
│ ├── tleapp-gui.rb 
│ ... other casks ... 
├── templates/ 
│ ├── formula_template.rb 
│ └── cask_template.rb 
└── tools.json
```


## `tools.json` Format

`tools.json` should contain a top-level `tools` array. Each tool object includes:

- `name`: Tool name (e.g., `ileapp`)
- `repo`: GitHub repository URL (e.g., `https://github.com/abrignoni/iLEAPP`)
- `binary`: Name of the installed CLI binary (e.g., `ileapp`)
- `class_name`: Ruby class name for the formula (e.g., `Ileapp`)
- `cask_name`: Name of the cask (e.g., `ileapp-gui`)
- `app_name`: Name of the GUI app (e.g., `iLEAPP GUI`)
- `desc`: Description for the formula
- `desc_gui`: Description for the cask (GUI version)

**Example:**

```json
{
  "tools": [
    {
      "name": "ileapp",
      "repo": "https://github.com/abrignoni/iLEAPP",
      "binary": "ileapp",
      "class_name": "Ileapp",
      "cask_name": "ileapp-gui",
      "app_name": "iLEAPP GUI",
      "desc": "Digital forensics tool for parsing iOS backup files, images, and artifacts",
      "desc_gui": "Digital forensics tool for analyzing iOS artifacts with graphical interface"
    },
    {
      "name": "aleapp",
      "repo": "https://github.com/abrignoni/aLEAPP",
      "binary": "aleapp",
      "class_name": "Aleapp",
      "cask_name": "aleapp-gui",
      "app_name": "aLEAPP GUI",
      "desc": "Digital forensics tool for Android backup files, images, and artifacts",
      "desc_gui": "Digital forensics tool for analyzing Android artifacts with graphical interface"
    }
    // ... Add other tools as needed ...
  ]
}
