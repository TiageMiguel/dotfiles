#!/bin/zsh

set -euo pipefail

ROOT_DIR="${${0:A:h}:h}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

link_path() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "(.dotfiles) skip (missing source): $src"
    return 0
  fi

  mkdir -p "${dest:h}"

  if [[ -L "$dest" ]]; then
    local current
    current="$(readlink "$dest")"
    if [[ "$current" == "$src" ]]; then
      echo "(.dotfiles) ok: $dest -> $src"
      return 0
    fi
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.bak.${TIMESTAMP}"
    mv "$dest" "$backup"
    echo "(.dotfiles) backed up: $dest -> $backup"
  fi

  ln -sfn "$src" "$dest"
  echo "(.dotfiles) linked: $dest -> $src"
}

echo "(.dotfiles) Linking configs from $ROOT_DIR..."

# Ghostty (directory: config + themes)
link_path "$ROOT_DIR/apps/ghostty" "$HOME/.config/ghostty"

# Zsh
link_path "$ROOT_DIR/apps/zsh/.zshrc" "$HOME/.zshrc"
for file in "$ROOT_DIR"/apps/zsh/*.zsh(N); do
  link_path "$file" "$HOME/.config/zsh/${file:t}"
done

# Starship (matches STARSHIP_CONFIG in .zshrc)
link_path "$ROOT_DIR/apps/starship/starship.toml" "$HOME/.config/zsh/starship.toml"

# Cursor (also linked into VS Code)
link_path "$ROOT_DIR/apps/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
link_path "$ROOT_DIR/apps/cursor/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

# Rectangle
link_path "$ROOT_DIR/apps/rectangle/RectangleConfig.json" "$HOME/Library/Application Support/Rectangle/RectangleConfig.json"

# iTerm2 Dynamic Profile
link_path "$ROOT_DIR/apps/iterm/tiago.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/tiago.json"

# Zed theme
link_path "$ROOT_DIR/apps/themes/custom-theme.json" "$HOME/.config/zed/themes/custom-theme.json"

echo "(.dotfiles) Linking complete!"
