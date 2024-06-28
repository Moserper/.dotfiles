for file in ~/.{exports,aliases,functions,history,fzf.zsh,nnn}; do
  [ -r "$file" ] && source "$file"
done
unset file
