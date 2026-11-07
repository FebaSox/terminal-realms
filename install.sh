#!/usr/bin/env bash
# terminal-realms installer by WizSeb. Safe to run again to update.
#   ./install.sh                  themes only (you bring your own tools and configs)
#   ./install.sh --full           the whole setup: tools, font, Ghostty, Zellij and Neovim configs
#   ./install.sh --full --replace also swap out configs you already have (the old ones are kept as *.before-realms)
#   ./install.sh --no-nvim        skip the Neovim parts
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${REALM_HOME:-$HOME/.config/terminal-realms}"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
FULL=0 REPLACE=0 NVIM=1
for a in "$@"; do case $a in --full) FULL=1;; --replace) REPLACE=1;; --no-nvim) NVIM=0;; esac; done

say()  { printf '\033[38;5;208m~\033[0m %s\n' "$*"; }
warn() { printf '\033[38;5;153m!\033[0m %s\n' "$*"; }

printf '\n\033[1;38;5;208m  terminal-realms\033[0;2m  by WizSeb\033[0m\n\n'

# 1. tools (full only)
if [ $FULL = 1 ]; then
  if [ "$(uname)" = Darwin ]; then
    if ! command -v brew >/dev/null; then
      say "installing Homebrew (it will ask for your Mac password)"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
      [ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"
    fi
    say "installing tools and the Nerd Font (a few minutes the first time)"
    brew bundle --file "$SRC/kit/Brewfile" || warn "some tools didn't install, see above. Everything else still works."
  elif command -v brew >/dev/null; then
    grep -v '^cask' "$SRC/kit/Brewfile" > /tmp/realms.Brewfile
    brew bundle --file /tmp/realms.Brewfile || true
    warn "on Linux, install Ghostty and the JetBrainsMono Nerd Font yourself"
  else
    warn "no Homebrew found. Install these with your package manager: zsh perl zellij neovim eza oh-my-posh btop git ripgrep fd"
  fi
fi

command -v zsh  >/dev/null || { echo "terminal-realms needs zsh."; exit 1; }
command -v perl >/dev/null || { echo "terminal-realms needs perl."; exit 1; }

# 2. the realms
mkdir -p "$DEST"
for d in shell panes realms nvim zellij-themes; do
  rm -rf "${DEST:?}/$d"; cp -R "$SRC/$d" "$DEST/$d"
done
cp "$SRC/settings.zsh.example" "$DEST/"
[ -f "$DEST/settings.zsh" ] || cp "$SRC/settings.zsh.example" "$DEST/settings.zsh"
[ -f "$DEST/current" ] || echo bonfire > "$DEST/current"
chmod +x "$DEST"/panes/* "$DEST"/realms/*/screen.sh "$DEST"/realms/*/emberscreen "$DEST"/realms/*/frostfall "$DEST"/shell/stats.sh 2>/dev/null || true
say "realms copied to $DEST"

ZRC="${ZDOTDIR:-$HOME}/.zshrc"
if ! grep -q 'terminal-realms.*/shell/realm.zsh' "$ZRC" 2>/dev/null; then
  { echo ''; echo '# terminal-realms'; echo '[[ -f ${REALM_HOME:-$HOME/.config/terminal-realms}/shell/realm.zsh ]] && source ${REALM_HOME:-$HOME/.config/terminal-realms}/shell/realm.zsh'; } >> "$ZRC"
  say "added one line to $ZRC"
fi

# 3. starter configs (full only). Never overwrites unless --replace, and then keeps a copy.
put() {  # put <from> <to> <name>
  if [ -e "$2" ] && grep -rqs "starter config from terminal-realms" "$2"; then
    rm -rf "$2"; mkdir -p "$(dirname "$2")"; cp -R "$1" "$2"; say "$3 updated"; return
  fi
  if [ -e "$2" ] && [ $REPLACE = 0 ]; then
    warn "kept your own $3 ($2). Use --full --replace to swap in the terminal-realms one."
    return
  fi
  if [ -e "$2" ]; then rm -rf "$2.before-realms"; mv "$2" "$2.before-realms"; say "your old $3 is saved as $2.before-realms"; fi
  mkdir -p "$(dirname "$2")"; cp -R "$1" "$2"; say "$3 set up"
}
if [ $FULL = 1 ]; then
  if [ "$(uname)" = Darwin ] && [ -f "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ] && [ ! -e "$CFG/ghostty/config" ] && [ $REPLACE = 0 ]; then
    warn "kept your own Ghostty config (in Application Support)"
  else
    put "$SRC/kit/ghostty/config" "$CFG/ghostty/config" "Ghostty config"
  fi
  put "$SRC/kit/zellij/config.kdl" "$CFG/zellij/config.kdl" "Zellij config"
  [ $NVIM = 1 ] && put "$SRC/kit/nvim" "$CFG/nvim" "Neovim config"
fi

# 4. Neovim colors for any config
if [ $NVIM = 1 ] && { command -v nvim >/dev/null || [ -d "$CFG/nvim" ]; }; then
  mkdir -p "$CFG/nvim/plugin"
  cp "$SRC/nvim/plugin/terminal-realms.lua" "$CFG/nvim/plugin/terminal-realms.lua"
  say "Neovim realm colors on"
fi

echo
if [ $FULL = 0 ]; then
  missing=""
  for t in zellij nvim eza oh-my-posh; do command -v $t >/dev/null || missing="$missing $t"; done
  [ -n "$missing" ] && say "not installed:$missing. Run ./install.sh --full to get everything."
fi
say "done. Quit and reopen your terminal (Ghostty), then type: wizseb"
