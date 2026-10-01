#!/usr/bin/env bash
# Updates Formula/ and Casks/ from each tool's latest GitHub release.
#
# Run it from the root of the tap, on macOS: it mounts each disk image to check
# what is inside before it writes a cask.
#
#   bash scripts/update_homebrew.sh
#
# Exit codes:
#   0  every tool is up to date or was updated
#   3  every tool was processed and at least one could not be updated
#   anything else: the script itself failed
#
# Environment:
#   GITHUB_TOKEN         optional, sent with the GitHub API requests
#   LEAPPS_RELEASES_DIR  optional, a folder of <name>.json files read in place
#                        of the GitHub API (the tests use it)

set -eo pipefail

TOOLS_JSON="tools.json"
SUMS_ASSET="SHA256SUMS.txt"
PROBLEMS=0
WORK_DIR=$(mktemp -d)
MOUNT_POINT=""
VERIFY_ERROR=""

cleanup() {
  if [ -n "$MOUNT_POINT" ] && [ -d "$MOUNT_POINT" ]; then
    hdiutil detach "$MOUNT_POINT" -force >/dev/null 2>&1 || true
  fi
  rm -rf "$WORK_DIR"
}
trap cleanup EXIT

# A tool that could not be updated. The run goes on to the next tool and exits 3
# at the end, so a release this script cannot read does not pass as "no changes".
problem() {
  PROBLEMS=$((PROBLEMS + 1))
  echo "ERROR: $*"
  if [ -n "${GITHUB_ACTIONS:-}" ]; then
    echo "::error::$*"
  fi
}

# tool_field <key> [default]: a field of the current tool. jq's `//` cannot be
# used for this: it treats false as missing, so `"formula": false` read as true.
tool_field() {
  echo "$TOOL" | jq -r --arg key "$1" --arg default "${2:-}" \
    'if has($key) and .[$key] != null then (.[$key] | tostring) else $default end'
}

fetch_release() {
  local owner_repo="$1"
  if [ -n "${LEAPPS_RELEASES_DIR:-}" ]; then
    cat "$LEAPPS_RELEASES_DIR/$NAME.json"
  elif [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" \
      "https://api.github.com/repos/${owner_repo}/releases/latest"
  else
    curl -fsSL "https://api.github.com/repos/${owner_repo}/releases/latest"
  fi
}

render_asset_name() {
  local template="$1"
  echo "$template" | sed \
    -e "s/{{name}}/$NAME/g" \
    -e "s/{{version}}/$LATEST_TAG/g" \
    -e "s/{{version_no_v}}/$LATEST_TAG_NO_V/g"
}

asset_exists() {
  local asset_name="$1"
  echo "$RELEASE_JSON" | jq -e --arg asset_name "$asset_name" \
    '[.assets[] | select(.name == $asset_name)] | length > 0' >/dev/null
}

asset_url() {
  local asset_name="$1"
  echo "$RELEASE_JSON" | jq -r --arg asset_name "$asset_name" \
    '[.assets[] | select(.name == $asset_name) | .browser_download_url][0] // ""'
}

# select_asset_name <tools.json field> <default with v> <default without v>
# Prints the asset to use, or nothing when the release has none of them.
select_asset_name() {
  local field="$1"
  local default_with_v="$2"
  local default_without_v="$3"
  local configured candidate

  configured=$(tool_field "$field")
  if [ -n "$configured" ]; then
    candidate=$(render_asset_name "$configured")
    if asset_exists "$candidate"; then
      echo "$candidate"
    fi
    return 0
  fi

  for candidate in "$(render_asset_name "$default_with_v")" "$(render_asset_name "$default_without_v")"; do
    if asset_exists "$candidate"; then
      echo "$candidate"
      return 0
    fi
  done
}

# unified_asset_name <arch>: the disk image a release built by the tools' one
# packaging driver carries, <Tool>-<version>-macos-<arch>.dmg, with no "v" in
# the version. <Tool> is spelled the project's way (iLEAPP, ALEAPP), so the
# match ignores case and the release's own spelling is printed.
unified_asset_name() {
  local wanted
  wanted=$(echo "${NAME}-${LATEST_TAG_NO_V}-macos-$1.dmg" | tr '[:upper:]' '[:lower:]')
  echo "$RELEASE_JSON" | jq -r --arg wanted "$wanted" \
    '[.assets[] | select((.name | ascii_downcase) == $wanted) | .name][0] // ""'
}

download() {
  local url="$1"
  local path="$2"
  curl -fsSL --retry 3 --retry-all-errors -o "$path" "$url"
}

file_sha() {
  shasum -a 256 "$1" | awk '{print $1}'
}

# published_sha <asset name>: the sha256 the release itself publishes for an
# asset, from its SHA256SUMS.txt and from the digest GitHub records for the
# upload. Prints nothing when the release publishes neither, and fails when the
# two disagree.
published_sha() {
  local asset_name="$1"
  local digest sums_sha=""

  digest=$(echo "$RELEASE_JSON" | jq -r --arg asset_name "$asset_name" \
    '[.assets[] | select(.name == $asset_name) | .digest // ""][0] // ""')
  if [[ "$digest" == sha256:* ]]; then
    digest="${digest#sha256:}"
  else
    digest=""
  fi

  if [ -n "$SUMS_FILE" ]; then
    sums_sha=$(awk -v name="$asset_name" \
      '{ file = $2; sub(/^\*/, "", file) } file == name { print $1; exit }' "$SUMS_FILE")
  fi

  if [ -n "$digest" ] && [ -n "$sums_sha" ] && [ "$digest" != "$sums_sha" ]; then
    echo "$SUMS_ASSET gives $sums_sha for $asset_name and GitHub's digest is $digest" >&2
    return 1
  fi

  if [ -n "$sums_sha" ]; then
    echo "$sums_sha"
  else
    echo "$digest"
  fi
}

# verify_dmg <disk image> <app bundle, without .app> [executable]
# Mounts the disk image read-only and checks it holds the app the cask will
# name, and inside it the command line the cask will link. Names are compared
# exactly: the volume itself would accept any capitalisation.
verify_dmg() {
  local dmg="$1"
  local app="$2.app"
  local exe="${3:-}"
  local found programs status=0

  VERIFY_ERROR=""
  if ! command -v hdiutil >/dev/null 2>&1; then
    VERIFY_ERROR="hdiutil is not available to check it (run this on macOS)"
    return 1
  fi

  MOUNT_POINT=$(mktemp -d "$WORK_DIR/mount.XXXXXX")
  if ! hdiutil attach -readonly -nobrowse -noautoopen -mountpoint "$MOUNT_POINT" "$dmg" \
       </dev/null >/dev/null 2>"$WORK_DIR/hdiutil.err"; then
    VERIFY_ERROR="it could not be mounted: $(tr '\n' ' ' <"$WORK_DIR/hdiutil.err")"
    rmdir "$MOUNT_POINT" 2>/dev/null || true
    MOUNT_POINT=""
    return 1
  fi

  found=$(ls "$MOUNT_POINT" | grep '\.app$' || true)
  if ! grep -Fxq "$app" <<<"$found"; then
    VERIFY_ERROR="it holds $(echo "${found:-no app}" | tr '\n' ' ' | sed 's/ $//'), not $app"
    status=1
  elif [ -n "$exe" ]; then
    programs=$(ls "$MOUNT_POINT/$app/Contents/MacOS" 2>/dev/null || true)
    if ! grep -Fxq "$exe" <<<"$programs" || [ ! -x "$MOUNT_POINT/$app/Contents/MacOS/$exe" ]; then
      VERIFY_ERROR="$app has no executable Contents/MacOS/$exe"
      status=1
    fi
  fi

  hdiutil detach "$MOUNT_POINT" >/dev/null 2>&1 ||
    hdiutil detach "$MOUNT_POINT" -force >/dev/null 2>&1 || true
  rmdir "$MOUNT_POINT" 2>/dev/null || true
  MOUNT_POINT=""
  return $status
}

# first_url <file>: the first url stanza of a formula or cask.
first_url() {
  sed -n '/^ *url "/{
s/^ *url "\([^"]*\)".*/\1/p
q
}' "$1"
}

# A release from the one packaging driver has no command-line download: the
# command line is inside the app, and the cask links it. The formula stays at
# the last version that had one and is marked deprecated, so `brew install`
# says where the program went instead of quietly installing an old release.
retire_formula() {
  local since line

  [ -f "$FORMULA_PATH" ] || return 0
  if ! grep -q '^  binary "' "$CASK_PATH" 2>/dev/null; then
    return 0
  fi
  if grep -q '^ *deprecate! ' "$FORMULA_PATH"; then
    echo "Formula $FORMULA_PATH is already marked deprecated."
    return 0
  fi

  since=$(echo "$RELEASE_JSON" | jq -r '.published_at // ""' | cut -c1-10)
  if [ -z "$since" ]; then
    since=$(date -u +%Y-%m-%d)
  fi
  line="  deprecate! date: \"$since\", because: \"now ships inside the $CASK_NAME cask\", replacement_cask: \"$CASK_NAME\""

  awk -v line="$line" \
    '/^  def install$/ && !done { print line; print ""; done = 1 } { print }' \
    "$FORMULA_PATH" >"$WORK_DIR/formula.rb"
  if ! grep -q '^ *deprecate! ' "$WORK_DIR/formula.rb"; then
    problem "Could not mark $FORMULA_PATH deprecated: it has no 'def install' line to put the stanza before."
    return 0
  fi
  cp "$WORK_DIR/formula.rb" "$FORMULA_PATH"
  echo "Marked $FORMULA_PATH deprecated in favour of the $CASK_NAME cask."
}

process_tool() {
  local NAME REPO BINARY CLASS_NAME CASK_NAME APP_NAME APP_BUNDLE DESC DESC_GUI DO_FORMULA DO_CASK
  local OWNER_REPO RELEASE_JSON LATEST_TAG LATEST_TAG_NO_V SUMS_FILE SUMS_URL
  local INTEL_ASSET="" ARM_ASSET="" GUI_INTEL_ASSET="" GUI_ARM_ASSET=""
  local LATEST_INTEL_URL="" LATEST_ARM_URL="" LATEST_GUI_INTEL_URL="" LATEST_GUI_ARM_URL=""
  local UNIFIED_ARM_ASSET UNIFIED_INTEL_ASSET UNIFIED=false LINK_BINARY=""
  local FORMULA_PATH CASK_PATH CURRENT_INTEL_URL="" CURRENT_GUI_URL=""
  local FORMULA_UP_TO_DATE=false CASK_UP_TO_DATE=false
  local INTEL_SHA="" ARM_SHA="" GUI_INTEL_SHA="" GUI_ARM_SHA=""
  local arch asset url path published local_sha binary_expression

  echo "--- Processing Tool ---"
  NAME=$(tool_field name)
  REPO=$(tool_field repo)
  BINARY=$(tool_field binary)
  CLASS_NAME=$(tool_field class_name)
  CASK_NAME=$(tool_field cask_name)
  APP_NAME=$(tool_field app_name)
  APP_BUNDLE=$(tool_field app_bundle)
  DESC=$(tool_field desc)
  DESC_GUI=$(tool_field desc_gui)
  DO_FORMULA=$(tool_field formula true)
  DO_CASK=$(tool_field cask true)
  FORMULA_PATH="Formula/$NAME.rb"
  CASK_PATH="Casks/$CASK_NAME.rb"

  echo "Name: $NAME"
  echo "Repo: $REPO"
  echo "Binary: $BINARY"
  echo "Class Name: $CLASS_NAME"
  echo "Cask Name: $CASK_NAME"
  echo "App Name: $APP_NAME"
  echo "Formula enabled: $DO_FORMULA"
  echo "Cask enabled: $DO_CASK"

  # Fetch the latest release
  OWNER_REPO=$(echo "$REPO" | sed -E 's#^https://github.com/##; s#/$##')
  echo "Fetching latest tag for $REPO..."
  if ! RELEASE_JSON=$(fetch_release "$OWNER_REPO"); then
    problem "Could not fetch the latest release of $NAME."
    return 0
  fi
  LATEST_TAG=$(echo "$RELEASE_JSON" | jq -r '.tag_name')
  if [ -z "$LATEST_TAG" ] || [ "$LATEST_TAG" = "null" ]; then
    problem "Could not read the latest tag of $NAME."
    return 0
  fi
  echo "Latest tag found: $LATEST_TAG"
  LATEST_TAG_NO_V=${LATEST_TAG#v}

  # Which layout is this release?
  UNIFIED_ARM_ASSET=$(unified_asset_name arm64)
  UNIFIED_INTEL_ASSET=$(unified_asset_name x64)
  if [ -n "$UNIFIED_ARM_ASSET" ] && [ -n "$UNIFIED_INTEL_ASSET" ]; then
    UNIFIED=true
    echo "Release layout: one program per tool ($UNIFIED_ARM_ASSET)"
  fi

  if [ "$DO_FORMULA" = "true" ]; then
    INTEL_ASSET=$(select_asset_name "intel_asset" "{{name}}-{{version}}-macOS_Mac_Intel.zip" "{{name}}-{{version_no_v}}-macOS_Mac_Intel.zip")
    ARM_ASSET=$(select_asset_name "arm_asset" "{{name}}-{{version}}-macOS_Apple_Silicon.zip" "{{name}}-{{version_no_v}}-macOS_Apple_Silicon.zip")
    if [ -n "$INTEL_ASSET" ] && [ -n "$ARM_ASSET" ]; then
      LATEST_INTEL_URL=$(asset_url "$INTEL_ASSET")
      LATEST_ARM_URL=$(asset_url "$ARM_ASSET")
    elif [ "$UNIFIED" = "true" ]; then
      echo "$NAME $LATEST_TAG has no command-line download: the command line is inside the app. Leaving the formula at its last version."
      DO_FORMULA=false
    else
      problem "Could not find CLI macOS assets for $NAME ($LATEST_TAG). Skipping formula."
      DO_FORMULA=false
    fi
  fi

  if [ "$DO_CASK" = "true" ]; then
    GUI_INTEL_ASSET=$(select_asset_name "gui_intel_asset" "{{name}}GUI-{{version}}-macOS_Mac_Intel.dmg" "{{name}}GUI-{{version_no_v}}-macOS_Mac_Intel.dmg")
    GUI_ARM_ASSET=$(select_asset_name "gui_arm_asset" "{{name}}GUI-{{version}}-macOS_Apple_Silicon.dmg" "{{name}}GUI-{{version_no_v}}-macOS_Apple_Silicon.dmg")
    if [ -n "$GUI_INTEL_ASSET" ] && [ -n "$GUI_ARM_ASSET" ]; then
      if [ -z "$APP_BUNDLE" ]; then
        APP_BUNDLE="${NAME}GUI"
      fi
    elif [ "$UNIFIED" = "true" ]; then
      GUI_INTEL_ASSET="$UNIFIED_INTEL_ASSET"
      GUI_ARM_ASSET="$UNIFIED_ARM_ASSET"
      if [ -z "$APP_BUNDLE" ]; then
        # RLEAPP-2026.4.2-macos-arm64.dmg holds RLEAPP.app: the tool's name, as
        # the release spells it. verify_dmg checks the disk image agrees.
        APP_BUNDLE="${UNIFIED_ARM_ASSET:0:${#NAME}}"
      fi
      LINK_BINARY="$BINARY"
    else
      problem "Could not find GUI macOS assets for $NAME ($LATEST_TAG). Skipping cask."
      DO_CASK=false
    fi
    if [ "$DO_CASK" = "true" ]; then
      LATEST_GUI_INTEL_URL=$(asset_url "$GUI_INTEL_ASSET")
      LATEST_GUI_ARM_URL=$(asset_url "$GUI_ARM_ASSET")
    fi
  fi

  if [ "$DO_FORMULA" != "true" ] && [ "$DO_CASK" != "true" ]; then
    echo "No installable artifacts found for $NAME. Skipping."
    return 0
  fi

  echo "Selected latest URLs:"
  [ -n "$LATEST_INTEL_URL" ] && echo "  Intel CLI: $LATEST_INTEL_URL"
  [ -n "$LATEST_ARM_URL" ] && echo "  ARM CLI: $LATEST_ARM_URL"
  [ -n "$LATEST_GUI_INTEL_URL" ] && echo "  Intel GUI: $LATEST_GUI_INTEL_URL"
  [ -n "$LATEST_GUI_ARM_URL" ] && echo "  ARM GUI: $LATEST_GUI_ARM_URL"

  # Get current URLs (if formula/cask doesn't exist yet, set empty)
  if [ "$DO_FORMULA" = "true" ]; then
    echo "Checking current formula at $FORMULA_PATH..."
    if [ -f "$FORMULA_PATH" ]; then
      CURRENT_INTEL_URL=$(first_url "$FORMULA_PATH")
      echo "Found current Intel URL: $CURRENT_INTEL_URL"
    else
      echo "Formula file not found. Assuming new tool."
    fi
  fi

  if [ "$DO_CASK" = "true" ]; then
    echo "Checking current cask at $CASK_PATH..."
    if [ -f "$CASK_PATH" ]; then
      CURRENT_GUI_URL=$(first_url "$CASK_PATH")
      echo "Found current GUI URL: $CURRENT_GUI_URL"
    else
      echo "Cask file not found. Assuming new tool."
    fi
  fi

  # Compare URLs; skip if both formula and cask are present and up-to-date
  if [ "$DO_FORMULA" != "true" ] || { [ -f "$FORMULA_PATH" ] && [ "$CURRENT_INTEL_URL" = "$LATEST_INTEL_URL" ]; }; then
    FORMULA_UP_TO_DATE=true
  fi
  if [ "$DO_CASK" != "true" ] || { [ -f "$CASK_PATH" ] && [ "$CURRENT_GUI_URL" = "$LATEST_GUI_INTEL_URL" ]; }; then
    CASK_UP_TO_DATE=true
  fi

  if [ "$FORMULA_UP_TO_DATE" = "true" ] && [ "$CASK_UP_TO_DATE" = "true" ]; then
    echo "$NAME formula and cask are already up-to-date ($LATEST_TAG). Skipping."
    if [ "$UNIFIED" = "true" ] && [ "$(tool_field formula true)" = "true" ]; then
      retire_formula
    fi
    return 0
  fi

  echo "Update required for $NAME. Proceeding..."

  # The release's own list of checksums, when it publishes one
  SUMS_FILE=""
  SUMS_URL=$(asset_url "$SUMS_ASSET")
  if [ -n "$SUMS_URL" ]; then
    SUMS_FILE="$WORK_DIR/$NAME.$SUMS_ASSET"
    if ! download "$SUMS_URL" "$SUMS_FILE"; then
      problem "Could not download $SUMS_ASSET for $NAME ($LATEST_TAG)."
      return 0
    fi
  fi

  echo "Calculating checksums..."
  if [ "$DO_FORMULA" = "true" ] && [ "$FORMULA_UP_TO_DATE" != "true" ]; then
    for arch in intel arm; do
      if [ "$arch" = "intel" ]; then asset="$INTEL_ASSET"; url="$LATEST_INTEL_URL"; else asset="$ARM_ASSET"; url="$LATEST_ARM_URL"; fi
      if ! published=$(published_sha "$asset" 2>"$WORK_DIR/sha.err"); then
        problem "$NAME ($LATEST_TAG): $(cat "$WORK_DIR/sha.err")"
        return 0
      fi
      if [ -z "$published" ]; then
        path="$WORK_DIR/$arch.zip"
        if ! download "$url" "$path"; then
          problem "Could not download $asset."
          return 0
        fi
        published=$(file_sha "$path")
      fi
      if [ "$arch" = "intel" ]; then INTEL_SHA="$published"; else ARM_SHA="$published"; fi
    done
  fi

  if [ "$DO_CASK" = "true" ] && [ "$CASK_UP_TO_DATE" != "true" ]; then
    for arch in intel arm; do
      if [ "$arch" = "intel" ]; then asset="$GUI_INTEL_ASSET"; url="$LATEST_GUI_INTEL_URL"; else asset="$GUI_ARM_ASSET"; url="$LATEST_GUI_ARM_URL"; fi
      if ! published=$(published_sha "$asset" 2>"$WORK_DIR/sha.err"); then
        problem "$NAME ($LATEST_TAG): $(cat "$WORK_DIR/sha.err")"
        return 0
      fi
      path="$WORK_DIR/gui_$arch.dmg"
      if ! download "$url" "$path"; then
        problem "Could not download $asset."
        return 0
      fi
      local_sha=$(file_sha "$path")
      if [ -n "$published" ] && [ "$published" != "$local_sha" ]; then
        problem "$asset downloads with sha256 $local_sha and the release publishes $published. Skipping cask."
        return 0
      fi
      if ! verify_dmg "$path" "$APP_BUNDLE" "$LINK_BINARY"; then
        problem "$asset cannot be used for the $CASK_NAME cask: $VERIFY_ERROR. Skipping cask."
        return 0
      fi
      echo "  $asset holds $APP_BUNDLE.app${LINK_BINARY:+ with Contents/MacOS/$LINK_BINARY}"
      if [ "$arch" = "intel" ]; then GUI_INTEL_SHA="$local_sha"; else GUI_ARM_SHA="$local_sha"; fi
    done
  fi

  echo "SHA256 Hashes:"
  [ -n "$INTEL_SHA" ] && echo "  Intel CLI: $INTEL_SHA"
  [ -n "$ARM_SHA" ] && echo "  ARM CLI: $ARM_SHA"
  [ -n "$GUI_INTEL_SHA" ] && echo "  Intel GUI: $GUI_INTEL_SHA"
  [ -n "$GUI_ARM_SHA" ] && echo "  ARM GUI: $GUI_ARM_SHA"

  # Update formula from template
  if [ "$DO_FORMULA" = "true" ] && [ "$FORMULA_UP_TO_DATE" != "true" ]; then
    echo "Generating formula file: $FORMULA_PATH"
    sed -e "s/{{ClassName}}/$CLASS_NAME/g" \
        -e "s/{{desc}}/$DESC/g" \
        -e "s|{{homepage}}|$REPO|g" \
        -e "s|{{intel_url}}|$LATEST_INTEL_URL|g" \
        -e "s|{{arm_url}}|$LATEST_ARM_URL|g" \
        -e "s/{{intel_sha}}/$INTEL_SHA/g" \
        -e "s/{{arm_sha}}/$ARM_SHA/g" \
        -e "s/{{binary_name}}/$BINARY/g" \
        templates/formula_template.rb > "$WORK_DIR/formula.rb"
    cp "$WORK_DIR/formula.rb" "$FORMULA_PATH"
  fi

  # Update cask from template. The binary stanza is written only for a release
  # whose app holds the command line; the line is dropped otherwise.
  if [ "$DO_CASK" = "true" ] && [ "$CASK_UP_TO_DATE" != "true" ]; then
    echo "Generating cask file: $CASK_PATH"
    if [ -n "$LINK_BINARY" ]; then
      binary_expression="s|{{binary_stanza}}|  binary \"#{appdir}/$APP_BUNDLE.app/Contents/MacOS/$LINK_BINARY\"|"
    else
      binary_expression="/{{binary_stanza}}/d"
    fi
    sed -e "s/{{cask_name}}/$CASK_NAME/g" \
        -e "s/{{version}}/$LATEST_TAG/g" \
        -e "s|{{gui_intel_url}}|$LATEST_GUI_INTEL_URL|g" \
        -e "s|{{gui_arm_url}}|$LATEST_GUI_ARM_URL|g" \
        -e "s/{{gui_intel_sha}}/$GUI_INTEL_SHA/g" \
        -e "s/{{gui_arm_sha}}/$GUI_ARM_SHA/g" \
        -e "s/{{app_name}}/$APP_NAME/g" \
        -e "s/{{desc_gui}}/$DESC_GUI/g" \
        -e "s|{{homepage}}|$REPO|g" \
        -e "s/{{app_bundle}}/$APP_BUNDLE/g" \
        -e "$binary_expression" \
        templates/cask_template.rb > "$WORK_DIR/cask.rb"
    cp "$WORK_DIR/cask.rb" "$CASK_PATH"
  fi

  if [ "$UNIFIED" = "true" ] && [ "$(tool_field formula true)" = "true" ]; then
    retire_formula
  fi

  echo "Finished processing $NAME."
}

# The tools are read on descriptor 3 so that nothing run for a tool can consume
# the rest of the list from standard input.
while IFS= read -r TOOL <&3; do
  process_tool
done 3< <(jq -c '.tools[]' "$TOOLS_JSON")
echo "--- All tools processed ---"

if [ "$PROBLEMS" -gt 0 ]; then
  echo "$PROBLEMS problem(s): at least one tool could not be updated. See the ERROR lines above."
  exit 3
fi
