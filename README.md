# Tiage's Dotfiles

Personal dotfiles and system configuration files.

## Overview

This repository contains the configuration files, installation scripts, and application settings necessary to provision and maintain a consistent development environment.

### Structure

- `apps/`
  - `Brewfile` - Homebrew bundle manifest for packages, casks, and fonts.
  - `zsh/` - Zsh configuration files (`.zshrc`, aliases, completions, exports, plugins).
  - `starship/` - Starship prompt configuration (`starship.toml`).
  - Terminal & Editor Configs - `ghostty`, `iterm`, `zed`, `cursor` (also linked into VS Code).
  - Tools - `rectangle` window manager configuration.
- `scripts/` - Individual script files (e.g., `homebrew.zsh` for setting up brew and running the bundle, `link.zsh` for symlinking configs).
- `install.zsh` - The main executable script to bootstrap the system.

## Installation

### 1. Bootstrap Setup
Run the main install script. This will make all scripts executable, run the Homebrew setup (installing brew if missing, updating, and installing packages from the `Brewfile`), and symlink application configs to their runtime paths.

```bash
zsh ./install.zsh
```

### 2. Link configs only

To (re)link configs without running Homebrew:

```bash
zsh ./scripts/link.zsh
```

Existing files at a destination are moved to `*.bak.<timestamp>` before linking. Already-correct symlinks are left alone.

| Repo path | Destination |
|-----------|-------------|
| `apps/ghostty/` | `~/.config/ghostty` |
| `apps/zsh/.zshrc` | `~/.zshrc` |
| `apps/zsh/*.zsh` | `~/.config/zsh/*.zsh` |
| `apps/starship/starship.toml` | `~/.config/zsh/starship.toml` |
| `apps/cursor/settings.json` | `~/Library/Application Support/Cursor/User/settings.json` |
| `apps/cursor/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `apps/rectangle/RectangleConfig.json` | `~/Library/Application Support/Rectangle/RectangleConfig.json` |
| `apps/iterm/tiago.json` | `~/Library/Application Support/iTerm2/DynamicProfiles/tiago.json` |
| `apps/themes/custom-theme.json` | `~/.config/zed/themes/custom-theme.json` |
