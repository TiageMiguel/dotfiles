#!/bin/zsh

echo "[Dotfiles (Tiage)] Making all scripts executable..."
find ./scripts -type f \( -name "*.zsh" -o -name "*.sh" \) -exec chmod +x {} \;

echo "[Dotfiles (Tiage)] Running homebrew script..."
zsh ./scripts/homebrew.zsh
