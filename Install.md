# Installation Details

Homebrew 6 refuses to load a tap that is not one of its own until you trust it, and `brew tap` fails with "Refusing to load ... from untrusted tap". Trust this tap first (an older Homebrew that has no `brew trust` can skip this line):
```
brew trust leapps-org/leapps
```

Then add this tap to your Homebrew. This tap will remain until you specifically untap it.
```
brew tap leapps-org/leapps
```

Then install the tools you need:

### iLEAPP, ALEAPP and RLEAPP
Each of these is one program. The cask installs the app, and links its command line as `ileapp`, `aleapp` or `rleapp`. Started without arguments it opens the window; given arguments it is the command line.

#### iOS Parser
```
brew install --cask ileapp-gui
```
#### Android Parser
```
brew install --cask aleapp-gui
```
#### Warrant Returns Parser
```
brew install --cask rleapp-gui
```

The `ileapp`, `aleapp` and `rleapp` formulae stay at the last release that had a separate command-line download and are deprecated. If you have one installed, the cask keeps the formula's command line in place. To move to the one inside the app:
```
brew uninstall ileapp
brew reinstall --cask ileapp-gui
```

### VLEAPP
#### Vehicle Parser (command line)
```
brew install vleapp
```
#### Vehicle Parser GUI
```
brew install --cask vleapp-gui
```

### LAVA
#### LEAPP Artifact Viewer App
```
brew install --cask lava
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
brew upgrade ileapp-gui aleapp-gui
```

## Uninstall and Remove

### Command Line Applications
Use this command to uninstall the application(s) you no longer want installed:
```
brew uninstall vleapp
```

### GUI Applications
Use this to remove the GUI applications
```
brew uninstall --cask ileapp-gui aleapp-gui vleapp-gui rleapp-gui lava
```

### Removing Tap
This will not remove any of the tools installed through this tap. See instructions above to remove those.

Remove the tap from homebrew with this:
```
brew untap leapps-org/leapps
```
