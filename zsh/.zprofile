UNAME_MACHINE="$(uname -m)"

#brew
if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
  # On ARM macOS, this script installs to /opt/homebrew only
  HOMEBREW_PREFIX="/opt/homebrew"
  HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
else
  # On Intel macOS, this script installs to /usr/local only
  HOMEBREW_PREFIX="/usr/local"
  HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
fi

plugins=(
  git
  fzf
  vscode
  kubectl
  zsh-syntax-highlighting
  zsh-autosuggestions
  # zsh-history-substring-search
  # globalias
)

source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"

SEPCHARS='[ /,:-]'


# A corrected function to move forward one word.
custom-forward-word() {
    local end_pos=$CURSOR
    while [[ $end_pos -lt ${#BUFFER} && ! "${BUFFER[end_pos+1]}" =~ $SEPCHARS ]]; do
        (( end_pos++ ))
    done
    while [[ $end_pos -lt ${#BUFFER} && "${BUFFER[end_pos+1]}" =~ $SEPCHARS ]]; do
        (( end_pos++ ))
    done
    CURSOR=$end_pos
}


# A corrected function to move backward one word.
custom-backward-word() {
    local start_pos=$CURSOR
    while [[ $start_pos -gt 0 && "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
        (( start_pos-- ))
    done
    while [[ $start_pos -gt 0 && ! "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
        (( start_pos-- ))
    done
    CURSOR=$start_pos
}


# A corrected function to kill one word backward.
# custom-backward-kill-word() {
#     local original_cursor=$CURSOR
#     local start_pos=$CURSOR

#     if (( start_pos == 0 )); then return; fi

#     while [[ $start_pos -gt 0 && "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
#         (( start_pos-- ))
#     done
#     while [[ $start_pos -gt 0 && ! "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
#         (( start_pos-- ))
#     done

#     if (( start_pos < original_cursor )); then
#         CUTBUFFER=${BUFFER[start_pos+1,original_cursor]}
#         BUFFER="${LBUFFER[1,start_pos]}$RBUFFER"
#     fi
# }

custom-backward-kill-word() {
    local kill_to_pos=${#LBUFFER}

    # If the cursor is in the middle of a word, we want to delete from the
    # cursor to the beginning of that word. The default backward-kill-word
    # first skips any non-separators to the left of the cursor.
    # We will mimic this by first skipping separators, then the word.

    # 1. Move backwards over any separator characters immediately to the left of the cursor.
    #    This handles cases like "word1 /  |" -> "word1 /|"
    while [[ $kill_to_pos -gt 0 && "${LBUFFER[$kill_to_pos]}" =~ $SEPCHARS ]]; do
        (( kill_to_pos-- ))
    done

    # 2. Move backwards over the word itself (all non-separator characters).
    #    This handles "word1 /word2|" -> "word1 /|"
    while [[ $kill_to_pos -gt 0 && ! "${LBUFFER[$kill_to_pos]}" =~ $SEPCHARS ]]; do
        (( kill_to_pos-- ))
    done

    # 3. If we actually moved the position, perform the cut.
    if (( kill_to_pos < ${#LBUFFER} )); then
        # Save the deleted text into the kill ring (for pasting with Ctrl+Y).
        CUTBUFFER=${LBUFFER[kill_to_pos+1,-1]}

        # Perform the deletion by truncating LBUFFER.
        # Zsh automatically handles the cursor position correctly.
        LBUFFER=${LBUFFER[1,kill_to_pos]}
    fi
}


# # Register the new widgets with ZLE
zle -N custom-forward-word
zle -N custom-backward-word
zle -N custom-backward-kill-word

# Bind the widgets to your desired keys
bindkey "\e[1;3D" custom-backward-word
bindkey "\e[1;3C" custom-forward-word

# bindkey "^f" custom-forward-word
# bindkey "^b" custom-backward-word
bindkey "^w" custom-backward-kill-word
bindkey "^[" backward-kill-word
bindkey "^d" kill-word
# bindkey '^h' custom-backward-kill-word

bindkey '^[]' fzf-cd-widget
# bindkey "^[h" backward-word
# bindkey "^[b" backward-char
# bindkey "^[l" forward-word
# bindkey "^[f" forward-char
bindkey "^[e" redo
bindkey "^[u" undo
