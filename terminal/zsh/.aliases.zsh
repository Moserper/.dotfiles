#!/bin/bash

alias c='surf .'
alias godev='cd ~/Desktop/dev'
alias air='$(go env GOPATH)/bin/air'

alias branch='git branch --show-current'
alias browse=""
alias ls='ls -al --color'

alias vim="nvim"
alias lg="lazygit"

alias vhistory="vi ~/.zsh_history"
alias merge_pr="gh pr merge --admin "
alias pod='arch -x86_64 pod'

# docker
alias drun='docker run --rm -it -v "${PWD}":/app -w /app'
# alias docker build='docker buildx build'

# git
#alias gsb='_fzf_git_branch | xargs -I % git checkout %'
alias gsb='git fetch origin && _fzf_git_branch | sed "s/remotes\/origin\///" | xargs -I % git checkout %'

alias gcbi=_create_branch_name_from_issue
alias gdb=_delete_branch

# zsh
# alias zsh_mac='env /usr/bin/arch -arm64 /bin/zsh -c "uname -m"'
# alias zsh_intel='env /usr/bin/arch -x86_64 /bin/zsh -c "uname -m"'

alias certbot='certbot --config-dir ~/.certbot/config --work-dir ~/.certbot/work --logs-dir ~/.certbot/logs'
