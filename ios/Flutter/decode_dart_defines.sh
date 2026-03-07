#!/bin/sh

# Decode DART_DEFINES and write to DartDefines.xcconfig
OUTPUT_FILE="${SRCROOT}/Flutter/DartDefines.xcconfig"
echo "// This is a generated file; do not edit or check into version control." > "$OUTPUT_FILE"

if [ -n "$DART_DEFINES" ]; then
  echo "Decoding DART_DEFINES..."
  # Split by comma
  IFS=',' read -ra ADDR <<< "$DART_DEFINES"
  for i in "${ADDR[@]}"; do
    # Decode base64
    DECODED=$(echo "$i" | base64 --decode)
    if [ -n "$DECODED" ]; then
      echo "$DECODED" >> "$OUTPUT_FILE"
      echo "  Decoded: $DECODED"
    fi
  done
else
  echo "DART_DEFINES is empty."
fi
