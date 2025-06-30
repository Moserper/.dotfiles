#!/bin/bash

# source files

for file in $SOURCE_FUNCTION_ZSH/.{exports,aliases,functions,history,fzf,nnn,carapace}.zsh; do
  [ -f "$file" ] && source "$file"
done
unset file

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi


# ============================
# TODO: open
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C $HOMEBREW_PREFIX/bin/terraform terraform

# Amazon Q pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"
# ============================

# Your fnm setup (place this early)
eval "$(fnm env --use-on-cd)"
