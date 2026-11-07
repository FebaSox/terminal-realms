# realm.zsh: terminal-realms for zsh. Source it from ~/.zshrc (the installer does this for you).
#   wizseb              show this window's realm and the ones you can pick
#   wizseb <name>       switch this window to a realm (also the default for new windows)
#   wizseb open         open this window's realm in Zellij (a fresh session every time)
#   wizseb join         join that session from a second window, to show another tab side by side
#   wizseb close        end this window's Zellij session
#   wizseb pin|unpin    pin the realm screen to the top of the terminal, or let it scroll away
#   wizseb flare        preview the flare
# Each terminal window keeps its own realm. Settings live in ~/.config/terminal-realms/settings.zsh.
REALM_HOME="${REALM_HOME:-$HOME/.config/terminal-realms}"
[[ -f $REALM_HOME/settings.zsh ]] && source "$REALM_HOME/settings.zsh"
_realm_default() { cat "$REALM_HOME/current" 2>/dev/null || echo "${REALM_DEFAULT:-bonfire}"; }
export REALM="${REALM:-$(_realm_default)}"
[[ -d $REALM_HOME/realms/$REALM ]] || export REALM=bonfire
REALM_DIR="$REALM_HOME/realms/$REALM"

# per-window colors through terminal escape codes (Ghostty, kitty, WezTerm, iTerm2 and most others)
_realm_colors() {
  [[ -n $ZELLIJ || ! -t 1 || ${REALM_COLORS:-1} == 0 ]] && return 0
  local s line
  s=$(sed -nE \
      -e 's/^background *= *#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/11;rgb:\1\/\2\/\3/p' \
      -e 's/^foreground *= *#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/10;rgb:\1\/\2\/\3/p' \
      -e 's/^cursor-color *= *#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/12;rgb:\1\/\2\/\3/p' \
      -e 's/^palette *= *([0-9]+)=#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/4;\1;rgb:\2\/\3\/\4/p' \
      "$REALM_DIR/colors.conf" 2>/dev/null)
  for line in ${(f)s}; do printf '\033]%s\a' "$line"; done
}
_realm_colors

# realm environment, like ls / eza colors (REALM_LS=0 keeps your own)
[[ ${REALM_LS:-1} != 0 && -f $REALM_DIR/env.zsh ]] && source "$REALM_DIR/env.zsh"

# ls with icons, if eza is installed (REALM_EZA=0 keeps your own ls)
if [[ ${REALM_EZA:-1} != 0 ]] && command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first --git'
  alias la='eza -la --icons --group-directories-first --git'
  alias lt='eza --tree --level=2 --icons'
fi

# prompt: the realm's oh-my-posh theme, if oh-my-posh is installed (REALM_PROMPT=0 keeps your own prompt)
if [[ ${REALM_PROMPT:-1} != 0 && -f $REALM_DIR/prompt.omp.json ]] && command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config "$REALM_DIR/prompt.omp.json")"
fi

# the pinned realm screen (REALM_QUIET=1 skips it, the Zellij layouts use that for small panes)
if [[ -z $REALM_QUIET && -o interactive && -x $REALM_DIR/screen.sh ]]; then
  REALM_SCREEN="$REALM_DIR/screen.sh"
  "$REALM_SCREEN"
  source "$REALM_HOME/shell/pin.zsh"
fi

# a word from the wizard, once a day (REALM_GREETING=0 turns it off)
if [[ ${REALM_GREETING:-1} != 0 && -z $REALM_QUIET && -o interactive ]]; then
  () {
    local stamp="$REALM_HOME/.cache/greeted" today=$(date +%F)
    [[ $(cat "$stamp" 2>/dev/null) == $today ]] && return
    mkdir -p "$REALM_HOME/.cache"; print -r -- "$today" > "$stamp"
    local -a lines=( "WizSeb says hello." "The wizard is watching." "WizSeb kindled this fire. Keep it lit."
                     "A wizard passed through here. WizSeb, probably." "WizSeb left the lantern on for you." )
    local c='38;5;208'; [[ $REALM == frost ]] && c='38;5;153'
    printf '  \033[2;%sm~ %s ~\033[0m\n' "$c" "${lines[RANDOM % ${#lines} + 1]}"
  }
fi

_realm_zellij_config() {   # your Zellij config with the realm's theme switched in
  local out="$REALM_HOME/.cache/zellij-$REALM.kdl" base="$HOME/.config/zellij/config.kdl"
  mkdir -p "$REALM_HOME/.cache"
  { [[ -f $base ]] && grep -vE '^[[:space:]]*(theme|theme_dir)[[:space:]]' "$base"
    print -r -- "theme_dir \"$REALM_HOME/zellij-themes\""
    print -r -- "theme \"realm-$REALM\""; } > "$out"
  print -r -- "$out"
}

wizseb() {
  case "$1" in
    "")
      echo "This window: $REALM   (new windows: $(_realm_default))"
      echo "Realms: $(command ls -1 "$REALM_HOME/realms" | tr '\n' ' ')"
      echo "Commands: wizseb <name> | open | join | close | pin | unpin | flare"
      ;;
    open)
      if [[ -n $ZELLIJ ]]; then echo "Already inside Zellij. Leave it first (Ctrl+q)."; return 1; fi
      command -v zellij >/dev/null || { echo "Zellij is not installed (brew install zellij)."; return 1; }
      local cfg i; cfg=$(_realm_zellij_config)
      for i in {1..30}; do
        zellij delete-session "realm-$REALM" --force >/dev/null 2>&1
        zellij list-sessions --no-formatting 2>/dev/null | grep -qE "^realm-$REALM( |\$)" || break
        sleep 0.2
      done
      REALM_HOME="$REALM_HOME" zellij --config "$cfg" --new-session-with-layout "$REALM_DIR/layout.kdl" --session "realm-$REALM"
      ;;
    join)  zellij attach "realm-$REALM" ;;
    close) zellij delete-session "realm-$REALM" --force >/dev/null 2>&1; return 0 ;;
    pin)   (( $+functions[_realm_pin] )) && _realm_pin ;;
    unpin) (( $+functions[_realm_unpin] )) && _realm_unpin ;;
    flare) (( $+functions[_realm_flare] )) && _realm_flare ;;
    *)
      if [[ ! -d $REALM_HOME/realms/$1 ]]; then echo "No realm called '$1'. Type: wizseb"; return 1; fi
      print -r -- "$1" > "$REALM_HOME/current"
      (( $+functions[_realm_stop] )) && _realm_stop
      printf '\033[r'
      [[ -f $REALM_HOME/realms/$1/colors.conf ]] || printf '\033]104\a\033]110\a\033]111\a\033]112\a'
      export REALM="$1" REALM_QUOTE=""
      exec zsh
      ;;
  esac
}
