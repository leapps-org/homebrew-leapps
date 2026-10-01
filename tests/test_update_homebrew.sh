#!/usr/bin/env bash
# Tests for scripts/update_homebrew.sh.
#
#   bash tests/test_update_homebrew.sh
#
# Needs macOS (hdiutil) and jq, and no network: each test builds a small tap in
# a temporary folder, with releases read from files and small disk images made
# on the spot. The expected formulae and casks are written out in full here, so
# a change to what the updater writes for either naming scheme fails a test.

set -uo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
ASSETS="$T/assets"
mkdir -p "$ASSETS"
PASS=0
FAIL=0

ok() {
  PASS=$((PASS + 1))
  echo "  ok    $1"
}

not_ok() {
  FAIL=$((FAIL + 1))
  echo "  FAIL  $1"
}

# expect_status <description> <wanted> <got>
expect_status() {
  if [ "$2" = "$3" ]; then ok "$1"; else not_ok "$1 (exit status $3, wanted $2)"; fi
}

# expect_file <description> <file> <expected content>
expect_file() {
  if [ ! -f "$2" ]; then
    not_ok "$1 ($2 was not written)"
  elif [ "$(cat "$2")" = "$3" ]; then
    ok "$1"
  else
    not_ok "$1"
    diff <(echo "$3") "$2" | sed 's/^/        /'
  fi
}

# expect_output <description> <log file> <text>
expect_output() {
  if grep -Fq -- "$3" "$2"; then ok "$1"; else not_ok "$1 (the output has no \"$3\")"; fi
}

expect_no_output() {
  if grep -Fq -- "$3" "$2"; then not_ok "$1 (the output has \"$3\")"; else ok "$1"; fi
}

expect_absent() {
  if [ -e "$2" ]; then not_ok "$1 ($2 exists)"; else ok "$1"; fi
}

sha() {
  shasum -a 256 "$1" | awk '{print $1}'
}

# make_dmg <file name> <app name, without .app> <executable, or ""> <marker>
# The marker makes two disk images of one app differ, as the Intel and Apple
# silicon builds of a release do.
make_dmg() {
  local src="$T/src.$1"
  mkdir -p "$src/$2.app/Contents/MacOS"
  echo "$4" >"$src/$2.app/Contents/marker"
  if [ -n "$3" ]; then
    printf '#!/bin/sh\necho %s\n' "$3" >"$src/$2.app/Contents/MacOS/$3"
    chmod 755 "$src/$2.app/Contents/MacOS/$3"
  fi
  hdiutil create -quiet -fs HFS+ -format UDZO -volname "$2" -srcfolder "$src" "$ASSETS/$1" </dev/null ||
    { echo "could not make $1"; exit 1; }
}

# asset_json <file name> [digest]: one entry of a release's asset list.
asset_json() {
  jq -n --arg name "$1" --arg url "file://$ASSETS/$1" --arg digest "${2:-}" \
    '{name: $name, browser_download_url: $url} + (if $digest == "" then {} else {digest: ("sha256:" + $digest)} end)'
}

# new_tap <folder>: an empty tap holding the updater and its templates.
new_tap() {
  mkdir -p "$1/scripts" "$1/Formula" "$1/Casks" "$1/releases"
  cp "$ROOT/scripts/update_homebrew.sh" "$1/scripts/"
  cp -R "$ROOT/templates" "$1/"
}

# run_updater <tap folder> <log file>: prints the exit status.
run_updater() {
  local status=0
  (cd "$1" && env -u GITHUB_ACTIONS -u GITHUB_TOKEN LEAPPS_RELEASES_DIR="$1/releases" \
    bash scripts/update_homebrew.sh >"$2" 2>&1) || status=$?
  echo "$status"
}

if ! command -v hdiutil >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  echo "These tests need hdiutil (macOS) and jq."
  exit 1
fi

echo "Making the test disk images..."
# oldtool: the per-program names, with the v. Two programs, a zip and a disk image each.
echo "oldtool cli intel" >"$ASSETS/oldtool-v1.2.3-macOS_Mac_Intel.zip"
echo "oldtool cli arm" >"$ASSETS/oldtool-v1.2.3-macOS_Apple_Silicon.zip"
make_dmg "oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg" "oldtoolGUI" "oldtoolGUI" intel
make_dmg "oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg" "oldtoolGUI" "oldtoolGUI" arm
# plaintool: the per-program names, without the v the release's tag has.
make_dmg "plaintoolGUI-4.5.6-macOS_Mac_Intel.dmg" "plaintoolGUI" "plaintoolGUI" intel
make_dmg "plaintoolGUI-4.5.6-macOS_Apple_Silicon.dmg" "plaintoolGUI" "plaintoolGUI" arm
# newtool: one program per tool, <Tool>-<version>-macos-<arch>.dmg, and a SHA256SUMS.txt.
make_dmg "NewTool-2.0.0-macos-x64.dmg" "NewTool" "newtool" intel
make_dmg "NewTool-2.0.0-macos-arm64.dmg" "NewTool" "newtool" arm
# viewer: asset names set in tools.json.
make_dmg "Viewer-7.0.0-macOS-Mac_Intel.dmg" "Viewer" "Viewer" intel
make_dmg "Viewer-7.0.0-macOS-Apple_Silicon.dmg" "Viewer" "Viewer" arm
# Disk images that must be refused.
make_dmg "other-app.dmg" "Other" "newtool" other
make_dmg "no-program.dmg" "NewTool" "" none
make_dmg "wrong-case.dmg" "OldToolGUI" "oldtoolGUI" case

OLD_ZIP_INTEL=$(sha "$ASSETS/oldtool-v1.2.3-macOS_Mac_Intel.zip")
OLD_ZIP_ARM=$(sha "$ASSETS/oldtool-v1.2.3-macOS_Apple_Silicon.zip")
OLD_DMG_INTEL=$(sha "$ASSETS/oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg")
OLD_DMG_ARM=$(sha "$ASSETS/oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg")
PLAIN_DMG_INTEL=$(sha "$ASSETS/plaintoolGUI-4.5.6-macOS_Mac_Intel.dmg")
PLAIN_DMG_ARM=$(sha "$ASSETS/plaintoolGUI-4.5.6-macOS_Apple_Silicon.dmg")
NEW_DMG_INTEL=$(sha "$ASSETS/NewTool-2.0.0-macos-x64.dmg")
NEW_DMG_ARM=$(sha "$ASSETS/NewTool-2.0.0-macos-arm64.dmg")
VIEWER_DMG_INTEL=$(sha "$ASSETS/Viewer-7.0.0-macOS-Mac_Intel.dmg")
VIEWER_DMG_ARM=$(sha "$ASSETS/Viewer-7.0.0-macOS-Apple_Silicon.dmg")
if [ "$OLD_DMG_INTEL" = "$OLD_DMG_ARM" ] || [ "$NEW_DMG_INTEL" = "$NEW_DMG_ARM" ]; then
  echo "The Intel and Apple silicon test disk images came out identical."
  exit 1
fi

cat >"$ASSETS/SHA256SUMS.txt" <<EOF
$NEW_DMG_ARM  NewTool-2.0.0-macos-arm64.dmg
$NEW_DMG_INTEL  NewTool-2.0.0-macos-x64.dmg
EOF

OLDTOOL_JSON='{"name": "oldtool", "repo": "https://github.com/example/OldTool", "binary": "oldtool", "class_name": "Oldtool", "cask_name": "oldtool-gui", "app_name": "OldTool GUI", "desc": "Old tool on the command line", "desc_gui": "Old tool with a window"}'
PLAINTOOL_JSON='{"name": "plaintool", "repo": "https://github.com/example/PlainTool", "formula": false, "cask_name": "plaintool-gui", "app_name": "PlainTool GUI", "desc_gui": "Plain tool with a window"}'
NEWTOOL_JSON='{"name": "newtool", "repo": "https://github.com/example/NewTool", "binary": "newtool", "class_name": "Newtool", "cask_name": "newtool-gui", "app_name": "NewTool", "desc": "New tool on the command line", "desc_gui": "New tool"}'
VIEWER_JSON='{"name": "viewer", "repo": "https://github.com/example/Viewer", "formula": false, "cask_name": "viewer", "app_name": "Viewer", "app_bundle": "Viewer", "gui_intel_asset": "Viewer-{{version_no_v}}-macOS-Mac_Intel.dmg", "gui_arm_asset": "Viewer-{{version_no_v}}-macOS-Apple_Silicon.dmg", "desc_gui": "Viewer of reports"}'

# What the tap holds for newtool before its first release with the new names.
NEWTOOL_OLD_FORMULA='class Newtool < Formula
  desc "New tool on the command line"
  homepage "https://github.com/example/NewTool"

  if Hardware::CPU.intel?
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtool-v1.9.0-macOS_Mac_Intel.zip"
    sha256 "1111111111111111111111111111111111111111111111111111111111111111"
  else
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtool-v1.9.0-macOS_Apple_Silicon.zip"
    sha256 "2222222222222222222222222222222222222222222222222222222222222222"
  end

  def install
    bin.install "newtool"
    chmod 0755, bin/"newtool"
  end

  test do
    system "#{bin}/newtool", "--version"
  end
end'
NEWTOOL_OLD_CASK='cask "newtool-gui" do
  version "v1.9.0"

  if Hardware::CPU.intel?
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtoolGUI-v1.9.0-macOS_Mac_Intel.dmg"
    sha256 "3333333333333333333333333333333333333333333333333333333333333333"
  else
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtoolGUI-v1.9.0-macOS_Apple_Silicon.dmg"
    sha256 "4444444444444444444444444444444444444444444444444444444444444444"
  end

  name "NewTool GUI"
  desc "New tool with a window"
  homepage "https://github.com/example/NewTool"

  app "newtoolGUI.app"
end'

oldtool_release() {
  jq -n --argjson a "$(asset_json oldtool-v1.2.3-macOS_Mac_Intel.zip)" \
    --argjson b "$(asset_json oldtool-v1.2.3-macOS_Apple_Silicon.zip "$OLD_ZIP_ARM")" \
    --argjson c "$(asset_json oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg "$OLD_DMG_INTEL")" \
    --argjson d "$(asset_json oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg)" \
    '{tag_name: "v1.2.3", published_at: "2026-01-01T00:00:00Z", assets: [$a, $b, $c, $d]}'
}

# newtool_release <Intel disk image digest> <Apple silicon disk image digest>
newtool_release() {
  jq -n --argjson a "$(asset_json NewTool-2.0.0-macos-x64.dmg "$1")" \
    --argjson b "$(asset_json NewTool-2.0.0-macos-arm64.dmg "$2")" \
    --argjson c "$(asset_json NewTool-2.0.0-windows-x64-setup.exe)" \
    --argjson d "$(asset_json NewTool-2.0.0-linux-x64.AppImage)" \
    --argjson e "$(asset_json SHA256SUMS.txt)" \
    '{tag_name: "v2.0.0", published_at: "2026-02-03T04:05:06Z", assets: [$a, $b, $c, $d, $e]}'
}

# ---------------------------------------------------------------------------
echo "1. Every naming scheme in one run"
TAP="$T/tap1"
new_tap "$TAP"
echo "{\"tools\": [$OLDTOOL_JSON, $PLAINTOOL_JSON, $NEWTOOL_JSON, $VIEWER_JSON]}" >"$TAP/tools.json"
oldtool_release >"$TAP/releases/oldtool.json"
jq -n --argjson a "$(asset_json plaintoolGUI-4.5.6-macOS_Mac_Intel.dmg "$PLAIN_DMG_INTEL")" \
  --argjson b "$(asset_json plaintoolGUI-4.5.6-macOS_Apple_Silicon.dmg "$PLAIN_DMG_ARM")" \
  '{tag_name: "v4.5.6", assets: [$a, $b]}' >"$TAP/releases/plaintool.json"
newtool_release "$NEW_DMG_INTEL" "$NEW_DMG_ARM" >"$TAP/releases/newtool.json"
jq -n --argjson a "$(asset_json Viewer-7.0.0-macOS-Mac_Intel.dmg "$VIEWER_DMG_INTEL")" \
  --argjson b "$(asset_json Viewer-7.0.0-macOS-Apple_Silicon.dmg "$VIEWER_DMG_ARM")" \
  '{tag_name: "v7.0.0", assets: [$a, $b]}' >"$TAP/releases/viewer.json"
echo "$NEWTOOL_OLD_FORMULA" >"$TAP/Formula/newtool.rb"
echo "$NEWTOOL_OLD_CASK" >"$TAP/Casks/newtool-gui.rb"

STATUS=$(run_updater "$TAP" "$T/run1.log")
expect_status "the run succeeds" 0 "$STATUS"
expect_no_output "nothing is reported as an error" "$T/run1.log" "ERROR"

expect_file "old names: the formula" "$TAP/Formula/oldtool.rb" "class Oldtool < Formula
  desc \"Old tool on the command line\"
  homepage \"https://github.com/example/OldTool\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/oldtool-v1.2.3-macOS_Mac_Intel.zip\"
    sha256 \"$OLD_ZIP_INTEL\"
  else
    url \"file://$ASSETS/oldtool-v1.2.3-macOS_Apple_Silicon.zip\"
    sha256 \"$OLD_ZIP_ARM\"
  end

  def install
    bin.install \"oldtool\"
    chmod 0755, bin/\"oldtool\"
  end

  test do
    system \"#{bin}/oldtool\", \"--version\"
  end
end"

expect_file "old names: the cask, with no binary stanza" "$TAP/Casks/oldtool-gui.rb" "cask \"oldtool-gui\" do
  version \"v1.2.3\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg\"
    sha256 \"$OLD_DMG_INTEL\"
  else
    url \"file://$ASSETS/oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg\"
    sha256 \"$OLD_DMG_ARM\"
  end

  name \"OldTool GUI\"
  desc \"Old tool with a window\"
  homepage \"https://github.com/example/OldTool\"

  app \"oldtoolGUI.app\"
end"

expect_file "old names without the v: the cask" "$TAP/Casks/plaintool-gui.rb" "cask \"plaintool-gui\" do
  version \"v4.5.6\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/plaintoolGUI-4.5.6-macOS_Mac_Intel.dmg\"
    sha256 \"$PLAIN_DMG_INTEL\"
  else
    url \"file://$ASSETS/plaintoolGUI-4.5.6-macOS_Apple_Silicon.dmg\"
    sha256 \"$PLAIN_DMG_ARM\"
  end

  name \"PlainTool GUI\"
  desc \"Plain tool with a window\"
  homepage \"https://github.com/example/PlainTool\"

  app \"plaintoolGUI.app\"
end"
expect_absent "a tool with \"formula\": false gets no formula" "$TAP/Formula/plaintool.rb"

NEWTOOL_NEW_CASK="cask \"newtool-gui\" do
  version \"v2.0.0\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/NewTool-2.0.0-macos-x64.dmg\"
    sha256 \"$NEW_DMG_INTEL\"
  else
    url \"file://$ASSETS/NewTool-2.0.0-macos-arm64.dmg\"
    sha256 \"$NEW_DMG_ARM\"
  end

  name \"NewTool\"
  desc \"New tool\"
  homepage \"https://github.com/example/NewTool\"

  app \"NewTool.app\"
  binary \"#{appdir}/NewTool.app/Contents/MacOS/newtool\"
end"
expect_file "new names: the cask names the app in the disk image and links its command line" \
  "$TAP/Casks/newtool-gui.rb" "$NEWTOOL_NEW_CASK"

NEWTOOL_RETIRED_FORMULA='class Newtool < Formula
  desc "New tool on the command line"
  homepage "https://github.com/example/NewTool"

  if Hardware::CPU.intel?
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtool-v1.9.0-macOS_Mac_Intel.zip"
    sha256 "1111111111111111111111111111111111111111111111111111111111111111"
  else
    url "https://github.com/example/NewTool/releases/download/v1.9.0/newtool-v1.9.0-macOS_Apple_Silicon.zip"
    sha256 "2222222222222222222222222222222222222222222222222222222222222222"
  end

  deprecate! date: "2026-02-03", because: "now ships inside the newtool-gui cask", replacement_cask: "newtool-gui"

  def install
    bin.install "newtool"
    chmod 0755, bin/"newtool"
  end

  test do
    system "#{bin}/newtool", "--version"
  end
end'
expect_file "new names: the formula keeps its last version and is marked deprecated" \
  "$TAP/Formula/newtool.rb" "$NEWTOOL_RETIRED_FORMULA"

expect_file "names set in tools.json: the cask" "$TAP/Casks/viewer.rb" "cask \"viewer\" do
  version \"v7.0.0\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/Viewer-7.0.0-macOS-Mac_Intel.dmg\"
    sha256 \"$VIEWER_DMG_INTEL\"
  else
    url \"file://$ASSETS/Viewer-7.0.0-macOS-Apple_Silicon.dmg\"
    sha256 \"$VIEWER_DMG_ARM\"
  end

  name \"Viewer\"
  desc \"Viewer of reports\"
  homepage \"https://github.com/example/Viewer\"

  app \"Viewer.app\"
end"

echo "1b. New names for a tool with no command line to link"
TAP1B="$T/tap1b"
new_tap "$TAP1B"
echo '{"tools": [{"name": "newtool", "repo": "https://github.com/example/NewTool", "formula": false, "cask_name": "newtool", "app_name": "NewTool", "desc_gui": "New tool"}]}' >"$TAP1B/tools.json"
newtool_release "$NEW_DMG_INTEL" "$NEW_DMG_ARM" >"$TAP1B/releases/newtool.json"
STATUS=$(run_updater "$TAP1B" "$T/run1b.log")
expect_status "the run succeeds" 0 "$STATUS"
expect_file "the cask names the app and has no binary stanza" "$TAP1B/Casks/newtool.rb" "cask \"newtool\" do
  version \"v2.0.0\"

  if Hardware::CPU.intel?
    url \"file://$ASSETS/NewTool-2.0.0-macos-x64.dmg\"
    sha256 \"$NEW_DMG_INTEL\"
  else
    url \"file://$ASSETS/NewTool-2.0.0-macos-arm64.dmg\"
    sha256 \"$NEW_DMG_ARM\"
  end

  name \"NewTool\"
  desc \"New tool\"
  homepage \"https://github.com/example/NewTool\"

  app \"NewTool.app\"
end"
expect_absent "no formula is written" "$TAP1B/Formula/newtool.rb"

echo "2. A second run changes nothing"
BEFORE=$(cd "$TAP" && cat Formula/*.rb Casks/*.rb | shasum -a 256)
STATUS=$(run_updater "$TAP" "$T/run2.log")
AFTER=$(cd "$TAP" && cat Formula/*.rb Casks/*.rb | shasum -a 256)
expect_status "the run succeeds" 0 "$STATUS"
if [ "$BEFORE" = "$AFTER" ]; then ok "no formula or cask changed"; else not_ok "a formula or cask changed"; fi
expect_no_output "nothing is updated" "$T/run2.log" "Update required"
for TOOL_NAME in oldtool plaintool newtool viewer; do
  expect_output "$TOOL_NAME is reported up to date" "$T/run2.log" "$TOOL_NAME formula and cask are already up-to-date"
done

echo "3. A formula that missed its deprecation gets it on a later run"
echo "$NEWTOOL_OLD_FORMULA" >"$TAP/Formula/newtool.rb"
STATUS=$(run_updater "$TAP" "$T/run3.log")
expect_status "the run succeeds" 0 "$STATUS"
expect_file "the formula is marked deprecated" "$TAP/Formula/newtool.rb" "$NEWTOOL_RETIRED_FORMULA"

# ---------------------------------------------------------------------------
# Each refusal below starts from a tap whose newtool cask is the old one, and
# has to leave it untouched and end the run with exit status 3.
refusal_tap() {
  new_tap "$1"
  echo "{\"tools\": [$NEWTOOL_JSON]}" >"$1/tools.json"
  echo "$NEWTOOL_OLD_FORMULA" >"$1/Formula/newtool.rb"
  echo "$NEWTOOL_OLD_CASK" >"$1/Casks/newtool-gui.rb"
}

expect_untouched() {
  expect_file "the cask is left as it was" "$1/Casks/newtool-gui.rb" "$NEWTOOL_OLD_CASK"
  expect_file "the formula is left as it was" "$1/Formula/newtool.rb" "$NEWTOOL_OLD_FORMULA"
}

echo "4. A release with asset names the updater does not know"
TAP="$T/tap4"
refusal_tap "$TAP"
jq -n --argjson a "$(asset_json NewTool-2.0.0-darwin-universal.pkg)" \
  --argjson b "$(asset_json NewTool_2.0.0_macos_arm64.dmg)" \
  '{tag_name: "v2.0.0", assets: [$a, $b]}' >"$TAP/releases/newtool.json"
STATUS=$(run_updater "$TAP" "$T/run4.log")
expect_status "the run ends with status 3, not success" 3 "$STATUS"
expect_output "the cask is reported" "$T/run4.log" "ERROR: Could not find GUI macOS assets for newtool (v2.0.0)"
expect_output "the formula is reported" "$T/run4.log" "ERROR: Could not find CLI macOS assets for newtool (v2.0.0)"
expect_untouched "$TAP"

echo "4b. The same for a tool that has only a cask"
TAP="$T/tap4b"
new_tap "$TAP"
echo "{\"tools\": [$PLAINTOOL_JSON]}" >"$TAP/tools.json"
jq -n --argjson a "$(asset_json PlainTool-4.5.6-darwin-universal.pkg)" \
  '{tag_name: "v4.5.6", assets: [$a]}' >"$TAP/releases/plaintool.json"
STATUS=$(run_updater "$TAP" "$T/run4b.log")
expect_status "the run ends with status 3, not success" 3 "$STATUS"
expect_output "the cask is reported" "$T/run4b.log" "ERROR: Could not find GUI macOS assets for plaintool (v4.5.6)"
expect_no_output "no formula is reported for a tool without one" "$T/run4b.log" "CLI macOS assets"
expect_absent "no cask is written" "$TAP/Casks/plaintool-gui.rb"

echo "4c. A release with the old disk images and no command-line download"
TAP="$T/tap4c"
new_tap "$TAP"
echo "{\"tools\": [$OLDTOOL_JSON]}" >"$TAP/tools.json"
jq -n --argjson c "$(asset_json oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg "$OLD_DMG_INTEL")" \
  --argjson d "$(asset_json oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg "$OLD_DMG_ARM")" \
  '{tag_name: "v1.2.3", assets: [$c, $d]}' >"$TAP/releases/oldtool.json"
STATUS=$(run_updater "$TAP" "$T/run4c.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the formula is reported" "$T/run4c.log" "ERROR: Could not find CLI macOS assets for oldtool (v1.2.3)"
expect_absent "no formula is written" "$TAP/Formula/oldtool.rb"
if [ -f "$TAP/Casks/oldtool-gui.rb" ] && ! grep -q 'binary "' "$TAP/Casks/oldtool-gui.rb"; then
  ok "the cask is still written, with no binary stanza"
else
  not_ok "the cask is still written, with no binary stanza"
fi

echo "5. SHA256SUMS.txt and GitHub's digest disagree"
TAP="$T/tap5"
refusal_tap "$TAP"
newtool_release "$NEW_DMG_INTEL" "5555555555555555555555555555555555555555555555555555555555555555" >"$TAP/releases/newtool.json"
STATUS=$(run_updater "$TAP" "$T/run5.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the disagreement is reported" "$T/run5.log" "GitHub's digest is 5555555555555555555555555555555555555555555555555555555555555555"
expect_untouched "$TAP"

echo "6. The download does not match the published hash"
TAP="$T/tap6"
refusal_tap "$TAP"
jq -n --argjson a "$(asset_json NewTool-2.0.0-macos-x64.dmg "6666666666666666666666666666666666666666666666666666666666666666")" \
  --argjson b "$(asset_json NewTool-2.0.0-macos-arm64.dmg "$NEW_DMG_ARM")" \
  '{tag_name: "v2.0.0", assets: [$a, $b]}' >"$TAP/releases/newtool.json"
STATUS=$(run_updater "$TAP" "$T/run6.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the mismatch is reported" "$T/run6.log" "the release publishes 6666666666666666666666666666666666666666666666666666666666666666"
expect_untouched "$TAP"

echo "6b. The same when the hash comes from SHA256SUMS.txt alone"
TAP="$T/tap6b"
refusal_tap "$TAP"
mkdir -p "$TAP/assets"
cat >"$TAP/assets/SHA256SUMS.txt" <<EOF
$NEW_DMG_ARM  NewTool-2.0.0-macos-arm64.dmg
7777777777777777777777777777777777777777777777777777777777777777  NewTool-2.0.0-macos-x64.dmg
EOF
jq -n --argjson a "$(asset_json NewTool-2.0.0-macos-x64.dmg)" \
  --argjson b "$(asset_json NewTool-2.0.0-macos-arm64.dmg)" \
  --arg sums "file://$TAP/assets/SHA256SUMS.txt" \
  '{tag_name: "v2.0.0", assets: [$a, $b, {name: "SHA256SUMS.txt", browser_download_url: $sums}]}' >"$TAP/releases/newtool.json"
STATUS=$(run_updater "$TAP" "$T/run6b.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the mismatch is reported" "$T/run6b.log" "the release publishes 7777777777777777777777777777777777777777777777777777777777777777"
expect_untouched "$TAP"

# The three below serve a different disk image under the release's asset name.
swap_asset_tap() {
  refusal_tap "$1"
  mkdir -p "$1/assets"
  cp "$ASSETS/$2" "$1/assets/NewTool-2.0.0-macos-x64.dmg"
  cp "$ASSETS/NewTool-2.0.0-macos-arm64.dmg" "$1/assets/"
  jq -n --arg dir "file://$1/assets" \
    '{tag_name: "v2.0.0", assets: [
       {name: "NewTool-2.0.0-macos-x64.dmg", browser_download_url: ($dir + "/NewTool-2.0.0-macos-x64.dmg")},
       {name: "NewTool-2.0.0-macos-arm64.dmg", browser_download_url: ($dir + "/NewTool-2.0.0-macos-arm64.dmg")}]}' \
    >"$1/releases/newtool.json"
}

echo "7. The disk image holds an app with another name"
TAP="$T/tap7"
swap_asset_tap "$TAP" other-app.dmg
STATUS=$(run_updater "$TAP" "$T/run7.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the app found is named" "$T/run7.log" "it holds Other.app, not NewTool.app"
expect_untouched "$TAP"

echo "8. The app holds no command line to link"
TAP="$T/tap8"
swap_asset_tap "$TAP" no-program.dmg
STATUS=$(run_updater "$TAP" "$T/run8.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the missing program is named" "$T/run8.log" "NewTool.app has no executable Contents/MacOS/newtool"
expect_untouched "$TAP"

echo "9. The app's name differs from the cask's only in capitals"
TAP="$T/tap9"
new_tap "$TAP"
echo "{\"tools\": [$OLDTOOL_JSON]}" >"$TAP/tools.json"
mkdir -p "$TAP/assets"
cp "$ASSETS/wrong-case.dmg" "$TAP/assets/oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg"
cp "$ASSETS/oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg" "$ASSETS/oldtool-v1.2.3-macOS_Mac_Intel.zip" \
  "$ASSETS/oldtool-v1.2.3-macOS_Apple_Silicon.zip" "$TAP/assets/"
jq -n --arg dir "file://$TAP/assets" \
  '{tag_name: "v1.2.3", assets: [
     {name: "oldtool-v1.2.3-macOS_Mac_Intel.zip", browser_download_url: ($dir + "/oldtool-v1.2.3-macOS_Mac_Intel.zip")},
     {name: "oldtool-v1.2.3-macOS_Apple_Silicon.zip", browser_download_url: ($dir + "/oldtool-v1.2.3-macOS_Apple_Silicon.zip")},
     {name: "oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg", browser_download_url: ($dir + "/oldtoolGUI-v1.2.3-macOS_Mac_Intel.dmg")},
     {name: "oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg", browser_download_url: ($dir + "/oldtoolGUI-v1.2.3-macOS_Apple_Silicon.dmg")}]}' \
  >"$TAP/releases/oldtool.json"
STATUS=$(run_updater "$TAP" "$T/run9.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the app found is named" "$T/run9.log" "it holds OldToolGUI.app, not oldtoolGUI.app"
expect_absent "no cask is written" "$TAP/Casks/oldtool-gui.rb"

echo "10. One tool that cannot be updated does not stop the others"
TAP="$T/tap10"
refusal_tap "$TAP"
echo "{\"tools\": [$NEWTOOL_JSON, $OLDTOOL_JSON]}" >"$TAP/tools.json"
jq -n --argjson a "$(asset_json NewTool-2.0.0-darwin-universal.pkg)" \
  '{tag_name: "v2.0.0", assets: [$a]}' >"$TAP/releases/newtool.json"
oldtool_release >"$TAP/releases/oldtool.json"
STATUS=$(run_updater "$TAP" "$T/run10.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_untouched "$TAP"
expect_output "the other tool is updated" "$T/run10.log" "Finished processing oldtool."
if [ -f "$TAP/Casks/oldtool-gui.rb" ] && [ -f "$TAP/Formula/oldtool.rb" ]; then
  ok "the other tool's formula and cask are written"
else
  not_ok "the other tool's formula and cask are written"
fi

echo "11. A release that cannot be read"
TAP="$T/tap11"
refusal_tap "$TAP"
STATUS=$(run_updater "$TAP" "$T/run11.log")
expect_status "the run ends with status 3" 3 "$STATUS"
expect_output "the tool is reported" "$T/run11.log" "ERROR: Could not fetch the latest release of newtool."
expect_untouched "$TAP"

LEFT=$(mount | grep -c "$T" || true)
if [ "$LEFT" = "0" ]; then ok "no disk image is left mounted"; else not_ok "$LEFT disk image(s) left mounted"; fi

echo
echo "$PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ] || [ "$PASS" -eq 0 ]; then
  exit 1
fi
