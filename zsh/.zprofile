for file in ~/.{exports,aliases,functions,history,fzf.zsh}; do
  [ -r "$file" ] && source "$file"
done
unset file
