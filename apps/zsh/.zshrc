export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_PREFIX="/opt/homebrew"
export ZSH="$XDG_CONFIG_HOME/zsh/.oh-my-zsh"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"
export EDITOR="nvim"

ZSH_THEME=""
ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"
ZSH_DISABLE_COMPFIX=true

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# `z` is redundant with zoxide. gitfast is the cheap git aliases/completion.
plugins=(gitfast)

source $ZSH/oh-my-zsh.sh

source "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
source <(fzf --zsh)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
