#!/bin/zsh

echo "(.dotfiles) Making all scripts executable..."
find ./scripts -type f \( -name "*.zsh" -o -name "*.sh" \) -exec chmod +x {} \;

echo "(.dotfiles) Running homebrew script..."
zsh ./scripts/homebrew.zsh

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"