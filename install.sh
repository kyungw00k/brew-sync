#!/bin/bash

# brew-sync installation script
# Install as Homebrew subcommand from GitHub

set -e

# Configuration
GITHUB_REPO="kyungw00k/brew-sync"
GITHUB_RAW_BASE="https://raw.githubusercontent.com/$GITHUB_REPO/main"
TEMP_DIR="/tmp/brew-sync-install-$$"

# Color settings
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function: Log output
log_info() {
    echo -e "${BLUE}•${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function: Cleanup on exit
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}

trap cleanup EXIT

# Check requirements
if ! command -v curl &> /dev/null; then
    log_error "curl is required but not installed."
    exit 1
fi

if ! command -v brew &> /dev/null; then
    log_error "Homebrew is not installed."
    log_info "Please install Homebrew first: https://brew.sh"
    exit 1
fi

# Determine installation directory
INSTALL_DIR="/usr/local/bin"
if [[ $(uname -m) == "arm64" ]]; then
    INSTALL_DIR="/opt/homebrew/bin"
fi

# Check permissions
if [ ! -w "$INSTALL_DIR" ]; then
    log_warning "No write permission to installation directory: $INSTALL_DIR"
    log_info "sudo permission may be required."
fi

# Determine installation source (local vs remote)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES_TO_INSTALL=(
    "brew-sync"
)

# Check if all required files exist locally
LOCAL_INSTALL=true
for file in "${FILES_TO_INSTALL[@]}"; do
    if [ ! -f "$SCRIPT_DIR/$file" ]; then
        LOCAL_INSTALL=false
        break
    fi
done

if [ "$LOCAL_INSTALL" = true ]; then
    log_info "Installing brew-sync from local files..."
    cd "$SCRIPT_DIR"
else
    log_info "Installing brew-sync from GitHub..."
    
    # Create temporary directory
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
    
    # Download files from GitHub
    log_info "Downloading files from GitHub repository..."
    for file in "${FILES_TO_INSTALL[@]}"; do
        log_info "Downloading $file..."
        if curl -fsSL "$GITHUB_RAW_BASE/$file" -o "$file"; then
            chmod +x "$file"
            log_info "Downloaded: $file"
        else
            log_error "Failed to download: $file"
            log_error "Please check if the repository exists: https://github.com/$GITHUB_REPO"
            exit 1
        fi
    done
fi

# Install files to Homebrew bin directory
log_info "Installing files to $INSTALL_DIR..."
for file in "${FILES_TO_INSTALL[@]}"; do
    if [ -w "$INSTALL_DIR" ]; then
        cp "$file" "$INSTALL_DIR/"
        log_info "Installed: $INSTALL_DIR/$file"
    else
        sudo cp "$file" "$INSTALL_DIR/"
        log_info "Installed: $INSTALL_DIR/$file (with sudo)"
    fi
done

log_success "brew-sync installation completed!"
echo ""
log_info "Usage:"
log_info "  brew-sync backup      # Backup packages"
log_info "  brew-sync restore     # Restore packages"
log_info "  brew-sync list        # List available backups"
log_info "  brew-sync help        # Show help"
echo ""
log_info "Verify installation: brew-sync help"
echo ""
log_info "For more information:"
log_info "  Repository: https://github.com/$GITHUB_REPO"
log_info "  Documentation: brew-sync backup --help"