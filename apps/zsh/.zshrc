export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$XDG_CONFIG_HOME/zsh/.oh-my-zsh"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/zsh/starship.toml"
export EDITOR="nvim"

ZSH_THEME=""
ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(history gitfast z)

source <(fzf --zsh)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
