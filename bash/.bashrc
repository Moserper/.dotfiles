export PS1='\u@\h:\[\e[33m\]\w\[\e[0m\]\$ '
export EDITOR='vim'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
