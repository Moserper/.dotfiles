if status is-interactive
    # Commands to run in interactive sessions can go here
    # Aliases
    abbr --add c 'surf .'
    abbr --add godev 'cd ~/Desktop/dev'
    abbr --add air '(go env GOPATH)/bin/air'
    abbr --add branch 'git branch --show-current'
    abbr --add browse ''
    abbr --add ls 'ls -al --color'
    abbr --add vim 'nvim'
    abbr --add lg 'lazygit'
    abbr --add vhistory 'vi ~/.zsh_history'
    abbr --add merge_pr 'gh pr merge --admin '
    abbr --add pod 'arch -x86_64 pod'
    abbr --add drun 'docker run --rm -it -v "$PWD":/app -w /app'
    abbr --add gsb 'git fetch origin && _fzf_git_branch | sed "s/remotes\/origin\///" | xargs -I % git checkout %'
    abbr --add gcbi '_create_branch_name_from_issue'
    abbr --add gdb '_delete_branch'
    abbr --add certbot 'certbot --config-dir ~/.certbot/config --work-dir ~/.certbot/work --logs-dir ~/.certbot/logs'
end

bind \e fzf-cd-widget

# Bind Ctrl+F to the custom forward-word function
bind \cf forward-word

# Bind Ctrl+B to the custom backward-word function
bind \cb backward-word


set -gx SOURCE_FUNCTION_FISH $HOME/.dotfiles/terminal/fish
echo $SOURCE_FUNCTION_FISH

source $SOURCE_FUNCTION_FISH/.init.fish
