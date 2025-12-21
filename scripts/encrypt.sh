#!/usr/bin/env bash
# Encrypt a file using age with the public key
# Usage: ./scripts/encrypt.sh <input-file> [output-file]

set -e

PUBLIC_KEY="age1uq49kmdfddy735f6h5859wdw7aryd50vjyjenj0jr8gxpmxqmueqxxa70w"

if [ -z "$1" ]; then
  echo "Usage: $0 <input-file> [output-file]"
  echo "Example: $0 assets/fonts.zip assets/fonts.zip.age"
  exit 1
fi

INPUT="$1"
OUTPUT="${2:-$1.age}"

if [ ! -f "$INPUT" ]; then
  echo "Error: File not found: $INPUT"
  exit 1
fi

age -r "$PUBLIC_KEY" -o "$OUTPUT" "$INPUT"
echo "Encrypted: $INPUT -> $OUTPUT"
