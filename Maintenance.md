# Maintaining the Automated Homebrew Formula & Cask Update Process

This document provides guidelines for maintaining and extending the GitHub Actions workflow that automatically updates Homebrew formulae and casks for multiple tools, using a JSON configuration file.

## Overview

The workflow performs the following tasks:

1. **Reads a JSON configuration file (`tools.json`)** containing tool definitions, repository URLs, asset naming overrides, and whether the tool has a formula, cask, or both.
2. **Fetches the latest release** for each configured repository using the GitHub API.
3. **Finds the expected macOS release assets** from the release asset list.
4. **Compares the current installed URLs** in formulae/casks to the latest release URLs.
5. **If out-of-date**, uses the release asset digest when available, or downloads the asset to calculate SHA256, then generates updated formulae and casks from template files.
6. **Commits and pushes changes** to the repository, maintaining up-to-date formulae and casks.

## Repository Structure

```text
.
|-- .github/
|   `-- workflows/
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
|-- templates/
|   |-- formula_template.rb
|   `-- cask_template.rb
`-- tools.json
```

## `tools.json` Format

`tools.json` should contain a top-level `tools` array. Each tool object can include:

- `name`: Tool name (for example, `ileapp`).
- `repo`: GitHub repository URL (for example, `https://github.com/abrignoni/iLEAPP`).
- `formula`: Optional boolean. Defaults to `true`; set to `false` for cask-only tools such as LAVA.
- `cask`: Optional boolean. Defaults to `true`; set to `false` for formula-only tools.
- `binary`: Name of the installed CLI binary. Required when `formula` is enabled.
- `class_name`: Ruby class name for the formula. Required when `formula` is enabled.
- `cask_name`: Name of the cask. Required when `cask` is enabled.
- `app_name`: Name of the GUI app. Required when `cask` is enabled.
- `app_bundle`: Optional app bundle name without `.app`; defaults to `${name}GUI`.
- `desc`: Description for the formula.
- `desc_gui`: Description for the cask.
- `intel_asset`, `arm_asset`, `gui_intel_asset`, `gui_arm_asset`: Optional release asset filename templates. Supported placeholders are `{{name}}`, `{{version}}`, and `{{version_no_v}}`.

## Examples

Standard formula and cask tool:

```json
{
  "name": "ileapp",
  "repo": "https://github.com/abrignoni/iLEAPP",
  "binary": "ileapp",
  "class_name": "Ileapp",
  "cask_name": "ileapp-gui",
  "app_name": "iLEAPP GUI",
  "desc": "Digital forensics tool for parsing iOS backup files, images, and artifacts",
  "desc_gui": "Digital forensics tool for analyzing iOS artifacts with graphical interface"
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
- GitHub release asset digests are preferred when available. If a digest is missing, the workflow downloads the asset and calculates SHA256 locally.
- The generated formula and cask output still comes from `templates/formula_template.rb` and `templates/cask_template.rb`.
