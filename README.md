# Homebrew Tap for LEAPP

A collection of Homebrew formulas and casks for LEAPP digital forensics tools, focusing on mobile device analysis.

## Available Tools

### LEAPP Suite
Tools for parsing and analyzing mobile device data:

- [iLEAPP](https://github.com/abrignoni/iLEAPP) - iOS Logs, Events, And Plists Parser
- [ALEAPP](https://github.com/abrignoni/ALEAPP) - Android Logs, Events, And Protobuf Parser
- [VLEAPP](https://github.com/abrignoni/VLEAPP) - Vehicle Logs, Events, And Protobuf Parser
- [RLEAPP](https://github.com/abrignoni/RLEAPP) - Warrant Returns Parser

## Installation

First, add this tap to your Homebrew. This tap will remain until you specifically untap it.
```
brew tap leapps-org/leapps
```

Then install the tools you need:

### CLI Tools
#### iOS Parser
```
brew install ileapp
```

#### Android Parser
```
brew install aleapp
```

#### Vehicle Parser
```
brew install vleapp
```

### GUI Applications
#### iOS Parser GUI
```
brew install --cask ileapp-gui
```
#### Android Parser GUI
```
brew install --cask aleapp-gui
```
#### Vehicle Parser GUI
```
brew install --cask vleapp-gui
```

## Updates

First, update homebrew itself:
```
brew update
```

This will list all of the applications that have newer versions:
```
brew outdated
```

To update all of your homebrew installed applications (not just LEAPPs):
```
brew upgrade
```

To update only specific applications, list their names separated by spaces:
```
brew upgrade ileapp aleapp
```

## Uninstall and Remove

### Command Line Applications
Use this command to uninstall the application(s) you no longer want installed:
```
brew uninstall ileapp
```

### GUI Applications
Use this to remove the GUI applications
```
brew uninstall --cask ileapp-gui aleapp-gui vleapp-gui
```

### Removing Tap
This will not remove any of the tools installed through this tap. See instructions above to remove those.

Remove the tap from homebrew with this:
```
brew untap leapps-org/leapps
```
