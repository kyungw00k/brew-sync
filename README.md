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

- **🔄 Multi-Mac sync**: Combines packages from all your machines
- **☁️ Auto storage**: Works with iCloud, Dropbox, Google Drive, Git
- **📱 Complete coverage**: Homebrew + Cask apps + Mac App Store apps  
- **🏷️ Profiles**: Different setups for work, personal, development
- **🔍 Preview mode**: `--dry-run` to see what will be installed
- **⚡ Simple**: Just `backup` and `restore` - auto-detects everything

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/kyungw00k/brew-sync/main/install.sh | bash
```

## Basic Usage

```bash
# Backup packages
brew-sync backup

# Restore packages  
brew-sync restore

# Use profiles for different setups
brew-sync backup --profile work
brew-sync restore --profile work --merged

# List available backups
brew-sync list

# Get help
brew-sync help
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

```bash
# Storage options (auto-detected by default)
brew-sync backup --icloud
brew-sync backup --dropbox  
brew-sync backup --google-drive
brew-sync backup --git
brew-sync backup --path ~/my-backup
brew-sync backup --usb MyUSB

# Restore options
brew-sync restore --merged          # All Macs combined
brew-sync restore --host MacBook-Pro # Specific Mac
brew-sync restore --dry-run         # Preview only
```

## Requirements

- macOS 10.12+
- Homebrew (latest recommended)
- Cloud storage or Git repository (for multi-Mac sync)

## License

MIT License - see [LICENSE](LICENSE) file for details.