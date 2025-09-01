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

- **Smart setup**: First-time interactive setup with intelligent defaults
- **Multi-Mac sync**: Organized by profiles for different use cases  
- **Flexible storage**: iCloud, Dropbox, Google Drive, Git, or local-only
- **Local option**: `.brew-sync` for single-Mac or privacy-conscious users
- **Complete coverage**: Homebrew + Cask apps + Mac App Store apps  
- **Profiles**: Different setups for work, personal, development
- **Machine-specific defaults**: Automatically loads per-machine default profile
- **Safe profile editing**: Edit package lists with diff preview and confirmation
- **Clean CLI interface**: Concise output with optional verbose mode (`--verbose`)
- **Preview mode**: `--dry-run` to see what will be installed
- **Simple**: Just `backup` and `restore` - auto-detects everything
- **Auto-migration**: Existing host-based setups automatically migrate to profiles

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
#
# After storage setup, you'll configure your default profile:
#
# 🔧 Profile Setup
#
# Found existing profiles:
# ┌─────────────────────┬─────────────┬──────────────┐
# │ Profile             │ Packages    │ Last Updated │
# ├─────────────────────┼─────────────┼──────────────┤
# │ default             │ 120 pkgs    │ 2024-01-15   │
# │ work                │ 85 pkgs     │ 2024-01-10   │
# └─────────────────────┴─────────────┴──────────────┘
#
# Setup options:
# 1) Use 'default' profile (recommended)
# 2) Use existing profile from list above
# 3) Create new profile based on hostname ('mbp')
# 4) Enter custom profile name
#
# Select option (1-4): 
```

### Daily Usage
```bash
# Backup packages (uses your saved preference)
brew-sync backup
brew-sync backup --verbose     # Show detailed progress

# Restore packages (uses your saved preference)
brew-sync restore --dry-run    # Preview first (recommended)
brew-sync restore              # Actually install
brew-sync restore --verbose    # Show installation details

# Use profiles for different setups
brew-sync backup --profile work
brew-sync restore --profile work

# Machine-specific default profile (automatically loaded from ~/.config/brew-sync/default_profile)
brew-sync backup                  # Uses machine-specific default profile
brew-sync restore                 # Uses machine-specific default profile

# Profile management commands
brew-sync profile list            # List all profiles
brew-sync profile show work       # Show details of work profile
brew-sync profile edit work       # Edit work profile packages safely
brew-sync profile edit            # Edit default profile or select one
brew-sync profile remove old      # Remove old profile (except 'default')

# Utility commands
brew-sync list                 # List available backups
brew-sync update               # Update to latest version
brew-sync update --check       # Check for updates only
brew-sync uninstall            # Uninstall brew-sync
brew-sync help                 # Get help
```

## Profile Editing

The `profile edit` feature lets you safely modify your package lists with a diff-based approach:

```bash
# Edit your work profile
$ brew-sync profile edit work
Using default profile: work
Editing profile 'work'

Press any key to continue...

# After editing and saving in your editor:
Brewfile edited successfully

Changes to be applied to profile 'work':

INSTALL:
  + brew "htop"
  + cask "notion"

REMOVE:
  - brew "bat"  

Apply these changes? [y/N]: y
Installing brew package: htop
Installing cask: notion  
Removing brew package: bat
Package changes applied successfully
Profile 'work' updated with your changes
Profile 'work' synchronized successfully
```

### Key Benefits
- **Safe editing**: Edit a temporary copy, not your actual profile
- **Smart preview**: See exactly what will be installed/removed before applying
- **User control**: Confirm changes before any system modifications
- **Package-specific**: Only install/remove the exact packages you changed
- **No surprises**: No aggressive cleanup that removes unrelated packages

### Usage Patterns
```bash
# Edit specific profile
brew-sync profile edit work

# Edit default profile (or select if none set)
brew-sync profile edit

# Typical workflow
brew-sync profile edit     # Make your changes
# Review the preview carefully
# Type 'y' to apply or 'N' to cancel
```

## Real-world example

```bash
# Work MacBook: backup your development setup
$ brew-sync backup --profile work
Backup completed (67 packages)

# With verbose output:
$ brew-sync backup --profile work --verbose
Starting backup for profile 'work' on host 'MacBook-Pro'  
Generating current package list...
Package list generated successfully
Backup completed (67 packages)
Location: ~/Library/Mobile Documents/com~apple~CloudDocs/brew-backup/profiles/work/Brewfile
Packages: 47 brew, 12 cask, 8 MAS apps

# Home iMac: restore the same setup  
$ brew-sync restore --profile work --dry-run
[DRY-RUN] All packages are already installed

$ brew-sync restore --profile work
Restore completed successfully!

# With verbose output:
$ brew-sync restore --profile work --verbose  
Starting package installation from /tmp/Brewfile.temp
Executing: brew bundle --file="/tmp/Brewfile.temp" --no-upgrade
Using node, python, docker, git, vscode, slack, cursor...
`brew bundle` complete! 67 Brewfile dependencies now installed.
Restore completed successfully!
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
brew-sync restore                   # Default profile backup (loads machine-specific default)
brew-sync restore --profile work    # Work profile backup
brew-sync restore --profile dev     # Development profile backup

# Where to restore from (temporary overrides)
brew-sync restore --icloud --profile work # From iCloud, work profile
brew-sync restore --git --profile dev     # From Git, dev profile

# Preview and change defaults
brew-sync restore --dry-run         # Preview only (recommended)
brew-sync restore --select-storage  # Choose storage and restore
```

### Verbose Output
```bash
# Show detailed progress information
brew-sync backup --verbose          # Detailed backup process  
brew-sync restore --verbose         # Detailed installation process
brew-sync profile edit --verbose    # Detailed editing process

# Combine with other options
brew-sync backup --profile work --verbose
brew-sync restore --dry-run --verbose
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