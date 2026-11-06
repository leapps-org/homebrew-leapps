# Homebrew Tap for LEAPP

A collection of Homebrew casks for LEAPP digital forensics tools, focusing on mobile device analysis.

## Available Tools

### LEAPP Suite
Tools for parsing and analyzing mobile device data:

- [iLEAPP](https://github.com/abrignoni/iLEAPP) - iOS Logs, Events, And Plists Parser
- [ALEAPP](https://github.com/abrignoni/ALEAPP) - Android Logs, Events, And Protobuf Parser
- [VLEAPP](https://github.com/abrignoni/VLEAPP) - Vehicle Logs, Events, And Protobuf Parser
- [RLEAPP](https://github.com/abrignoni/RLEAPP) - Warrant Returns Parser
- [DLEAPP](https://github.com/abrignoni/DLEAPP) - Desktop operating system artifact parser
- [GLEAPP](https://github.com/abrignoni/GLEAPP) - Image and video forensic triage toolkit
- [LAVA](https://github.com/leapps-org/LAVA-releases) - LEAPP Artifact Viewer App

## Installation

The parser casks install both the GUI app and CLI command:

```sh
brew tap leapps-org/leapps
brew install --cask leapps-org/leapps/ileapp
ileapp --help
```

On Homebrew 6, run `brew trust leapps-org/leapps` before tapping.

Use `aleapp`, `rleapp`, `vleapp`, `dleapp`, or `gleapp` for the other tools. Running a parser
without arguments opens its GUI. The former CLI formulas and `*-gui` casks
migrate to these plain cask names; see the installation guide for upgrade steps.

[Installation Details](Install.md)

## Maintenance

[Maintenance Details](Maintenance.md)
