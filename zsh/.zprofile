#brew
eval "$(/usr/local/bin/brew shellenv)"

for file in ~/.{exports,aliases,functions,history,fzf.zsh,nnn}; do
  [ -f "$file" ] && source "$file"
done
unset file
