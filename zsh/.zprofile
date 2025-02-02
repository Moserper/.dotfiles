# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"
#brew
eval "$(/usr/local/bin/brew shellenv)"

for file in ~/.{exports,aliases,functions,history,fzf.zsh,nnn}; do
  [ -f "$file" ] && source "$file"
done
unset file

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
