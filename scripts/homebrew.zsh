#!/bin/zsh

if ! command -v brew &> /dev/null; then
    echo "(.dotfiles) Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "(.dotfiles) Homebrew already installed. Updating..."
    brew update
fi

echo "(.dotfiles) Running brew bundle..."
brew bundle --file=./Brewfile

echo "(.dotfiles) Running brew cleanup..."
brew cleanup

echo "(.dotfiles) Setup complete!"
