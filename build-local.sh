#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XCODE_APP="/Applications/Xcode.app"
DEVELOPER_DIR_PATH="$XCODE_APP/Contents/Developer"
DERIVED_DATA="$PROJECT_DIR/build/DerivedData"
OUTPUT_DIR="$PROJECT_DIR/build"
APP_SRC="$DERIVED_DATA/Build/Products/Debug/IrProCapture.app"
APP_DST="$OUTPUT_DIR/IrProCapture.app"

if [[ ! -d "$DEVELOPER_DIR_PATH" ]]; then
  cat <<'MSG'
Xcode.app is not installed.

Install Xcode from the Mac App Store first, then run:
  cd ~/Documents/GitHub/InfiRayCapture
  ./build-local.sh

Do not open the .swift files directly. Open IrProCapture.xcodeproj in Xcode,
or use this script after Xcode is installed.
MSG
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

DEVELOPER_DIR="$DEVELOPER_DIR_PATH" xcodebuild build \
  -project "$PROJECT_DIR/IrProCapture.xcodeproj" \
  -scheme IrProCapture \
  -configuration Debug \
  -destination 'platform=macOS' \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO

rm -rf "$APP_DST"
ditto "$APP_SRC" "$APP_DST"

echo
echo "Built app:"
echo "  $APP_DST"
echo
echo "Run it with:"
echo "  open \"$APP_DST\""
