for file in ~/.{exports,aliases,functions,history,fzf.zsh,nnn.zsh}; do
  [ -r "$file" ] && source "$file"
done
unset file
