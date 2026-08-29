# nvm.sh is ~0.5s. Homebrew already provides node/npm; load nvm only when
# the `nvm` command is used.
nvm() {
  unset -f nvm
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  local nvm_sh="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/nvm/nvm.sh"
  [[ -s "$nvm_sh" ]] || nvm_sh="$NVM_DIR/nvm.sh"
  source "$nvm_sh"
  nvm "$@"
}
