# pin.zsh: keeps the active realm's screen pinned at the top of the terminal, animates it for a while
# after every Enter, and pauses it while a command runs (full-screen apps like nvim are never painted over).
# Sourced by realm.zsh with REALM_SCREEN pointing at the realm's screen.sh.
#   REALM_SECONDS=25 (default)   inf = animate forever   0 = never animate
#   REALM_FLARE_AFTER=10   a command that runs this long makes the scene flare and rings the bell once
#   REALM_FLARE=0 never flare   REALM_BELL=0 flare without the bell
#   REALM_FLARE_SKIP="..."  programs you sit in on purpose, they never flare
#   REALM_DIED=0  turn off the failed-command effect (YOU DIED in the bonfire realm)
#   REALM_DIED_SKIP="..."  commands whose exit code 1 is normal (grep finding nothing, diff ...)

_realm_dir="$HOME/.cache/terminal-realms"
mkdir -p "$_realm_dir" 2>/dev/null
read -r _realm_h _realm_w <<< "$(bash "$REALM_SCREEN" height 2>/dev/null)"
: "${_realm_h:=19}" "${_realm_w:=62}"
: "${REALM_SECONDS:=25}"
: "${REALM_FLARE:=1}" "${REALM_BELL:=1}" "${REALM_FLARE_AFTER:=10}"
: "${REALM_FLARE_SKIP:=nvim vim vi less man more htop top btop ssh tmux zellij fzf lazygit watch tail}"
: "${REALM_DIED:=1}" "${REALM_DIED_SKIP:=grep egrep fgrep rg diff cmp test [ [[ which command type git fzf}"
if [[ -z ${REALM_QUOTE:-} ]]; then
  REALM_QUOTE="$(REALM_SHELL=$$ bash "$REALM_SCREEN" quote 2>/dev/null)"
fi
export REALM_QUOTE
_realm_t0=""; _realm_cmd=""
_realm_pinned=${REALM_PIN:-1}

_realm_ok() { [[ $_realm_pinned == 1 ]] && (( LINES >= _realm_h + 6 && COLUMNS >= _realm_w )); }

_realm_stop() {
  local f="$_realm_dir/anim-$$.pid" p i=0
  [[ -r $f ]] || return 0
  p=$(<"$f")
  if [[ -n $p ]]; then
    kill "$p" 2>/dev/null
    while kill -0 "$p" 2>/dev/null && (( i++ < 30 )); do sleep 0.01; done
  fi
  rm -f "$f"
}

_realm_start() {
  _realm_ok || return 0
  _realm_stop
  [[ $REALM_SECONDS == 0 ]] && return 0
  local fl=0 dd=0
  [[ $1 == flare && $REALM_FLARE != 0 ]] && fl=1
  [[ $1 == died  && $REALM_DIED  != 0 ]] && dd=1
  ( REALM_FLARE=$fl REALM_DIED=$dd REALM_SHELL=$$ bash "$REALM_SCREEN" anim "$REALM_SECONDS" </dev/null >/dev/null 2>&1 & echo $! > "$_realm_dir/anim-$$.pid" )
}

_realm_failed=0
_realm_check_fail() {
  local rc=$1
  _realm_failed=0
  [[ $REALM_DIED == 0 || -z $_realm_cmd || $rc -eq 0 || $rc -eq 130 ]] && return 0
  if (( rc == 1 )); then case " $REALM_DIED_SKIP " in *" $_realm_cmd "*) return 0;; esac; fi
  _realm_failed=1
}

_realm_long=0
_realm_timer() {
  _realm_long=0
  [[ -n $_realm_t0 ]] || return 0
  local now=${EPOCHREALTIME:-}
  [[ -n $now ]] || now=$(date +%s)
  local el
  el=$(awk -v a="$now" -v b="$_realm_t0" 'BEGIN { printf "%.3f", a - b }')
  _realm_t0=""
  awk -v e="$el" -v n="$REALM_FLARE_AFTER" 'BEGIN { exit !(e >= n) }' || return 0
  case " $REALM_FLARE_SKIP " in *" $_realm_cmd "*) return 0;; esac
  _realm_long=1
}

_realm_precmd() {
  local rc=$?                      # the finished command's exit code: must be the first line here
  _realm_timer
  _realm_check_fail $rc
  _realm_cmd=""
  _realm_ok || return 0
  printf '\0337\033[%d;%dr\0338' $((_realm_h + 1)) "$LINES"
  if (( _realm_failed )); then
    _realm_start died
    (( _realm_long )) && [[ $REALM_BELL != 0 ]] && printf '\a'
  elif (( _realm_long )); then
    _realm_start flare
    [[ $REALM_BELL != 0 && $REALM_FLARE != 0 ]] && printf '\a'
  else
    _realm_start
  fi
}
_realm_preexec() {
  _realm_stop
  _realm_t0=${EPOCHREALTIME:-$(date +%s)}
  local c=${1%% *}; _realm_cmd=${c##*/}
}

_realm_clear() { printf '\033[%d;1H\033[J' $((_realm_h + 1)); }
clear() { if _realm_ok; then _realm_clear; else command clear; fi; }

_realm_resize() {
  _realm_stop
  if _realm_ok; then bash "$REALM_SCREEN" resize </dev/null >/dev/null 2>&1; _realm_start
  else printf '\033[r'; fi
}
_realm_unpin() {
  _realm_stop; _realm_pinned=0; printf '\033[r'
  echo "Unpinned: scrollback works normally. Type 'wizseb pin' to pin the screen again."
}
_realm_pin() { _realm_pinned=1; REALM_PIN=1 bash "$REALM_SCREEN"; _realm_start; }
_realm_flare() { _realm_start flare; [[ $REALM_BELL != 0 ]] && printf '\a'; return 0; }
_realm_exit() { _realm_stop; printf '\033[r'; }

zmodload zsh/datetime 2>/dev/null
autoload -Uz add-zsh-hook
add-zsh-hook precmd  _realm_precmd
add-zsh-hook preexec _realm_preexec
add-zsh-hook zshexit _realm_exit
TRAPWINCH() { _realm_resize; }
_realm_widget() { if _realm_ok; then _realm_clear; zle -I; zle reset-prompt; else zle .clear-screen; fi; }
zle -N clear-screen _realm_widget
