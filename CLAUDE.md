# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`brew-sync` is a Homebrew package synchronization tool that enables users to backup and restore Homebrew packages across multiple Macs using a profile-based system. The project consists of a single bash script (`brew-sync`) that handles all operations, with automatic migration from legacy host-based setups.

## Core Commands

Development and testing commands:
```bash
# Test the script locally
./brew-sync help
./brew-sync backup --dry-run
./brew-sync restore --dry-run

# Test with verbose output
./brew-sync backup --verbose --dry-run
./brew-sync restore --verbose --dry-run

# Test profile editing
./brew-sync profile edit --verbose

# Install/uninstall locally for testing
./install.sh
./uninstall.sh
```

The script supports multiple storage backends (iCloud, Dropbox, Google Drive, Git, local) and profiles for different use cases.

## Architecture

### Main Script Structure (`brew-sync`)
- **Configuration**: Lines 8-48 - Version, paths, colors, global flags, and defaults
- **Enhanced Logging System**: Lines 50-86 - Clean CLI logging with verbose support
- **Migration System**: Lines 88-607 - Complete host-to-profile migration with interactive dialogs
- **Core Functions**: 
  - `do_backup()` - Handles profile-based backup operations with storage detection and verbose support
  - `do_restore()` - Handles profile-based restore operations with verbose support  
  - `manage_profiles()` - Profile management (list, show, remove, edit profiles)
  - `edit_profile()` - Safe profile editing with diff-based package management
  - `list_backups()` - Lists available backups by profile across storage types
  - `do_cleanup()` - Cleanup old backups across all profiles
- **Storage Detection**: `detect_backup_location()` and `detect_all_storages()` - Auto-detect available storage backends
- **Interactive Setup**: Migration dialogs, storage selection, and profile management
- **Helper Functions**: Profile validation, path generation, migration utilities, Brewfile parsing

### Key Design Patterns
- **Profile-Based Architecture**: Each profile (`default`, `work`, `dev`, etc.) maintains independent Brewfiles and metadata
- **Storage Abstraction**: The script detects and works with multiple storage backends transparently
- **Clean CLI Interface**: Concise default output with optional verbose mode for detailed information
- **Safe Profile Editing**: Temporary file editing with diff-based change detection and user confirmation
- **Auto-Migration System**: Seamlessly migrates from legacy host-based to profile-based structure
- **Interactive Migration**: Smart migration dialogs for 1, 2, or 3+ existing host backups
- **Validation & Safety**: Profile name validation, input sanitization, and rollback mechanisms
- **Modular Functions**: Large functions split into focused helpers for better maintainability
- **Metadata Tracking**: JSON metadata files track profile creation, sources, and migration history

### Configuration Management
- Config stored in `~/.config/brew-sync/`
- Last storage preference saved in `last_storage` file
- Profile structure: `backup_dir/profiles/{profile_name}/`
- Migration state tracked in `backup_dir/.migration/migrated`
- Supports both permanent and temporary storage overrides
- Profile metadata in JSON format for extensibility

## Development Notes

- The script is ~3600+ lines of bash with comprehensive error handling
- Profile-based architecture replaces legacy host-based system
- Clean CLI interface with concise output and optional verbose mode
- Safe profile editing system with diff-based change management
- Interactive migration system handles existing user data safely
- Extensive validation and helper functions for maintainability
- Enhanced logging system with emoji-free, color-coded output
- No formal test suite - testing is done manually with `--dry-run` flags
- Install/uninstall scripts handle Homebrew integration
- Version management through GitHub releases with self-update capability
- All operations support preview mode before execution

### Recent Major Changes

#### Profile Editing System (Latest)
- Added intelligent `profile edit` command with diff-based package management
- Implemented temporary file editing to prevent accidental overwrites
- Created interactive change preview with user confirmation
- Built package-by-package install/uninstall system replacing aggressive cleanup
- Added comprehensive Brewfile parsing and comparison functions

#### CLI Interface Improvements (Latest)
- Removed emoji/unicode characters from all output messages
- Implemented clean, professional CLI interface with color-coding only
- Added global `--verbose` flag support across all commands
- Created concise default output with detailed verbose mode
- Enhanced logging system with proper categorization

#### Profile Migration (Previous)
- Completely refactored from host-based to profile-based backup structure
- Added comprehensive migration system with user choice dialogs
- Removed `--host` and `--merged` options in favor of `--profile`
- Enhanced profile management commands (`list`, `show`, `remove`, `edit`)
- Split large migration functions into focused helper functions
- Added robust profile name validation and error handling
- Updated cleanup system to work with profile directories

## Storage Backends Supported
- iCloud Drive (default on macOS)
- Dropbox, Google Drive, OneDrive
- Git repositories
- Local storage (`~/.brew-sync`)
- USB drives (temporary)
- Custom paths

When working with this codebase, focus on the main `brew-sync` script as it contains all core functionality. The project prioritizes user experience with interactive setup, seamless migration, and comprehensive help systems. The recent profile migration represents a major architectural change that maintains backward compatibility through automatic migration.