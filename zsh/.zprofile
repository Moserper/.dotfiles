for file in ~/.{exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file
