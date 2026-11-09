# tools.zsh: everyday terminal tools, colored to match the window's realm.
# Each part only switches on if that tool is installed (./install.sh --full installs them all).
#   ghost-text suggestions (→ to accept)   commands colored as you type   z <folder> to jump anywhere
#   Ctrl+R fuzzy history                     cat with syntax colors          y  file manager (yazi)
# Turn it all off with REALM_TOOLS=0 in settings.zsh.
[[ ${REALM_TOOLS:-1} == 0 ]] && return 0

_rt_name=${REALM:-${THEME_ACTIVE:-bonfire}}
_rt_dir=${REALM_DIR:-$HOME/.config/themes/$_rt_name}
case $_rt_name in
  frost)     _rt_main=111 _rt_acc=215 _rt_dim=60  _rt_err=167 _rt_bat="Nord" ;;
  mainframe) _rt_main=255 _rt_acc=250 _rt_dim=240 _rt_err=255 _rt_bat="ansi" ;;
  *)         _rt_main=208 _rt_acc=214 _rt_dim=95  _rt_err=196 _rt_bat="gruvbox-dark" ;;
esac
[[ -f $_rt_dir/tools.env ]] && source "$_rt_dir/tools.env"   # a realm can set its own _rt_* colors
_rt_brew=${HOMEBREW_PREFIX:-/opt/homebrew}; [[ -d $_rt_brew ]] || _rt_brew=/usr/local
_rt_share() { local d; for d in "$_rt_brew/share" /usr/share /usr/share/zsh/plugins; do [[ -f $d/$1 ]] && { print -r -- "$d/$1"; return; }; done; }

: "${EDITOR:=nvim}"; export EDITOR

# suggestions from your history, in a faint realm color
if [[ -n $(_rt_share zsh-autosuggestions/zsh-autosuggestions.zsh) ]]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$_rt_dim"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  source "$(_rt_share zsh-autosuggestions/zsh-autosuggestions.zsh)"
fi

# z <part of a folder name> jumps there; zi picks from a list
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf: Ctrl+R history, Ctrl+T files, Alt+C folders
if command -v fzf >/dev/null; then
  source <(fzf --zsh 2>/dev/null)
  export FZF_DEFAULT_OPTS="--height=45% --layout=reverse --border=rounded --info=inline \
--color=fg:250,hl:$_rt_main,fg+:255,bg+:236,hl+:$_rt_acc,prompt:$_rt_main,pointer:$_rt_acc,marker:$_rt_acc,info:$_rt_dim,border:$_rt_dim,spinner:$_rt_acc"
  command -v fd >/dev/null && export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git' FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git'
  command -v bat >/dev/null && export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
fi

# bat: cat with colors (plain `command cat` still works)
if command -v bat >/dev/null; then
  export BAT_THEME="$_rt_bat"
  alias cat='bat --paging=never --style=plain'
fi

# yazi: y opens the file manager in the realm's colors, and you land wherever you quit it
if command -v yazi >/dev/null; then
  [[ -d $_rt_dir/yazi ]] && export YAZI_CONFIG_HOME="$_rt_dir/yazi"
  y() {
    local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [[ -n $cwd && $cwd != "$PWD" ]]; then builtin cd -- "$cwd"; fi
    rm -f -- "$tmp"
  }
fi

# commands light up as you type: known ones in the realm color, typos underlined. Loads last on purpose.
if [[ -n $(_rt_share zsh-syntax-highlighting/zsh-syntax-highlighting.zsh) ]]; then
  source "$(_rt_share zsh-syntax-highlighting/zsh-syntax-highlighting.zsh)"
  ZSH_HIGHLIGHT_STYLES[command]="fg=$_rt_main,bold"
  ZSH_HIGHLIGHT_STYLES[builtin]="fg=$_rt_main"
  ZSH_HIGHLIGHT_STYLES[alias]="fg=$_rt_main,bold"
  ZSH_HIGHLIGHT_STYLES[function]="fg=$_rt_main"
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=$_rt_main,underline"
  ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$_rt_err,underline"
  ZSH_HIGHLIGHT_STYLES[path]="underline"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$_rt_acc"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$_rt_acc"
  ZSH_HIGHLIGHT_STYLES[comment]="fg=$_rt_dim"
fi
unset _rt_main _rt_acc _rt_dim _rt_err _rt_bat _rt_brew
