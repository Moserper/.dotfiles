#!/usr/bin/env fish

if test "$TERM_PROGRAM" = "ghostty"
    set -gx TERM xterm-256color
end
