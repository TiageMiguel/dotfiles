# Tiage's Dotfiles

Personal dotfiles and system configuration files.

## Overview

This repository contains the configuration files, installation scripts, and application settings necessary to provision and maintain a consistent development environment.

### Structure

- `apps/`
  - `Brewfile` - Homebrew bundle manifest for packages, casks, and fonts.
  - `zsh/` - Zsh configuration files (`.zshrc`, aliases, completions, exports, plugins).
  - `starship/` - Starship prompt configuration (`starship.toml`).
  - Terminal & Editor Configs - `ghostty`, `iterm`, `zed`, `vscode`.
  - Tools - `rectangle` window manager configuration.
- `scripts/` - Individual script files (e.g., `homebrew.zsh` for setting up brew and running the bundle).
- `install.zsh` - The main executable script to bootstrap the system.

## Installation

### 1. Bootstrap Setup
Run the main install script. This will make all scripts executable and run the Homebrew setup (installing brew if missing, updating, and installing packages from the `Brewfile`).

```bash
zsh ./install.zsh
```

### 2. Manual Configuration Linkage

After the bootstrap script installs the required packages, you need to link the application configurations to their target directories.

Copy or symlink the files to your home and config directories:

**Zsh & Starship Setup:**
```bash
# Zsh root configuration
cp apps/zsh/.zshrc ~/.zshrc

# Zsh component files
mkdir -p ~/.config/zsh
rsync -a --exclude='.zshrc' apps/zsh/ ~/.config/zsh/

# Starship prompt configuration
cp apps/starship/starship.toml ~/.config/zsh/starship.toml
```

**Application Configs Setup:**
```bash
# Copy terminal, editor, and tools settings
cp -R apps/ghostty ~/.config/ghostty
cp -R apps/rectangle ~/.config/
cp -R apps/zed ~/.config/
cp -R apps/iterm ~/.config/
cp -R apps/vscode ~/.config/
```

> **Note:** For easier future maintenance, consider using `ln -s` (symbolic links) instead of `cp` so that changes made in `~/.config/` are automatically reflected in this repository.
