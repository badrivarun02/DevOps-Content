#!/bin/bash

PKG="$1"

if [ -z "$PKG" ]; then
  echo "❌ Please provide a package name."
  echo "Usage: ./uninstall.sh <package-name>"
  exit 1
fi

echo "🔍 Uninstalling package: $PKG"

# Remove via apt (Debian/Ubuntu)
if command -v apt &>/dev/null; then
  echo "📦 Checking apt..."
  if dpkg -l | grep -qw "$PKG"; then
    echo "🧹 Removing $PKG via apt..."
    sudo apt remove --purge -y "$PKG"
    sudo apt autoremove --purge -y
  fi
fi

# Remove via yum (RHEL/CentOS)
if command -v yum &>/dev/null; then
  echo "📦 Checking yum..."
  if yum list installed "$PKG" &>/dev/null; then
    echo "🧹 Removing $PKG via yum..."
    sudo yum remove -y "$PKG"
  fi
fi

# Remove via dnf (Fedora)
if command -v dnf &>/dev/null; then
  echo "📦 Checking dnf..."
  if dnf list installed "$PKG" &>/dev/null; then
    echo "🧹 Removing $PKG via dnf..."
    sudo dnf remove -y "$PKG"
  fi
fi

# Remove via pip
if command -v pip &>/dev/null; then
  echo "🐍 Checking pip..."
  pip show "$PKG" &>/dev/null && pip uninstall -y "$PKG"
fi
if command -v pip3 &>/dev/null; then
  pip3 show "$PKG" &>/dev/null && pip3 uninstall -y "$PKG"
fi

# Remove binary if exists
BIN_PATH=$(which "$PKG" 2>/dev/null)
if [ -n "$BIN_PATH" ]; then
  echo "🗑️ Removing binary: $BIN_PATH"
  sudo rm -f "$BIN_PATH"
fi

# Remove config folders (common locations)
echo "🧾 Checking for config folders..."
rm -rf "$HOME/.config/$PKG" "$HOME/.$PKG" "$HOME/.local/share/$PKG"

# Remove shell aliases
echo "🧼 Cleaning shell profile entries..."
sed -i "/alias $PKG=/d" ~/.bashrc ~/.zshrc ~/.profile 2>/dev/null
sed -i "/$PKG\/bin/d" ~/.bashrc ~/.zshrc ~/.profile 2>/dev/null

echo "✅ Uninstall complete for: $PKG"

