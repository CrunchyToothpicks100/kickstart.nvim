#!/usr/bin/env bash
set -euo pipefail

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot identify this operating system (/etc/os-release is missing)." >&2
  exit 1
fi

# shellcheck disable=SC1091
. /etc/os-release
if [[ "${ID:-}" != ubuntu ]]; then
  echo "This installer supports Ubuntu; detected '${ID:-unknown}'." >&2
  exit 1
fi

if (( EUID == 0 )); then
  SUDO=()
else
  command -v sudo >/dev/null 2>&1 || {
    echo "Please install sudo or run this script as root." >&2
    exit 1
  }
  SUDO=(sudo)
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TMUX_DIR="$HOME/.tmux"
TPM_DIR="$TMUX_DIR/plugins/tpm"
TMUX_CONF="$HOME/.tmux.conf"
BASHRC="$HOME/.bashrc"

echo "Installing tmux and git with apt..."
"${SUDO[@]}" apt-get update
"${SUDO[@]}" apt-get install -y tmux git

mkdir -p "$TMUX_DIR/logs" "$TMUX_DIR/plugins"

if [[ -e "$TMUX_CONF" ]]; then
  backup="$TMUX_CONF.backup.$(date +%Y%m%d%H%M%S).$$"
  cp -p "$TMUX_CONF" "$backup"
  echo "Backed up existing tmux config to $backup"
fi
install -m 0644 "$SCRIPT_DIR/tmux.conf" "$TMUX_CONF"

if [[ ! -e "$TPM_DIR" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
elif [[ ! -x "$TPM_DIR/tpm" ]]; then
  echo "$TPM_DIR exists but does not look like a TPM installation." >&2
  exit 1
fi

# Install tmux-sensible and tmux-logging listed in ~/.tmux.conf.
"$TPM_DIR/bin/install_plugins"

# Bash Readline otherwise consumes these Alt keys before tmux/Neovim can use them.
if [[ ! -f "$BASHRC" ]]; then
  touch "$BASHRC"
fi
if ! grep -Fq '# BEGIN tmux nvim-tmux-navigation keys' "$BASHRC"; then
  cat >>"$BASHRC" <<'BASHRC_BLOCK'

# BEGIN tmux nvim-tmux-navigation keys
# Leave Alt-h/j/k/l available for nvim-tmux-navigation.
bind -r '"\eh"'
bind -r '"\ej"'
bind -r '"\ek"'
bind -r '"\el"'
# END tmux nvim-tmux-navigation keys
BASHRC_BLOCK
fi

if tmux display-message -p '#S' >/dev/null 2>&1; then
  tmux source-file "$TMUX_CONF"
  echo "Reloaded the tmux config in the running server."
fi

echo "Tmux setup installed. Open a new Bash shell to load the Alt-key bindings."
echo "Neovim pane navigation also needs the nvim-tmux-navigation plugin configured in Neovim."
