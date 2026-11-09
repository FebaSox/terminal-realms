#!/bin/bash
# screen.sh: the frost theme's terminal screen. A snowy cabin under the aurora, with a Lodge stats box,
# pinned to the top of the terminal like the bonfire. Same commands as render.sh, used by screen.zsh:
#   screen.sh            draw the pinned screen       screen.sh anim [N]   animate for N seconds
#   screen.sh resize     repaint after a resize        screen.sh height     print "<rows> <min cols>"
#   screen.sh quote      print this shell's quote
ESC=$'\033'; RST="${ESC}[0m"
D="$(cd "$(dirname "$0")" && pwd)"; TR="$(cd "$D/../.." && pwd)"
MODE_ARG=${1:-init}; SECS_ARG=${2:-}
SH=11                       # scene rows
INNER=58; BOXW=$((INNER + 2))
H=$((SH + 8))               # scene + box (title, 3 stat rows, bars, quote, bottom) + 1 gap
if [ "$MODE_ARG" = height ]; then echo "$H $((BOXW + 2))"; exit 0; fi

C_BORDER="${ESC}[38;2;84;104;138m"; C_TITLE="${ESC}[1;38;2;156;196;240m"; C_KEY="${ESC}[38;2;143;176;232m"
C_SEP="${ESC}[38;2;111;200;208m"; C_VAL="${ESC}[38;2;200;211;230m"; C_QUOTE="${ESC}[3;38;2;127;156;200m"
C_AMB="${ESC}[38;2;240;180;90m"; C_ICE="${ESC}[38;2;156;196;240m"; C_EMPTY="${ESC}[38;2;34;44;64m"

QUOTES=(
  "Keep the lantern lit." "The snow remembers every step." "Warm hands, steady code."
  "Follow the aurora home." "Rest by the fire, then press on." "Every storm runs out of snow."
  "Quiet woods, clear mind." "One more log on the fire." "The north wind favors the patient."
  "Lanterns guide the lost."
)
SHELLPID=${REALM_SHELL:-$PPID}
QUOTE="${QUOTES[$(( SHELLPID % ${#QUOTES[@]} ))]}"
if [ "$MODE_ARG" = quote ]; then printf '%s\n' "$QUOTE"; exit 0; fi
CACHE="$HOME/.cache/terminal-realms"; mkdir -p "$CACHE" 2>/dev/null
PIDFILE="$CACHE/anim-$SHELLPID.pid"
[ "$MODE_ARG" = anim ] && echo $$ > "$PIDFILE"

# ---- live stats (macchina if installed, otherwise read from the system) ----
UP="n/a"; CPU="n/a"; MEM="n/a"; BATPCT=-1
while IFS='=' read -r k v; do
    case "$k" in Uptime) UP="$v";; CPU) CPU="$v";; Memory) MEM="$v";; Battery) [ -n "$v" ] && BATPCT="$v";; esac
done < <(bash "$TR/shell/stats.sh" 2>/dev/null)
[ ${#CPU} -gt 16 ] && CPU=${CPU% (*}
if [ "$(uname)" = Darwin ]; then OS="macOS $(sw_vers -productVersion 2>/dev/null)"; else OS="$( . /etc/os-release 2>/dev/null; echo "${NAME:-Linux}")"; fi
MEMPCT=-1
set -- $MEM
if [ -n "$1" ] && [ -n "$4" ]; then MEMPCT=$(awk -v u="$1" -v t="$4" 'BEGIN { if (t > 0) printf "%d", 100 - (u / t) * 100 }'); fi
SNOW=$(df -h / 2>/dev/null | awk 'NR == 2 { print $4 " free" }'); [ -z "$SNOW" ] && SNOW="n/a"

BARW=13
bar() {
    local pct=$1 color=$2 f e fs es
    if [ "$pct" -lt 0 ] 2>/dev/null; then printf '%s%-*s' "$C_EMPTY" $((BARW + 5)) "n/a"; return; fi
    f=$(( pct * BARW / 100 )); e=$(( BARW - f ))
    printf -v fs '%*s' "$f" ''; printf -v es '%*s' "$e" ''
    printf '%s%s%s%s %s%3d%%' "$color" "${fs// /█}" "$C_EMPTY" "${es// /░}" "$C_VAL" "$pct"
}
dashes() { local s; printf -v s '%*s' "$1" ''; printf '%s' "${s// /─}"; }
spaces() { printf '%*s' "$1" ''; }
cell() { printf '%s%-9s%s› %s%-16.16s%s' "$C_KEY" "$1" "$C_SEP" "$C_VAL" "$2" "$RST"; }
barcell() { printf '%s%8s %s%s' "$C_KEY" "$1" "$(bar "$2" "$3")" "$RST"; }

read -r ROWS COLS < <(stty size </dev/tty 2>/dev/null)
if [ -z "$COLS" ]; then COLS=$(tput cols 2>/dev/null || echo 80); ROWS=$(tput lines 2>/dev/null || echo 0); fi
MB=$(( (COLS - BOXW) / 2 )); [ "$MB" -lt 0 ] && MB=0
SW=$(( COLS < 72 ? COLS : 72 )); MH=$(( (COLS - SW) / 2 ))

box_rows() {
    local pad title="The Lodge" ql lp rp
    pad="$(spaces $MB)"
    printf '\n'
    printf '%s%s╭%s❄ %s%s%s╮%s\n' "$pad" "$C_BORDER" "$C_SEP" "$C_TITLE" "$title" "$C_BORDER$(dashes $((INNER - ${#title} - 2)))" "$RST"
    printf '%s%s│%s %s  %s %s│%s\n' "$pad" "$C_BORDER" "$RST" "$(cell Traveler "$(whoami)")" "$(cell Lantern "$CPU")" "$C_BORDER" "$RST"
    printf '%s%s│%s %s  %s %s│%s\n' "$pad" "$C_BORDER" "$RST" "$(cell Shelter "$OS")" "$(cell Snowpack "$MEM")" "$C_BORDER" "$RST"
    printf '%s%s│%s %s  %s %s│%s\n' "$pad" "$C_BORDER" "$RST" "$(cell Awake "$UP")" "$(cell Cellar "$SNOW")" "$C_BORDER" "$RST"
    printf '%s%s│%s %s  %s %s│%s\n' "$pad" "$C_BORDER" "$RST" "$(barcell Warmth "$BATPCT" "$C_AMB")" "$(barcell Clarity "$MEMPCT" "$C_ICE")" "$C_BORDER" "$RST"
    ql=$(( ${#QUOTE} + 4 )); lp=$(( (INNER - ql) / 2 )); rp=$(( INNER - ql - lp ))
    printf '%s%s│%s%s%s✦%s %s %s%s✦%s%s%s│%s\n' "$pad" "$C_BORDER" "$RST" "$(spaces $lp)" "$C_AMB" "$C_QUOTE" "$QUOTE" "$RST" "$C_AMB" "$RST" "$(spaces $rp)" "$C_BORDER" "$RST"
    printf '%s%s╰%s╯%s\n' "$pad" "$C_BORDER" "$(dashes $INNER)" "$RST"
}
BOXTXT=$(box_rows; printf x); BOXTXT=${BOXTXT%x}
export BOXTXT FROST_SH=$SH FROST_W=$SW FROST_MH=$MH REALM_SHELL=$SHELLPID
[ "$COLS" -lt 100 ] && export FROST_CABIN=.5   # narrow panes (like Zellij) put the cabin in the middle

CAN_PIN=0
if [ "$ROWS" -ge $((H + 6)) ] && [ "$COLS" -ge $((BOXW + 2)) ] && command -v perl >/dev/null 2>&1; then CAN_PIN=1; fi
[ "${REALM_PIN:-1}" = 0 ] && CAN_PIN=0
SECS=${SECS_ARG:-25}; [ "$SECS" = inf ] && SECS=1000000000

case "$MODE_ARG" in
anim)
    if [ "$CAN_PIN" = 1 ] && [ "$SECS" != 0 ]; then
        FROST_PIN=anim FROST_SECS=$SECS PIDFILE="$PIDFILE" exec perl "$D/frostfall" aurora >/dev/tty 2>/dev/null </dev/null
    fi
    rm -f "$PIDFILE" ;;
paint|resize)
    if [ "$CAN_PIN" = 1 ]; then
        { [ "$MODE_ARG" = resize ] && printf '\0337\033[%d;%dr\0338' $((H + 1)) "$ROWS"
          FROST_PIN=paint perl "$D/frostfall" aurora; } >/dev/tty 2>/dev/null
    else
        printf '\033[r' >/dev/tty 2>/dev/null
    fi ;;
*)
    if [ "$CAN_PIN" = 1 ]; then
        printf '\033[2J\033[H'
        FROST_PIN=paint perl "$D/frostfall" aurora
        printf '\033[%d;%dr\033[%d;1H' $((H + 1)) "$ROWS" $((H + 1))
    else
        FROST_ONCE=1 LINES=$SH COLUMNS=$SW perl "$D/frostfall" aurora 2>/dev/null
        printf '%s' "$BOXTXT"
    fi ;;
esac
