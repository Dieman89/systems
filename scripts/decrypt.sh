#!/usr/bin/env bash
# Decrypt a file using age with the private key from 1Password
# Usage: ./scripts/decrypt.sh <input-file.age> [output-file]

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <input-file.age> [output-file]"
  echo "Example: $0 assets/fonts.zip.age assets/fonts.zip"
  exit 1
fi

INPUT="$1"

if [[ "$INPUT" != *.age ]]; then
  echo "Error: Input file must have .age extension"
  exit 1
fi

if [ ! -f "$INPUT" ]; then
  echo "Error: File not found: $INPUT"
  exit 1
fi

# Default output: remove .age extension
OUTPUT="${2:-${INPUT%.age}}"

if [ -f "$OUTPUT" ]; then
  echo "Output file already exists: $OUTPUT"
  read -p "Overwrite? [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi
fi

echo "Decrypting $INPUT..."
op read 'op://Private/Nix Private Key/notesPlain' | age -d -i - -o "$OUTPUT" "$INPUT"
echo "Decrypted: $INPUT -> $OUTPUT"
