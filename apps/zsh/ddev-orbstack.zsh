# ddev validates the Docker connection before anything else and aborts when the
# daemon is down, so there is no pre-start hook left to attach to. This wrapper
# brings OrbStack up first, then hands the command over -- and takes it back
# down after a poweroff, which is the one ddev command that releases everything.

_ddev_sock="$HOME/.orbstack/run/docker.sock"

ddev() {
  # Subcommands that never talk to the daemon: no reason to wake OrbStack.
  case "$1" in
    ""|-v|--version|-h|--help|help|version|config|completion)
      command ddev "$@"
      return
      ;;
  esac

  # No OrbStack on this machine: let ddev report its own error instead of
  # stalling for 30s on a start that cannot happen.
  if ! command -v orbctl >/dev/null 2>&1; then
    command ddev "$@"
    return
  fi

  # Powering off a daemon that is already down: nothing to start, nothing to do.
  if [[ "$1" == poweroff && ! -S "$_ddev_sock" ]]; then
    print -u2 -P "%F{green}==>%f OrbStack is already stopped."
    return 0
  fi

  # Fast path: the socket only exists while OrbStack runs, and testing it is free.
  if [[ ! -S "$_ddev_sock" ]]; then
    print -u2 -P "%F{yellow}==>%f OrbStack is down, starting it..."
    orbctl start >/dev/null 2>&1

    # The socket shows up before the API answers, so wait on the API instead.
    local i
    for ((i = 1; i <= 30; i++)); do
      docker info >/dev/null 2>&1 && break
      sleep 1
    done

    if ! docker info >/dev/null 2>&1; then
      print -u2 -P "%F{red}==>%f OrbStack did not respond within 30s. Open the app and retry."
      return 1
    fi
    print -u2 -P "%F{green}==>%f OrbStack ready."
  fi

  command ddev "$@"
  local ret=$?

  # poweroff stops every ddev container, so the daemon has nothing left to do --
  # unless something outside ddev is still using it, which is not ours to kill.
  if [[ "$1" == poweroff && $ret -eq 0 ]]; then
    local others
    others=$(docker ps -q 2>/dev/null | grep -c .)
    if [[ "$others" -eq 0 ]]; then
      print -u2 -P "%F{yellow}==>%f Stopping OrbStack..."
      if orbctl stop >/dev/null 2>&1; then
        # orbctl stop only takes the engine down; the UI process lingers at
        # ~130MB. Quitting the app too is safe -- orbctl start wakes it from
        # a fully closed state.
        osascript -e 'quit app "OrbStack"' >/dev/null 2>&1
        print -u2 -P "%F{green}==>%f OrbStack stopped."
      else
        print -u2 -P "%F{red}==>%f Could not stop OrbStack."
      fi
    else
      print -u2 -P "%F{yellow}==>%f OrbStack left running: ${others} non-ddev container(s) still up."
    fi
  fi

  return $ret
}
