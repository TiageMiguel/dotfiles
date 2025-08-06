#!/bin/zsh

if ! command -v brew &> /dev/null; then
    echo "[Dotfiles (Tiage)] Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[Dotfiles (Tiage)] Homebrew is already installed. Updating..."
    brew update
fi

echo "[Dotfiles (Tiage)] Running brew bundle..."
brew bundle --file=../Brewfile

echo "[Dotfiles (Tiage)] Running brew cleanup..."
brew cleanup

echo "[Dotfiles (Tiage)] Setup complete!"
