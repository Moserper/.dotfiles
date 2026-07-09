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
WSCHARS='[[:space:]]'   # whitespace only — skipped, never deleted alone
PUNCTCHARS='[/,:-]'     # separators other than whitespace — a deletable chunk of their own


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


# ── BACKUP: original BUFFER-based kill-word (replaced 2026-05-31) ────────────
# Skipped ALL separators (space + / , : -) then ate one word. BUFFER/RBUFFER-based
# so it worked mid-line too. On "command test --|" it deleted "test --" in one ^w,
# leaving "command". Restore this block (and remove the active one) to roll back.
# custom-backward-kill-word() {
#     local original_cursor=$CURSOR
#     local start_pos=$CURSOR
#
#     if (( start_pos == 0 )); then return; fi
#
#     while [[ $start_pos -gt 0 && "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
#         (( start_pos-- ))
#     done
#     while [[ $start_pos -gt 0 && ! "${BUFFER[start_pos]}" =~ $SEPCHARS ]]; do
#         (( start_pos-- ))
#     done
#
#     if (( start_pos < original_cursor )); then
#         CUTBUFFER=${BUFFER[start_pos+1,original_cursor]}
#         BUFFER="${LBUFFER[1,start_pos]}$RBUFFER"
#     fi
# }
# ─────────────────────────────────────────────────────────────────────────────

# ^w kills one word backward. ONLY whitespace is a boundary — and it is NEVER
# crossed: each ^w removes a single run of one class (space OR non-space),
# whichever the cursor sits on, and stops at the class change.
#   "git commit -m|" -> "git commit "   (delete the non-space run "-m")
#   "git commit |"   -> "git commit"    (delete only the trailing space)
#   "a/b/c|"         -> ""              ("/" is non-space, so it is one word)
# Punctuation (- / , :) is part of a word here; SEPCHARS still drives the
# *-word movement widgets above, but THIS widget only cares about whitespace.
custom-backward-kill-word() {
    local kill_to_pos=${#LBUFFER}
    (( kill_to_pos == 0 )) && return

    if [[ "${LBUFFER[$kill_to_pos]}" =~ $WSCHARS ]]; then
        # On whitespace: delete the run of whitespace, stop at the first non-space.
        while [[ $kill_to_pos -gt 0 && "${LBUFFER[$kill_to_pos]}" =~ $WSCHARS ]]; do
            (( kill_to_pos-- ))
        done
    else
        # On non-space: delete the run of non-space, stop at (and keep) the space.
        while [[ $kill_to_pos -gt 0 && ! "${LBUFFER[$kill_to_pos]}" =~ $WSCHARS ]]; do
            (( kill_to_pos-- ))
        done
    fi

    if (( kill_to_pos < ${#LBUFFER} )); then
        CUTBUFFER=${LBUFFER[kill_to_pos+1,-1]}   # saved so Ctrl+Y can paste it back
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
