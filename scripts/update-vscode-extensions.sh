#!/usr/bin/env bash
# Update VSCode marketplace extensions in vscode.nix with latest versions and hashes

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_NIX="${1:-$SCRIPT_DIR/../modules/home-manager/vscode.nix}"

if [[ ! -f "$VSCODE_NIX" ]]; then
  echo "Error: $VSCODE_NIX not found"
  exit 1
fi

echo "Updating extensions in $VSCODE_NIX"
echo ""

# Parse multi-line extension blocks from vscode.nix
# Extract name, publisher, version for extensions that have sha256 (marketplace extensions)
parse_extensions() {
  awk '
    /name = "/ {
      match($0, /name = "([^"]+)"/)
      name = substr($0, RSTART + 8, RLENGTH - 9)
    }
    /publisher = "/ {
      match($0, /publisher = "([^"]+)"/)
      publisher = substr($0, RSTART + 13, RLENGTH - 14)
    }
    /version = "/ {
      match($0, /version = "([^"]+)"/)
      version = substr($0, RSTART + 11, RLENGTH - 12)
    }
    /sha256 = "/ {
      if (name != "" && publisher != "" && version != "") {
        print publisher "." name "@" version
      }
      name = ""; publisher = ""; version = ""
    }
  ' "$VSCODE_NIX"
}

extensions=$(parse_extensions)

if [[ -z "$extensions" ]]; then
  echo "No marketplace extensions found in $VSCODE_NIX"
  exit 0
fi

updated=0
for ext in $extensions; do
  publisher=$(echo "$ext" | cut -d. -f1)
  name=$(echo "$ext" | cut -d. -f2 | cut -d@ -f1)
  old_version=$(echo "$ext" | cut -d@ -f2)

  echo -n "Checking $publisher.$name... "

  # Get latest version from marketplace API
  response=$(curl -sf -X POST \
    -H "Content-Type: application/json" \
    -H "Accept: application/json;api-version=3.0-preview.1" \
    -d "{\"filters\":[{\"criteria\":[{\"filterType\":7,\"value\":\"$publisher.$name\"}]}],\"flags\":512}" \
    "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery" 2>/dev/null || echo "")

  if [[ -z "$response" ]]; then
    echo "SKIP (couldn't fetch from marketplace)"
    continue
  fi

  latest_version=$(echo "$response" | grep -o '"version":"[^"]*"' | head -1 | sed 's/"version":"\([^"]*\)"/\1/' || echo "")

  if [[ -z "$latest_version" ]]; then
    echo "SKIP (couldn't parse version)"
    continue
  fi

  if [[ "$old_version" == "$latest_version" ]]; then
    echo "up to date ($latest_version)"
    continue
  fi

  echo -n "updating $old_version -> $latest_version... "

  # Fetch new hash
  new_hash=$(nix-prefetch-url --quiet "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$name/$latest_version/vspackage" 2>/dev/null || echo "")

  if [[ -z "$new_hash" ]]; then
    echo "FAILED (couldn't fetch package)"
    continue
  fi

  # Update the version in vscode.nix
  # Use perl to do multi-line replacement within the extension block
  perl -i -0777 -pe "
    s/(name = \"$name\";\s*\n\s*publisher = \"$publisher\";\s*\n\s*)version = \"$old_version\"(\s*;\s*\n\s*)sha256 = \"[^\"]+\"/\${1}version = \"$latest_version\"\${2}sha256 = \"$new_hash\"/gs
  " "$VSCODE_NIX"

  echo "done"
  ((updated++))
done

echo ""
if [[ $updated -gt 0 ]]; then
  echo "Updated $updated extension(s). Run 'darwin-rebuild switch --flake .#macbook' to apply."
else
  echo "All extensions are up to date."
fi
