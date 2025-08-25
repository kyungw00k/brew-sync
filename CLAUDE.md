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

# Install/uninstall locally for testing
./install.sh
./uninstall.sh
```

The script supports multiple storage backends (iCloud, Dropbox, Google Drive, Git, local) and profiles for different use cases.

## Architecture

### Main Script Structure (`brew-sync`)
- **Configuration**: Lines 8-40 - Version, paths, colors, profile constants, and defaults
- **Migration System**: Lines 68-607 - Complete host-to-profile migration with interactive dialogs
- **Core Functions**: 
  - `do_backup()` - Handles profile-based backup operations with storage detection
  - `do_restore()` - Handles profile-based restore operations
  - `manage_profiles()` - Profile management (list, show, remove profiles)
  - `list_backups()` - Lists available backups by profile across storage types
  - `do_cleanup()` - Cleanup old backups across all profiles
- **Storage Detection**: `detect_backup_location()` and `detect_all_storages()` - Auto-detect available storage backends
- **Interactive Setup**: Migration dialogs, storage selection, and profile management
- **Helper Functions**: Profile validation, path generation, migration utilities

### Key Design Patterns
- **Profile-Based Architecture**: Each profile (`default`, `work`, `dev`, etc.) maintains independent Brewfiles and metadata
- **Storage Abstraction**: The script detects and works with multiple storage backends transparently
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

- The script is ~2700+ lines of bash with comprehensive error handling
- Profile-based architecture replaces legacy host-based system
- Interactive migration system handles existing user data safely
- Extensive validation and helper functions for maintainability
- No formal test suite - testing is done manually with `--dry-run` flags
- Install/uninstall scripts handle Homebrew integration
- Version management through GitHub releases with self-update capability
- All operations support preview mode before execution

### Recent Major Changes (Profile Migration)
- Completely refactored from host-based to profile-based backup structure
- Added comprehensive migration system with user choice dialogs
- Removed `--host` and `--merged` options in favor of `--profile`
- Enhanced profile management commands (`list`, `show`, `remove`)
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