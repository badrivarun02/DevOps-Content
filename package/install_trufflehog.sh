#!/bin/bash

set -e  # Exit on error

VERSION="3.90.8"
ARCHIVE="trufflehog_${VERSION}_linux_amd64.tar.gz"
URL="https://github.com/trufflesecurity/trufflehog/releases/download/v${VERSION}/${ARCHIVE}"
BIN_NAME="trufflehog"
INSTALL_PATH="/usr/local/bin"

echo "🚀 Installing TruffleHog v$VERSION..."

# Step 1: Download
echo "📦 Downloading archive..."
wget -q "$URL" -O "$ARCHIVE"
echo "✅ Downloaded: $ARCHIVE"

# Step 2: Extract
echo "📂 Extracting binary..."
tar -zxvf "$ARCHIVE"
echo "✅ Extracted: $BIN_NAME"

# Step 3: Install
echo "🔧 Installing to $INSTALL_PATH..."
sudo install "$BIN_NAME" "$INSTALL_PATH"
echo "✅ Installed: $INSTALL_PATH/$BIN_NAME"

# Step 4: Verify
echo "🔍 Verifying installation..."
"$BIN_NAME" --version

# Optional: Cleanup
rm -f "$ARCHIVE" "$BIN_NAME"

echo "🎉 TruffleHog installation complete."
