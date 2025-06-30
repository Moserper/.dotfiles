#!/usr/bin/env fish

# Setup fzf
# ---------
# Add fzf to PATH
# ----------------
# if not contains -- $HOMEBREW_PREFIX/opt/fzf/bin $PATH
#   set -x PATH $PATH $HOMEBREW_PREFIX/opt/fzf/bin
# end

# # Auto-completion
# # ---------------
# if status is-interactive
#   source (brew --prefix)/opt/fzf/shell/completion.zsh
# end

set -x FZF_BASE (brew --prefix)/opt/fzf

# Add fzf to PATH
# ----------------
if not contains -- $FZF_BASE/bin $PATH
  set -x PATH $PATH $FZF_BASE/bin
end

# source (fzf --zsh)

fzf --fish | source

# Key bindings
# ------------
# source (brew --prefix)/opt/fzf/shell/key-bindings.zsh

function _fzf_comprun
  set -l command $argv[1]
  set -e argv[1]

  switch $command
    case cd
      fzf $argv --preview 'tree -C {} | head -200'
    case export unset
      fzf $argv --preview 'eval "echo \$"{}'
    case ssh
      fzf $argv --preview 'dig {}'
    case \*
      fzf $argv
  end
end

# set -x EXCLUDE_FILE (cat ~/.rgignore | sed -e 's/^/--exclude /' | xargs)
set -x EXCLUDE_FILE (sed 's/^/--exclude /' ~/.rgignore | xargs)

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
set -x FZF_DEFAULT_COMMAND "fd --type f --color=never --hidden $EXCLUDE_FILE --max-depth 5"

set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -x FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --bind 'ctrl-c:print-query+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  --layout=reverse
  "

set -x FZF_ALT_C_COMMAND "fd --type d -H --no-ignore-vcs $EXCLUDE_FILE --max-depth 5"
set -x FZF_ALT_C_OPTS "--layout=reverse --inline-info"


function _fzf_compgen_path
  eval fd --hidden --follow $EXCLUDE_FILE . $argv
end

# Use fd to generate the list for directory completion
function _fzf_compgen_dir
  eval fd --type d --hidden --follow $EXCLUDE_FILE . $argv
end

# Git integration with fzf
function _fzf_git_branch
    git branch --all | grep -v "/HEAD" | sed "s/.* //" | sort -u | \
    fzf
    # fzf --preview "echo {} | xargs -I % git show --color=always --stat %" --preview-window=up:30%
end
