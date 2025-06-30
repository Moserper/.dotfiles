for file in $SOURCE_FUNCTION_FISH/.{exports,fzf,nnn,ghostty}.fish
  source $file
end

# # ============================
# # TODO: open
# # autoload -U +X bashcompinit && bashcompinit
# # complete -o nospace -C $HOMEBREW_PREFIX/bin/terraform terraform

# # Amazon Q pre block. Keep at the top of this file.
# # [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"
# # ============================

# # Your fnm setup (place this early)
set -gx PATH $PATH (fnm env --use-on-cd | grep -o '/[^:]*')

# # Starship prompt
starship init fish | source
