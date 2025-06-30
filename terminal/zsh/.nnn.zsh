#!/bin/bash

BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"

set --export NNN_INFO "/tmp/nnn.fifo"

n () {
  # Block nesting of nnn in subshells
  [ "${NNNLVL:-0}" -eq 0 ] || {
    echo "nnn is already running"
      return
  }
  export EDITOR=cursor

  # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
  # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
  # see. To cd on quit only on ^G, remove the "export" and make sure not to
  # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
  # NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  # NNN configuration for plugins to communicate back
  export NNN_FIFO="/tmp/nnn.fifo"
  # Create the pipe if it doesn't exist and set correct permissions
  if [ ! -p "$NNN_FIFO" ]; then
      mkfifo "$NNN_FIFO"
      chmod 600 "$NNN_FIFO"
      xattr -c "$NNN_FIFO"
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
  export NNN_COLORS="2136"
  export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  export NNN_PLUG='f:ffind;p:peview-tui;n:newfile-from-clipboard;d:newdir-from-clipboard'
  export NNN_BMS="w:$HOME/w;d:$HOME/Desktop;s:$HOME/.dotfiles;l:$HOME/learn;"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  # The command builtin allows one to alias nnn to n, if desired, without
  # making an infinitely recursive alias
  command nnn -exR "$@"

  [ ! -f "$NNN_TMPFILE" ] || {
    . "$NNN_TMPFILE"
      rm -f "$NNN_TMPFILE" > /dev/null
  }
}
