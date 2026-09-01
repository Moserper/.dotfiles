export CARAPACE_BRIDGES='zsh,bash,fish,inshellisense'
source <(carapace _carapace)
carapace --style 'carapace.Description=color115,bold'

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

compdef _apm apm
