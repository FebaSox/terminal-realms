#!/usr/bin/env bash
# Removes terminal-realms. Your settings.zsh is kept unless you pass --all.
DEST="${REALM_HOME:-$HOME/.config/terminal-realms}"
ZRC="${ZDOTDIR:-$HOME}/.zshrc"
if [ -f "$ZRC" ]; then
  cp "$ZRC" "$ZRC.before-uninstall"
  grep -v -e '^# terminal-realms$' -e 'terminal-realms.*/shell/realm.zsh' "$ZRC.before-uninstall" > "$ZRC"
fi
rm -f "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugin/terminal-realms.lua"
if [ "$1" = "--all" ]; then rm -rf "$DEST"; else
  for d in shell panes realms nvim zellij-themes .cache current settings.zsh.example; do rm -rf "${DEST:?}/$d"; done
fi
rm -rf "$HOME/.cache/terminal-realms"
# put back configs that --full --replace swapped out
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
for c in ghostty/config zellij/config.kdl nvim; do
  if [ -e "$CFG/$c.before-realms" ]; then rm -rf "${CFG:?}/$c"; mv "$CFG/$c.before-realms" "$CFG/$c"; echo "restored your old $c"; fi
done
echo "terminal-realms removed. Open a new terminal."
