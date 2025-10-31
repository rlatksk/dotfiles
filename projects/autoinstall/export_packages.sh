#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_LIST="$SCRIPT_DIR/packages.txt"
AUR_PACKAGE_LIST="$SCRIPT_DIR/aur_packages.txt"

echo "Exporting explicitly installed packages..."

pacman -Qqe | grep -v "$(pacman -Qqm)" > "$PACKAGE_LIST"

echo "Exporting AUR packages..."
pacman -Qqm > "$AUR_PACKAGE_LIST"

echo "Package lists exported successfully!"
echo "  - Official packages: $PACKAGE_LIST ($(wc -l < "$PACKAGE_LIST") packages)"
echo "  - AUR packages: $AUR_PACKAGE_LIST ($(wc -l < "$AUR_PACKAGE_LIST") packages)"
