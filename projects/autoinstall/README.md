# Arch Linux Auto-Installer

Automate the installation of all packages from your current Arch Linux system.

## Files

- **autoinstall.sh** - Main installation script
- **export_packages.sh** - Export current system packages to text files
- **packages.txt** - List of official repository packages (66 packages)
- **aur_packages.txt** - List of AUR packages (45 packages)

## Usage

### Export Current System Packages

```bash
./export_packages.sh
```

This will create/update `packages.txt` and `aur_packages.txt` with your current installed packages.

### Install Packages on a New System

```bash
./autoinstall.sh
```

This will:
1. Update the system
2. Install yay if not present
3. Install all packages from `packages.txt` (official repos)
4. Install all packages from `aur_packages.txt` (AUR)

## Features

- Color-coded output for easy reading
- Checks if packages are already installed (skips if present)
- Automatic yay installation if missing
- Error handling and logging
- Safe to re-run multiple times

## Requirements

- Arch Linux system
- Internet connection
- sudo privileges
