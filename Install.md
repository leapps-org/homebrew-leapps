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

### iLEAPP, ALEAPP, RLEAPP, VLEAPP and DLEAPP
Each of these is one program. The cask installs the app, and links its command line as `ileapp`, `aleapp`, `rleapp`, `vleapp` or `dleapp`. Started without arguments it opens the window; given arguments it is the command line.

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
#### Vehicle Parser
```
brew install --cask vleapp-gui
```
#### Desktop Parser
```
brew install --cask dleapp-gui
```

The `ileapp`, `aleapp`, `rleapp` and `vleapp` formulae stay at the last release that had a separate command-line download and are deprecated. If you have one installed, the cask keeps the formula's command line in place. To move to the one inside the app:
```
brew uninstall ileapp
brew reinstall --cask ileapp-gui
```

### GLEAPP
#### Image and video triage
```
brew install --cask gleapp
```
The cask installs the app only; it does not link a command line.

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
Use this command to uninstall a deprecated command-line formula you still have installed:
```
brew uninstall ileapp
```

### GUI Applications
Use this to remove the applications
```
brew uninstall --cask ileapp-gui aleapp-gui vleapp-gui rleapp-gui dleapp-gui gleapp lava
```

### Removing Tap
This will not remove any of the tools installed through this tap. See instructions above to remove those.

Remove the tap from homebrew with this:
```
brew untap leapps-org/leapps
```
