zmodload zsh/zprof

# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
#
#
# Path to your oh-my-zsh installation.
# setopt HIST_EXPIRE_DUPS_FIRST
export ZSH="/Users/Moserper/.oh-my-zsh"
export CLOUDSDK_PYTHON=python3
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.  # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(
  git
  fzf
  vscode
  # zsh-syntax-highlighting
  # zsh-autosuggestions
  # zsh-history-substring-search
  # globalias
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


source ~/.zprofile

source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=09'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# [[ ! -f ~/.exports ]] || source ~/.exports

eval
EAS_AC_ZSH_SETUP_PATH=/Users/Moserper/Library/Caches/eas-cli/autocomplete/zsh_setup && test -f $EAS_AC_ZSH_SETUP_PATH && source $EAS_AC_ZSH_SETUP_PATH; # eas autocomplete setup
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

_fzf_compgen_path() {
  eval fd --hidden --follow "$EXCLUDE_FILE" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  eval fd --type d --hidden --follow "$EXCLUDE_FILE" . "$1"
}

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


# Git integration with fzf
_fzf_git_branch() {
    git branch --all | grep -v "/HEAD" | sed "s/.* //" | sort -u | \
    fzf
    # fzf --preview "echo {} | xargs -I % git show --color=always --stat %" --preview-window=up:30%
}

bindkey '^[]' fzf-cd-widget

bindkey "^b" backward-word
bindkey "^[b" backward-char
bindkey "^f" forward-word
bindkey "^[f" forward-char

bindkey "^[e" redo
bindkey "^d" kill-word
bindkey "^h" delete-char-or-list

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform


if [[ -n $DISPLAY ]]; then                                                                                    
    x-kill-whole-line () {                                                                                    
      zle kill-whole-line                                                                                     
      print -rn -- "$CUTBUFFER" | xsel -ib                                                                    
    }                                                                                                         
    zle -N x-kill-whole-line                                                                                  
    bindkey '\C-u' x-kill-whole-line                                                                          
fi 

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/moserper/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/moserper/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/moserper/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/moserper/google-cloud-sdk/completion.zsh.inc'; fi
