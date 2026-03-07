#!/bin/sh

# Choose which GoogleService-Info.plist to use based on the build configuration (flavor)
# The configuration name usually contains the flavor name (e.g., Debug-dev, Release-prod)

DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

case $CONFIGURATION in
  *dev*|Debug)
    SRC="${PROJECT_DIR}/Runner/Firebase/dev/GoogleService-Info.plist"
    ;;
  *prod*|Release)
    SRC="${PROJECT_DIR}/Runner/Firebase/prod/GoogleService-Info.plist"
    ;;
  *)
    echo "error: No flavor detected in configuration: $CONFIGURATION"
    exit 1
    ;;
esac

if [ ! -f "$SRC" ]; then
  echo "error: GoogleService-Info.plist not found at $SRC"
  exit 1
fi

cp -f "$SRC" "$DEST"
echo "Copied $SRC to $DEST"
