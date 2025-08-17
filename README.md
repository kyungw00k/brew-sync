# brew-sync

> Keep your Homebrew packages synchronized across multiple Macs

## What does it do?

**The Problem**: You have multiple Macs and want the same apps and tools on all of them.

**The Solution**: Two simple commands that backup and restore everything.

```bash
# On your first Mac
brew-sync backup

# On your second Mac  
brew-sync restore
```

That's it! All your Homebrew packages, GUI apps, and Mac App Store apps are now synchronized.

## Key Features

- **🚀 Smart setup**: First-time interactive setup with intelligent defaults
- **🔄 Multi-Mac sync**: Combines packages from all your machines
- **☁️ Flexible storage**: iCloud, Dropbox, Google Drive, Git, or local-only
- **💻 Local option**: `.brew-sync` for single-Mac or privacy-conscious users
- **📱 Complete coverage**: Homebrew + Cask apps + Mac App Store apps  
- **🏷️ Profiles**: Different setups for work, personal, development
- **🔍 Preview mode**: `--dry-run` to see what will be installed
- **⚡ Simple**: Just `backup` and `restore` - auto-detects everything
- **🔄 Backward compatible**: Existing setups continue working unchanged

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/kyungw00k/brew-sync/main/install.sh | bash
```

## Basic Usage

### First Run (Interactive Setup)
```bash
# On first run, brew-sync guides you through setup
brew-sync backup

# 🍺 Welcome to brew-sync!
# Choose your backup storage location:
#
#  1) Git Repository 🔄 Version control and manual sync
#  2) iCloud Drive (recommended for multiple Macs) 📱 
#  3) Local storage (.brew-sync) 💻 Stays on this Mac only
#
# Select storage (1-3, press Enter for 2): 
```

### Daily Usage
```bash
# Backup packages (uses your saved preference)
brew-sync backup

# Restore packages (uses your saved preference)
brew-sync restore --dry-run    # Preview first (recommended)
brew-sync restore              # Actually install

# Use profiles for different setups
brew-sync backup --profile work
brew-sync restore --profile work --merged

# Utility commands
brew-sync list                 # List available backups
brew-sync update               # Update to latest version
brew-sync update --check       # Check for updates only
brew-sync uninstall            # Uninstall brew-sync
brew-sync help                 # Get help
```

## Real-world example

```bash
# Work MacBook: backup your development setup
$ brew-sync backup --profile work
• iCloud Drive detected: ~/Library/Mobile Documents/com~apple~CloudDocs/brew-backup
• Starting Brewfile backup...
• Host: MacBook-Pro
• Generating current package list...
✓ Brewfile generation completed
• [MacBook-Pro] Backup completed!
• Package statistics: Homebrew(47) Cask(12) MAS(8)
✓ All operations completed!

# Home iMac: restore the same setup  
$ brew-sync restore --profile work --merged
• iCloud Drive detected: ~/Library/Mobile Documents/com~apple~CloudDocs/brew-backup
→ Restore source: Profile 'work' merged backup
• Package information to restore:
•   - Homebrew packages: 47
•   - Cask apps: 12
•   - Mac App Store apps: 8

✓ Copied Brewfile to current directory
→ Starting package installation...
• Running brew bundle...
Using node, python, docker, git, vscode, slack, cursor...
`brew bundle` complete! 67 Brewfile dependencies now installed.
✓ All packages installed successfully!
```

## Common Options

### Storage Options
```bash
# Use your configured storage (default)
brew-sync backup                    # Uses saved preference

# Temporary storage override (doesn't change your default)
brew-sync backup --icloud           # iCloud Drive (temporary)
brew-sync backup --dropbox          # Dropbox (temporary)
brew-sync backup --google-drive     # Google Drive (temporary)
brew-sync backup --git              # Git repository (temporary)
brew-sync backup --path ~/backup    # Custom path (temporary)
brew-sync backup --usb MyUSB        # USB drive (temporary)

# Change your default storage
brew-sync backup --select-storage   # Interactive selection (saves new default)
```

### Restore Options
```bash
# What to restore
brew-sync restore                   # Your Mac's backup (default)
brew-sync restore --merged          # All Macs combined
brew-sync restore --host MacBook-Pro # Specific Mac's backup
brew-sync restore --profile work    # Specific profile

# Where to restore from (temporary overrides)
brew-sync restore --icloud --merged # From iCloud, all Macs
brew-sync restore --git --host MyMac # From Git, specific Mac

# Preview and change defaults
brew-sync restore --dry-run         # Preview only (recommended)
brew-sync restore --select-storage  # Choose storage and restore
```

### Update Options
```bash
brew-sync update                     # Update to latest version
brew-sync update --check            # Check for updates only
```

## Requirements

### Essential
- macOS 10.12+
- Homebrew (latest recommended)

### Optional (based on your choice)
- **Multi-Mac sync**: iCloud Drive, Dropbox, Google Drive, OneDrive, or Git repository
- **Single Mac**: No additional requirements (uses local `~/.brew-sync` storage)
- **Existing users**: Your current setup continues working unchanged

## License

MIT License - see [LICENSE](LICENSE) file for details.