# Tiage's Dotfiles

Personal dotfiles and system configuration files.

## Overview

This repository contains the configuration files, installation scripts, and application settings necessary to provision and maintain a consistent development environment.

### Structure

- `apps/`
  - `Brewfile` - Homebrew bundle manifest for packages, casks, and fonts.
  - `zsh/` - Zsh configuration files (`.zshrc`, aliases, completions, exports, plugins, and a `ddev` wrapper that starts OrbStack on demand).
  - `starship/` - Starship prompt configuration (`starship.toml`).
  - Terminal & Editor Configs - `ghostty`, `iterm`, `zed`, `cursor` (also copied into VS Code).
  - `vicinae/` - Vicinae settings and launcher themes (`tiage-dark` / `tiage-light`).
  - `btop/` - btop tiage light/dark themes (auto-picked from system appearance).
  - Tools - `rectangle` window manager configuration.
- `scripts/` - Individual script files (e.g., `homebrew.zsh` for setting up brew and running the bundle, `link.zsh` for copying configs into place).
- `install.zsh` - The main executable script to bootstrap the system.

## Installation

### 1. Bootstrap Setup
Run the main install script. This will make all scripts executable, run the Homebrew setup (installing brew if missing, updating, and installing packages from the `Brewfile`), and copy application configs to their runtime paths.

```bash
zsh ./install.zsh
```

### 2. Copy configs only

To (re)copy configs without running Homebrew:

```bash
zsh ./scripts/link.zsh
```

Existing files at a destination are moved to `*.bak.<timestamp>` before copying. Identical files/dirs are left alone. Old symlinks from previous installs are replaced with real copies.

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
| `apps/vicinae/settings.json` | `~/.config/vicinae/settings.json` |
| `apps/vicinae/themes/*.toml` | `~/.local/share/vicinae/themes/*.toml` |
| `apps/btop/themes/*.theme` | `~/.config/btop/themes/*.theme` |

Configs are **copied**, not symlinked. Edit files in this repo, then re-run `link.zsh` to push changes out. Rectangle also requires a real file: on launch it imports `RectangleConfig.json` into its defaults, then renames it.
