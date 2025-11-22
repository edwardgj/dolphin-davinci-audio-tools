#!/usr/bin/env bash
set -e

# Dolphin Davinci Audio Tools Uninstallation Script
# Removes all installed files and directories

SERVICE_DIR="$HOME/.local/share/kio/servicemenus"
SCRIPT_DEST_DIR="$HOME/.local/share/dolphin-davinci-audio-tools"

echo "=== Dolphin Davinci Audio Tools Uninstallation ==="
echo

# Function to confirm uninstallation
confirm_uninstall() {
    echo "This will remove:"
    echo "• Service menu: $SERVICE_DIR/dolphin-davinci-conversions.desktop"
    echo "• Scripts directory: $SCRIPT_DEST_DIR"
    echo
    read -p "Are you sure you want to uninstall Dolphin Davinci Audio Tools? [y/N] " yn
    if [[ ! "$yn" =~ ^[Yy]$ ]]; then
        echo "Uninstallation cancelled."
        exit 0
    fi
}

# Check if installation exists
installation_exists=false

if [ -f "$SERVICE_DIR/dolphin-davinci-conversions.desktop" ]; then
    echo "✓ Found service menu installation"
    installation_exists=true
fi

if [ -d "$SCRIPT_DEST_DIR" ]; then
    echo "✓ Found scripts installation"
    installation_exists=true
fi

if [ "$installation_exists" = false ]; then
    echo "No installation found. Nothing to uninstall."
    exit 0
fi

echo
confirm_uninstall

echo
echo "Removing Dolphin Davinci Audio Tools..."

# Remove service menu file
if [ -f "$SERVICE_DIR/dolphin-davinci-conversions.desktop" ]; then
    rm "$SERVICE_DIR/dolphin-davinci-conversions.desktop"
    echo "✓ Removed service menu: dolphin-davinci-conversions.desktop"
else
    echo "⚠ Service menu not found: $SERVICE_DIR/dolphin-davinci-conversions.desktop"
fi

# Remove scripts directory
if [ -d "$SCRIPT_DEST_DIR" ]; then
    rm -rf "$SCRIPT_DEST_DIR"
    echo "✓ Removed scripts directory: $SCRIPT_DEST_DIR"
else
    echo "⚠ Scripts directory not found: $SCRIPT_DEST_DIR"
fi

# Clean up empty parent directories if they exist
if [ -d "$HOME/.local/share" ]; then
    rmdir --ignore-fail-on-non-empty "$HOME/.local/share/kio" 2>/dev/null || true
    rmdir --ignore-fail-on-non-empty "$HOME/.local/share" 2>/dev/null || true
fi

echo
echo "=== Uninstallation Complete ==="
echo
echo "Dolphin Davinci Audio Tools has been successfully removed."
echo
echo "To complete the uninstallation:"
echo "1. Restart Dolphin (or open a new Dolphin window)"
echo "   Run: kquitapp5 dolphin && dolphin"
echo
echo "2. The 'Davinci Resolve Conversions' menu will no longer appear"
echo "   in the right-click context menu."
echo
echo "Thank you for using Dolphin Davinci Audio Tools!"
echo

# Check if service menu directory is now empty and offer to remove it
if [ -d "$SERVICE_DIR" ]; then
    if [ -z "$(ls -A "$SERVICE_DIR" 2>/dev/null)" ]; then
        echo "Note: The service menu directory $SERVICE_DIR is now empty."
        read -p "Would you like to remove this empty directory? [y/N] " yn
        if [[ "$yn" =~ ^[Yy]$ ]]; then
            rmdir "$SERVICE_DIR"
            echo "✓ Removed empty service menu directory"
        fi
    fi
fi

echo "Uninstallation finished successfully."