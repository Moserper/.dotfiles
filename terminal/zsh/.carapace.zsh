export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
# TEMPORARY TEST using simple colors
source <(carapace _carapace)

carapace --style 'carapace.Description=color115,bold'
