#!/bin/bash

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

export EXCLUDE_FILE=$(cat ~/.rgignore | sed -e 's/^/--exclude /' | xargs)

# export EXCLUDE_FILE=$(cat ~/.rgignore | sed -e 's/^/--exclude /' | xargs)
# export EXCLUDE_FILE=$(cat ~/.rgignore | sed 's/^/"/;s/$/"/' | sed -e 's/^/--exclude /' | sed ':a; N; $!ba; s/\n/ /g')
# export CONFIGURATION="--search-path $HOME/.config --search-path $HOME/downloads --search-path $HOME/google_drive --search-path /etc"

# export FZF_DEFAULT_COMMAND='find . -type f' \
#   fzf --bind 'ctrl-e:reload(find . -type d),ctrl-f:reload(eval "$FZF_DEFAULT_COMMAND")' \
#       --height=50% --layout=reverse

# RG_PREFIX='rg --colors match:style:bold --smart-case '
#printf "\x0c" | pbcopi
# export FZF_DEFAULT_COMMAND="$RG_PREFIX --files"
#
# export FZF_CTRL_T_COMMAND="$RG_PREFIX --files"

# export FZF_DEFAULT_COMMAND="fd --type f --color=never --hidden $EXCLUDE_FILE"
#
export FZF_DEFAULT_COMMAND="fd --type f --color=never --hidden $EXCLUDE_FILE --max-depth 4"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --layout=reverse
  "

export FZF_ALT_C_COMMAND="fd --type d -H --no-ignore-vcs $EXCLUDE_FILE --max-depth 4"
export FZF_ALT_C_OPTS="--layout=reverse --inline-info"


_fzf_compgen_path() {
  eval fd --hidden --follow "$EXCLUDE_FILE" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  eval fd --type d --hidden --follow "$EXCLUDE_FILE" . "$1"
}

# Git integration with fzf
_fzf_git_branch() {
    git branch --all | grep -v "/HEAD" | sed "s/.* //" | sort -u | \
    fzf
    # fzf --preview "echo {} | xargs -I % git show --color=always --stat %" --preview-window=up:30%
}
