#!/bin/sh

# Choose which GoogleService-Info.plist to use based on the build configuration (flavor)
# The configuration name usually contains the flavor name (e.g., Debug-dev, Release-prod)

DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

case $CONFIGURATION in
  *dev*)
    cp -f "${PROJECT_DIR}/Runner/Firebase/dev/GoogleService-Info.plist" "$DEST"
    echo "Copied Dev GoogleService-Info.plist"
    ;;
  *prod*)
    cp -f "${PROJECT_DIR}/Runner/Firebase/prod/GoogleService-Info.plist" "$DEST"
    echo "Copied Prod GoogleService-Info.plist"
    ;;
  *)
    echo "No flavor detected in configuration: $CONFIGURATION. Using default if available."
    ;;
esac
