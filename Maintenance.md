# Maintaining the Homebrew tap

This tap distributes macOS casks. The six forensic tools use combined GUI/CLI app
bundles; LAVA is an app-only cask. Separate CLI formulas are retired.

## Release updates

`.github/workflows/update_homebrew.yml` runs daily and can be dispatched manually.
It runs `bash scripts/update_homebrew.sh` on macOS and commits changed casks.
The test workflow runs both the macOS disk-image tests and `node --test`.

The updater reads `tools.json`, fetches each repository's latest release, selects
both configured macOS assets, and renders `templates/cask_template.rb`. For an
updated cask it downloads both images with retries, checks their SHA256 against
GitHub's digest and `SHA256SUMS.txt` when published, and mounts them read-only to
verify the app and CLI executable names. Unchanged release URLs are skipped.

Missing assets, HTTP errors, checksum discrepancies, and wrong bundle contents
are reported as errors. Other tools can still update; successful changes are
committed before the workflow reports failure for any tool that could not update.

## Configuration

Each entry in the top-level `tools` array has:

- `name`: tool identifier.
- `formula`: set to `false` for every tool in this cask-only tap. The upstream
  updater retains legacy formula support and its template for regression tests.
- `repo`: upstream GitHub repository URL.
- `cask_name`: cask token, matching its filename under `Casks/`.
- `app_name`: display name.
- `app_bundle`: installed app bundle name, without `.app`.
- `desc_gui`: cask description, covering both interfaces for combined apps.
- `gui_intel_asset`, `gui_arm_asset`: release asset filename templates.
- `binary`: optional CLI command name; also the default executable basename under
  `Contents/MacOS/`. Omit for LAVA.
- `binary_executable`: optional executable basename when it differs from the CLI
  command. GLEAPP uses `GLEAPP` inside the bundle and links it as `gleapp`.

Asset templates support `{{name}}`, `{{version}}` (the release tag), and
`{{version_no_v}}` (tag with its leading `v` removed).

For example, iLEAPP uses `iLEAPP-{{version_no_v}}-macos-x64.dmg` and
`iLEAPP-{{version_no_v}}-macos-arm64.dmg`. LAVA retains its own asset naming.

The cask's `binary` artifact links `#{appdir}/iLEAPP.app/Contents/MacOS/ileapp`
into Homebrew's `bin` directory. Keep the executable inside its app bundle;
copying it out would separate it from required dependencies. Using `appdir`
also respects custom application installation directories.

## Migration records

`tap_migrations.json` maps each retired CLI formula to the same-named cask in
`leapps-org/leapps`. `cask_renames.json` maps each former `*-gui` cask to its
plain name. Preserve these records for users upgrading from older tap revisions.
Homebrew may require manual steps depending on its version, trust settings, and
whether both the old formula and GUI cask were installed. See [Install.md](Install.md).

## Validation

Run `node --test` for metadata rendering and migration checks. On macOS run
`bash tests/test_update_homebrew.sh` for disk-image validation tests, and
`bash scripts/update_homebrew.sh` to refresh casks from live releases.
The optional `node scripts/update-casks.mjs` utility regenerates metadata on
other platforms using release digests; it does not mount or verify disk images.
On macOS, also run Homebrew cask audits and test installation, migration from an
old formula and an old GUI cask, CLI `--help`, and uninstall. These integration
checks require macOS and cannot run on Windows.
