#!/bin/bash

set -e  # Exit on error

ARCHIVE="awscliv2.zip"
URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
INSTALL_DIR="./aws"

echo "🚀 Installing AWS CLI v2..."

# Step 1: Download
echo "📦 Downloading AWS CLI archive..."
curl -s "$URL" -o "$ARCHIVE"
echo "✅ Downloaded: $ARCHIVE"

# Step 2: Extract
echo "📂 Extracting archive..."
unzip -q "$ARCHIVE"
echo "✅ Extracted to: $INSTALL_DIR"

# Step 3: Install
echo "🔧 Installing AWS CLI..."
sudo "$INSTALL_DIR/install"
echo "✅ Installed AWS CLI"

# Step 4: Verify
echo "🔍 Verifying installation..."
aws --version

# Optional: Cleanup
rm -rf "$ARCHIVE" "$INSTALL_DIR"

echo "🎉 AWS CLI installation complete."
