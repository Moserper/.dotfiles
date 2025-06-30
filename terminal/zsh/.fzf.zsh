#!/bin/bash

# Setup fzf
# ---------
# Add fzf to PATH
# ----------------
# if [[ ! "$PATH" == *${HOMEBREW_PREFIX}/opt/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}${HOMEBREW_PREFIX}/opt/fzf/bin"
# fi

# # Auto-completion
# # ---------------
# [[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

export FZF_BASE="${HOMEBREW_PREFIX}/opt/fzf"

# Add fzf to PATH
# ----------------
if [[ ! "$PATH" == *${HOMEBREW_PREFIX}/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOMEBREW_PREFIX}/opt/fzf/bin"
fi

source <(fzf --zsh)

# Key bindings
# ------------
source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"

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

_fzf_bind_opts="
  --header 'CTRL-Y: Copy | CTRL-P: Paste'
  --bind 'ctrl-y:execute-silent(pbcopy <<< {2..})'
  --bind 'ctrl-p:transform-query(pbpaste)'
  --bind 'ctrl-s:replace-query'
  --bind 'ctrl-c:print-query+abort'
"
export FZF_DEFAULT_COMMAND="fd --type f --color=never $EXCLUDE_FILE --max-depth 4"

export FZF_DEFAULT_OPTS="
  ${_fzf_bind_opts}
  --height=50%
  --layout=reverse
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS="${_fzf_bind_opts}"


export FZF_CTRL_R_OPTS="
  --preview 'echo {} | sed -E \"s/^ *[0-9]+ +//\"' --preview-window up:3:hidden:wrap
  ${_fzf_bind_opts}
  --layout=reverse
"

export FZF_ALT_C_COMMAND="fd --type d -H --no-ignore-vcs $EXCLUDE_FILE --max-depth 4"

export FZF_ALT_C_OPTS="--layout=reverse --inline-info  ${_fzf_bind_opts}"

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
