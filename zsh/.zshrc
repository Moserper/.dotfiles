# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# debug error message
# zsh --source-trace -lic ''

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.

# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# plugins=(
#   git
#   fzf
#   vscode
#   kubectl
#   # zsh-syntax-highlighting
#   # zsh-autosuggestions
#   # zsh-history-substring-search
#   # globalias
# )

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

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ใช้ zsh builtin color scheme
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# # ปรับแต่งสีของแถบ select
# zmodload zsh/complist
# # zstyle ':completion:*' list-colors 'di=34' 'fi=0' 'ex=32' 'bd=1;33' 'cd=1;35' 'pi=40;33' 'ln=36' 'so=1;35' 'mi=1;41' 'or=1;31' 'su=0;41' 'sg=0;46' 'ca=30;41' 'tw=30;42' 'ow=34;42' 'st=37;44' 'mh=44;37' 'lc=\e[1;36m' 'rc=\e[0m' 'ec=\e[0m' 'rv=\e[7m' 'hl=\e[1;44;97m'

# autoload -U compinit && compinit

autoload -Uz compinit
compinit -u
typeset -U fpath
# NOTE: fpath is prepended AFTER compinit, so compinit never scans this dir for
# `#compdef` tags. A new completions/_foo file therefore needs an explicit
# `autoload -Uz _foo` (see terminal/zsh/.init.zsh) — without it `$_comps[cmd]`
# looks correctly bound but tabbing fails with "command not found: _foo".
fpath=(~/.dotfiles/terminal/zsh/completions $fpath)

# ssh-add -A 2>/dev/null

# auto tab highlight
zmodload zsh/complist
zstyle ':completion:*:values' add-space false
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' list-colors 'reply=(#b=34)'
zstyle ':completion:*' menu select
zstyle ':completion:*' file-patterns '.*' '*'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=**' \
  'l:|=* r:|=*'

source ~/.zprofile

export SOURCE_FUNCTION_ZSH="$HOME/.dotfiles/terminal/zsh"

source $SOURCE_FUNCTION_ZSH/.init.zsh

# theme 1
# export ZSH="$HOME/.oh-my-zsh"
# source $SOURCE_FUNCTION_ZSH/.oh-my-zsh.init
# source $SOURCE_FUNCTION_ZSH/.p10k.init

# theme 2
source $SOURCE_FUNCTION_ZSH/.starship.zsh

zstyle -d ':completion:*' list-colors
zstyle ':completion:*:default' list-colors \
 'ma=38;2;255;255;255;48;2;104;104;104'
export PATH="$HOME/.config/apm:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

# Added by Antigravity IDE
export PATH="/Users/pathomporn.s/.antigravity-ide/antigravity-ide/bin:$PATH"
# agent-os tooling (~/.agent-shared/bin + ~/.claude/bin) moved to .zshenv on
# 2026-08-09 — agents invoke `maw`/`memory-index-gen` from non-interactive tool
# shells, which never source this file. See ~/.dotfiles/zsh/.zshenv.

# Keep `maw wake …` out of shell history (2026-07-30). A wake line is a one-shot spawn
# carrying a long task prompt: it crowds out ↑-search and is never worth re-running
# verbatim (the worker it spawned already exists). Full grounding, with man-page and
# zsh-5.9 source citations: ~/m/agent-os/docs/zsh-history-research-2026-07-30.md
#
# BOTH mechanisms on purpose — they cover different halves, neither is redundant:
#   * the hook keeps the line out of THIS shell's in-memory ring (↑ / Ctrl-R / fzf).
#     Returning non-zero (1, not 2) is what keeps it off disk as well; return 2 is
#     internal-only and a bare `fc -W` writes those entries out anyway.
#     Note `fc -l` cannot verify this: a hook-suppressed entry is in the ring but not in
#     the histtab hash, so `fc -l` omits it while ↑ still recalls it for one more
#     command. Verify with a real ↑, or by searching the history file.
#   * HISTORY_IGNORE is the belt to that braces: it is applied on EVERY write this shell
#     makes, so it still strips the line if the hook's pattern ever fails to fire, and
#     the periodic trim-rewrite (at SAVEHIST + 20%) drops previously-recorded matches
#     from the file. It is NOT enough alone — being write-time only, the line stays in
#     the ring permanently and ↑ keeps finding it. It also only covers shells that have
#     it set, which is the same set that has the hook, so it buys robustness, not reach.
#
# History options live in terminal/zsh/.history.zsh, and they matter here: this setup is
# INC_APPEND_HISTORY + NO_SHARE_HISTORY + NO_EXTENDED_HISTORY. So lines hit the file as
# they are typed, but no shell re-reads the file mid-session — a pane started before
# this hook existed keeps appending `maw wake` lines, and they reach you in the NEXT
# pane you open, not in a running one. Reload every pane (`exec zsh`) after changing
# this. NO_EXTENDED_HISTORY also means the file is plain lines, not `: <ts>:<n>;<cmd>`.
#
# Pattern must stay newline-tolerant. The hook's $1 keeps the line's terminating
# newline while HISTORY_IGNORE is matched against the stripped text, so a pattern
# ending in `*` works in both places — an anchored one (`maw wake`) would filter the
# file yet silently never fire the hook. Also whole-line anchored: `maw wake*` does not
# match a line with that text in the middle. To widen to every maw command: `maw *`.
#
# `emulate -L zsh` per the manual's own example — pins glob flavour inside the hook so
# a global setopt can't change what the pattern means.
HISTORY_IGNORE='maw wake*'
autoload -Uz add-zsh-hook
_zsh_skip_maw_wake_history() {
  emulate -L zsh
  [[ $1 != ${~HISTORY_IGNORE} ]]
}
add-zsh-hook zshaddhistory _zsh_skip_maw_wake_history
