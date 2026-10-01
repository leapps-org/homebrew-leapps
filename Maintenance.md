# Maintaining the Automated Homebrew Formula & Cask Update Process

This document provides guidelines for maintaining and extending the GitHub Actions workflow that automatically updates Homebrew formulae and casks for multiple tools, using a JSON configuration file.

## Overview

The workflow performs the following tasks:

1. **Reads a JSON configuration file (`tools.json`)** containing tool definitions, repository URLs, asset naming overrides, and whether the tool has a formula, cask, or both.
2. **Fetches the latest release** for each configured repository using the GitHub API.
3. **Finds the expected macOS release assets** from the release asset list. See "Release asset names" below.
4. **Compares the current installed URLs** in formulae/casks to the latest release URLs.
5. **If out-of-date**, takes each SHA256 from the release itself (its `SHA256SUMS.txt`, and the digest GitHub records for the asset), downloads each disk image, checks the download against that hash, and mounts it to check it holds the app the cask will name. Then it generates updated formulae and casks from template files.
6. **Commits and pushes changes** to the repository, maintaining up-to-date formulae and casks.
7. **Fails the run** when a tool could not be updated, after committing the tools that could. A release the updater cannot read shows as a failed run, not as "no changes".

The steps live in `scripts/update_homebrew.sh`, which the workflow runs on a macOS runner (mounting a disk image needs `hdiutil`).

## Repository Structure

```text
.
|-- .github/
|   `-- workflows/
|       |-- test_updater.yml
|       `-- update_homebrew.yml
|-- Formula/
|   |-- aleapp.rb
|   |-- ileapp.rb
|   |-- rleapp.rb
|   `-- vleapp.rb
|-- Casks/
|   |-- aleapp-gui.rb
|   |-- ileapp-gui.rb
|   |-- lava.rb
|   |-- rleapp-gui.rb
|   `-- vleapp-gui.rb
|-- scripts/
|   `-- update_homebrew.sh
|-- templates/
|   |-- formula_template.rb
|   `-- cask_template.rb
|-- tests/
|   `-- test_update_homebrew.sh
`-- tools.json
```

## `tools.json` Format

`tools.json` should contain a top-level `tools` array. Each tool object can include:

- `name`: Tool name (for example, `ileapp`).
- `repo`: GitHub repository URL (for example, `https://github.com/abrignoni/iLEAPP`).
- `formula`: Optional boolean. Defaults to `true`; set to `false` for cask-only tools such as LAVA.
- `cask`: Optional boolean. Defaults to `true`; set to `false` for formula-only tools.
- `binary`: Name of the installed CLI binary. Required when `formula` is enabled. For a release with one program per tool, it is also the program inside the app that the cask links.
- `class_name`: Ruby class name for the formula. Required when `formula` is enabled.
- `cask_name`: Name of the cask. Required when `cask` is enabled.
- `app_name`: Name of the GUI app. Required when `cask` is enabled.
- `app_bundle`: Optional app bundle name without `.app`. Defaults to `${name}GUI` for the per-program release names, and to the tool's name as the release spells it (`iLEAPP`) for a release with one program per tool.
- `desc`: Description for the formula.
- `desc_gui`: Description for the cask.
- `intel_asset`, `arm_asset`, `gui_intel_asset`, `gui_arm_asset`: Optional release asset filename templates. Supported placeholders are `{{name}}`, `{{version}}`, and `{{version_no_v}}`.

## Release asset names

For each tool the updater tries, in this order:

1. The names set in `tools.json` (`intel_asset`, `arm_asset`, `gui_intel_asset`, `gui_arm_asset`).
2. The per-program names, with and without the `v`: `{{name}}-{{version}}-macOS_Mac_Intel.zip` and `{{name}}-{{version}}-macOS_Apple_Silicon.zip` for the formula, `{{name}}GUI-{{version}}-macOS_Mac_Intel.dmg` and `{{name}}GUI-{{version}}-macOS_Apple_Silicon.dmg` for the cask. VLEAPP publishes these.
3. The names of a release with one program per tool: `<Tool>-<version>-macos-x64.dmg` and `<Tool>-<version>-macos-arm64.dmg`, with no `v` in the version and the tool spelled the project's way (`iLEAPP-2026.4.3-macos-arm64.dmg`). iLEAPP, ALEAPP and RLEAPP publish these.

A release with one program per tool has no command-line download. Its disk image holds `<Tool>.app`, and the command line is inside it at `<Tool>.app/Contents/MacOS/<binary>`. For such a release the updater:

- writes the cask with `app "<Tool>.app"` and a `binary` stanza that links the command line, so `brew install --cask ileapp-gui` also puts `ileapp` on the PATH;
- leaves the formula at the last version that had a command-line download and marks it deprecated with the cask as its replacement.

A tool that moves from the per-program names to the new ones needs no change here: the updater follows the release.

## When a run fails

The run fails when a release has none of the names above, when `SHA256SUMS.txt` and GitHub's digest disagree, when a download does not match the published hash, or when a disk image does not hold the expected app (or the command line inside it). The `ERROR` lines of the "Process Tools" step say which tool and why, and that tool's formula and cask are left as they were. The usual fix is an asset name or `app_bundle` in `tools.json`.

## Running it locally

On a Mac, from the root of the tap:

```
bash scripts/update_homebrew.sh
```

It rewrites `Formula/` and `Casks/` in place. `GITHUB_TOKEN`, when set, is sent with the GitHub API requests.

The tests need no network. They build small taps and disk images in a temporary folder and compare what the updater writes with the expected formulae and casks, for every naming scheme above:

```
bash tests/test_update_homebrew.sh
```

They also run on every pull request (`test_updater.yml`).

## Examples

Standard formula and cask tool:

```json
{
  "name": "ileapp",
  "repo": "https://github.com/abrignoni/iLEAPP",
  "binary": "ileapp",
  "class_name": "Ileapp",
  "cask_name": "ileapp-gui",
  "app_name": "iLEAPP",
  "desc": "Digital forensics tool for parsing iOS backup files, images, and artifacts",
  "desc_gui": "Digital forensics tool for analyzing iOS artifacts"
}
```

Cask-only app with custom asset names:

```json
{
  "name": "lava",
  "repo": "https://github.com/leapps-org/LAVA-releases",
  "formula": false,
  "cask_name": "lava",
  "app_name": "LAVA",
  "app_bundle": "LAVA",
  "gui_intel_asset": "LAVA-{{version_no_v}}-macOS-Mac_Intel.dmg",
  "gui_arm_asset": "LAVA-{{version_no_v}}-macOS-Apple_Silicon.dmg",
  "desc_gui": "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
}
```

## Notes

- The workflow uses the configured `repo` value rather than assuming all tools live under one GitHub organization.
- The SHA256 written is the one the release publishes: its `SHA256SUMS.txt` when it has one, otherwise the GitHub asset digest. If a release publishes neither, the workflow downloads the asset and calculates SHA256 locally.
- The generated formula and cask output still comes from `templates/formula_template.rb` and `templates/cask_template.rb`.
