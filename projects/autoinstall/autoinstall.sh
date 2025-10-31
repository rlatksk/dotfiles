#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_LIST="$SCRIPT_DIR/packages.txt"
AUR_PACKAGE_LIST="$SCRIPT_DIR/aur_packages.txt"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root. Please run as a regular user."
        exit 1
    fi
}

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script is designed for Arch Linux only."
        exit 1
    fi
}

check_paru() {
    if ! command -v paru &> /dev/null; then
        log_warning "paru AUR helper not found. Installing paru..."
        sudo pacman -S --needed --noconfirm git base-devel
        cd /tmp
        git clone https://aur.archlinux.org/paru-bin.git
        cd paru-bin
        makepkg -si --noconfirm
        cd ..
        rm -rf paru-bin
        log_success "paru installed successfully"
    fi
}

check_yay() {
    if ! command -v yay &> /dev/null; then
        log_warning "yay AUR helper not found. Installing yay..."
        sudo pacman -S --needed --noconfirm git base-devel
        cd /tmp
        git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin
        makepkg -si --noconfirm
        cd ..
        rm -rf yay-bin
        log_success "yay installed successfully"
    fi
}

update_system() {
    log_info "Updating system..."
    sudo pacman -Syu --noconfirm
    log_success "System updated"
}

install_official_packages() {
    if [[ ! -f "$PACKAGE_LIST" ]]; then
        log_error "Package list not found at $PACKAGE_LIST"
        exit 1
    fi

    log_info "Installing official repository packages..."
    
    while IFS= read -r package || [[ -n "$package" ]]; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        
        if pacman -Qi "$package" &> /dev/null; then
            log_info "Package $package is already installed, skipping..."
        else
            log_info "Installing $package..."
            sudo pacman -S --needed --noconfirm "$package" || log_warning "Failed to install $package"
        fi
    done < "$PACKAGE_LIST"
    
    log_success "Official packages installation completed"
}

install_aur_packages() {
    if [[ ! -f "$AUR_PACKAGE_LIST" ]]; then
        log_warning "AUR package list not found at $AUR_PACKAGE_LIST. Skipping AUR packages."
        return
    fi

    log_info "Installing AUR packages..."
    
    while IFS= read -r package || [[ -n "$package" ]]; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        
        if pacman -Qi "$package" &> /dev/null; then
            log_info "AUR package $package is already installed, skipping..."
        else
            log_info "Installing AUR package $package..."
            yay -S --needed --noconfirm "$package" || log_warning "Failed to install AUR package $package"
        fi
    done < "$AUR_PACKAGE_LIST"
    
    log_success "AUR packages installation completed"
}

main() {
    log_info "Starting automated package installation..."
    
    check_root
    check_arch
    update_system
    check_paru
    check_yay
    install_official_packages
    install_aur_packages
    
    log_success "All packages have been installed successfully!"
    log_info "You may need to reboot your system for all changes to take effect."
}

main "$@"
