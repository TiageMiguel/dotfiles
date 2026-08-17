#!/bin/zsh

set -euo pipefail

ROOT_DIR="${${0:A:h}:h}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

# Copy repo config into place. Replaces existing symlinks (from older installs)
# with real files/dirs. Rectangle refuses symlinks; copying keeps one code path.
copy_path() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "(.dotfiles) skip (missing source): $src"
    return 0
  fi

  mkdir -p "${dest:h}"

  if [[ -L "$dest" ]]; then
    local backup="${dest}.bak.${TIMESTAMP}"
    mv "$dest" "$backup"
    echo "(.dotfiles) backed up symlink: $dest -> $backup"
  elif [[ -f "$src" && -f "$dest" ]] && cmp -s "$src" "$dest"; then
    echo "(.dotfiles) ok: $dest"
    return 0
  elif [[ -d "$src" && -d "$dest" ]] && ! [[ -L "$dest" ]] && diff -rq "$src" "$dest" >/dev/null 2>&1; then
    echo "(.dotfiles) ok: $dest"
    return 0
  elif [[ -e "$dest" ]]; then
    local backup="${dest}.bak.${TIMESTAMP}"
    mv "$dest" "$backup"
    echo "(.dotfiles) backed up: $dest -> $backup"
  fi

  if [[ -d "$src" ]]; then
    cp -R "$src" "$dest"
  else
    cp "$src" "$dest"
  fi
  echo "(.dotfiles) copied: $src -> $dest"
}

echo "(.dotfiles) Copying configs from $ROOT_DIR..."

# Ghostty (directory: config + themes)
copy_path "$ROOT_DIR/apps/ghostty" "$HOME/.config/ghostty"

# Zsh
copy_path "$ROOT_DIR/apps/zsh/.zshrc" "$HOME/.zshrc"
for file in "$ROOT_DIR"/apps/zsh/*.zsh(N); do
  copy_path "$file" "$HOME/.config/zsh/${file:t}"
done

# Starship (matches STARSHIP_CONFIG in .zshrc)
copy_path "$ROOT_DIR/apps/starship/starship.toml" "$HOME/.config/zsh/starship.toml"

# Cursor (also into VS Code)
copy_path "$ROOT_DIR/apps/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
copy_path "$ROOT_DIR/apps/cursor/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

# Rectangle — imported on launch, then renamed; must be a real file
copy_path "$ROOT_DIR/apps/rectangle/RectangleConfig.json" "$HOME/Library/Application Support/Rectangle/RectangleConfig.json"

# iTerm2 Dynamic Profile
copy_path "$ROOT_DIR/apps/iterm/tiago.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/tiago.json"

# Zed theme
copy_path "$ROOT_DIR/apps/themes/custom-theme.json" "$HOME/.config/zed/themes/custom-theme.json"

# Vicinae themes — dest must stay flat; Vicinae does not search subdirectories
for file in "$ROOT_DIR"/apps/vicinae/themes/cursor/*.toml(N); do
  copy_path "$file" "$HOME/.local/share/vicinae/themes/${file:t}"
done

echo "(.dotfiles) Copying complete!"
