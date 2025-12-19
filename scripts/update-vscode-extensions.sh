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

# Extract marketplace extensions from the nix file
# Format: { name = "ext-name"; publisher = "pub"; version = "x.y.z"; sha256 = "hash"; }
# Only match lines with sha256 (marketplace extensions)
extensions=$(grep -E 'publisher = ".*sha256 = "' "$VSCODE_NIX" | sed 's/.*name = "\([^"]*\)".*publisher = "\([^"]*\)".*version = "\([^"]*\)".*/\2.\1@\3/')

for ext in $extensions; do
  publisher=$(echo "$ext" | cut -d. -f1)
  name=$(echo "$ext" | cut -d. -f2 | cut -d@ -f1)
  old_version=$(echo "$ext" | cut -d@ -f2)

  echo -n "Checking $publisher.$name... "

  # Get latest version from marketplace API (more reliable than scraping HTML)
  latest_version=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Accept: application/json;api-version=3.0-preview.1" \
    -d "{\"filters\":[{\"criteria\":[{\"filterType\":7,\"value\":\"$publisher.$name\"}]}],\"flags\":512}" \
    "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery" 2>/dev/null | \
    grep -o '"version":"[^"]*"' | head -1 | sed 's/"version":"\([^"]*\)"/\1/')

  if [[ -z "$latest_version" ]]; then
    echo "SKIP (couldn't fetch version)"
    continue
  fi

  if [[ "$old_version" == "$latest_version" ]]; then
    echo "up to date ($latest_version)"
    continue
  fi

  echo -n "updating $old_version -> $latest_version... "

  # Fetch new hash
  new_hash=$(nix-prefetch-url "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$name/$latest_version/vspackage" 2>/dev/null || echo "")

  if [[ -z "$new_hash" ]]; then
    echo "FAILED (couldn't fetch package)"
    continue
  fi

  # Update the nix file using perl (more reliable than sed on macOS)
  perl -i -pe "s/name = \"$name\"; publisher = \"$publisher\"; version = \"$old_version\"; sha256 = \"[^\"]+\"/name = \"$name\"; publisher = \"$publisher\"; version = \"$latest_version\"; sha256 = \"$new_hash\"/" "$VSCODE_NIX"

  echo "done"
done

echo ""
echo "Update complete! Run 'darwin-rebuild switch --flake .#macbook' to apply."
