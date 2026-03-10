autoload -U add-zsh-hook

load-nvm() {
  export NVM_DIR="$HOME/.nvm"
  source $(brew --prefix nvm)/nvm.sh
  add-zsh-hook -d precmd load-nvm
}

load-bun() {
  export BUN_INSTALL="$HOME/.bun"
  [[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun" &>/dev/null
  add-zsh-hook -d precmd load-bun
}

add-zsh-hook precmd load-nvm
add-zsh-hook precmd load-bun
