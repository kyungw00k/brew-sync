#!/bin/bash

# brew-sync uninstall script

set -e

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

# Check installation directory
INSTALL_DIR="/usr/local/bin"
if [[ $(uname -m) == "arm64" ]]; then
    INSTALL_DIR="/opt/homebrew/bin"
fi

log_info "Uninstalling brew-sync..."

# Files to remove
FILES_TO_REMOVE=(
    "brew-sync"
)

for file in "${FILES_TO_REMOVE[@]}"; do
    if [ -f "$INSTALL_DIR/$file" ]; then
        if [ -w "$INSTALL_DIR" ]; then
            rm "$INSTALL_DIR/$file"
            log_info "Removed: $INSTALL_DIR/$file"
        else
            sudo rm "$INSTALL_DIR/$file"
            log_info "Removed: $INSTALL_DIR/$file (with sudo)"
        fi
    else
        log_warning "File not found: $INSTALL_DIR/$file"
    fi
done

log_success "brew-sync uninstall completed!"
echo ""
log_info "Note: Backup data was not removed."
log_info "Your backup data may be located at:"
log_info "  - ~/Library/Mobile Documents/com~apple~CloudDocs/brew-backup (iCloud)"
log_info "  - ~/Dropbox/brew-backup (Dropbox)"
log_info "  - ~/Google Drive/brew-backup (Google Drive)"
log_info "  - ~/.config/brew-sync (local)"