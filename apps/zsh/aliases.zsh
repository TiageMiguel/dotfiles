alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -al --color"
alias la="ls -al"
alias vim="nvim"
alias c="clear"
alias code="$EDITOR"

btop() {
  local theme="tiage-dark"
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" != "Dark" ]]; then
    theme="tiage-light"
  fi
  local conf="${XDG_CONFIG_HOME:-$HOME/.config}/btop/btop.conf"
  if [[ -f "$conf" ]]; then
    sed -i '' \
      -e "s/^color_theme = .*/color_theme = \"${theme}\"/" \
      -e 's/^theme_background = .*/theme_background = false/' \
      "$conf"
  fi
  command btop "$@"
}

# Aliases for DDEV
alias ds="ddev start && ddev ssh"
alias dsr="ddev restart"
alias dss="ddev ssh"
alias ds!="ddev stop"
alias dsp="ddev poweroff"

# Aliases for ZSH/OMZ
alias config_zsh="$EDITOR ~/.zshrc"
alias config_dot="$EDITOR ~/.config"
alias config_starship="$EDITOR ~/.config/starship.toml"
