export CARAPACE_BRIDGES='bash,fish,inshellisense'    # ตัด zsh ออก
source <(carapace _carapace)                         # ลงทะเบียน carapace
carapace --style 'carapace.Description=color115,bold'  # optional style

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

compdef _apm apm
