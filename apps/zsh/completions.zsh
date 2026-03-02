autoload -U add-zsh-hook

load-nvm() {
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" &>/dev/null
  add-zsh-hook -d precmd load-nvm
}

load-bun() {
  export BUN_INSTALL="$HOME/.bun"
  [[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun" &>/dev/null
}

load-ngrok() {
  if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)" &>/dev/null
  fi
}

add-zsh-hook precmd load-nvm
add-zsh-hook precmd load-bun
add-zsh-hook precmd load-ngrok
