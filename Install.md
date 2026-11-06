# Installation

Add the tap, then install whichever tools you need:

Homebrew 6 requires trusting this tap first. Older versions without `brew trust`
can skip this command:

```sh
brew trust leapps-org/leapps
```

```sh
brew tap leapps-org/leapps
brew install --cask leapps-org/leapps/ileapp
brew install --cask leapps-org/leapps/aleapp
brew install --cask leapps-org/leapps/rleapp
brew install --cask leapps-org/leapps/vleapp
brew install --cask leapps-org/leapps/dleapp
brew install --cask leapps-org/leapps/gleapp
brew install --cask leapps-org/leapps/lava
```

Each parser cask installs the combined GUI/CLI app and links its command into
Homebrew's `bin` directory. No shell alias or separate formula is needed:

```sh
ileapp --help
aleapp --help
rleapp --help
vleapp --help
dleapp --help
gleapp --help
```

Running a parser without arguments opens its GUI. You can also launch the app
from Applications. The executable stays inside its app bundle alongside its
dependencies. Custom Homebrew `--appdir` locations are supported.

## Upgrading older installations

```sh
brew update
brew upgrade --cask
```

The tap includes formula-to-cask migration records for the original four parsers and
rename records from `ileapp-gui`, `aleapp-gui`, `rleapp-gui`, `vleapp-gui`, and `dleapp-gui`
to their plain names. Current Homebrew can migrate these during an update.
Follow any migration or trust instructions Homebrew prints.

For a former formula installation, Homebrew may unlink the old formula and
install the cask, leaving the old formula keg for you to remove. If automatic
migration does not complete, use the following for each affected tool
(iLEAPP shown):

```sh
brew uninstall --formula --force ileapp
brew install --cask leapps-org/leapps/ileapp
```

If you had the old GUI cask, its renamed installation can be migrated explicitly:

```sh
brew migrate --cask ileapp
brew upgrade --cask ileapp
```

If both the old CLI formula and GUI cask were installed, remove the old formula
before upgrading the cask so its command link is free.

## Updates

```sh
brew update
brew outdated --cask
brew upgrade --cask ileapp aleapp rleapp vleapp dleapp gleapp lava
```

## Uninstall

Uninstalling a cask removes both its app and its Homebrew-managed CLI link:

```sh
brew uninstall --cask ileapp aleapp rleapp vleapp dleapp gleapp lava
```

To remove the tap after uninstalling the tools:

```sh
brew untap leapps-org/leapps
```
