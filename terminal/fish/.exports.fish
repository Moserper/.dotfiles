# Exports
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x PATH $PATH $HOMEBREW_PREFIX/bin
set -x PATH $HOMEBREW_PREFIX/opt/ruby/bin $PATH
set -x PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $PATH
set -x PATH $HOMEBREW_PREFIX/opt/goku/bin/gokuw $PATH
set -x MANPATH $HOMEBREW_PREFIX/share/man $MANPATH
set -x INFOPATH $HOMEBREW_PREFIX/share/info $INFOPATH
set -x HISTCONTROL ignoreboth:erasedups
set -x PATH /Library/Frameworks/Python.framework/Versions/3.9/bin $PATH
set -x LDFLAGS -L$HOMEBREW_PREFIX/opt/ruby/lib
set -x CPPFLAGS -I$HOMEBREW_PREFIX/opt/ruby/include
set -x PATH $PATH (go env GOPATH)/bin
set -x PATH $HOMEBREW_PREFIX/opt/openjdk/bin $PATH
set -x DOCKER_DEFAULT_PLATFORM linux/amd64
set -x NVM_DIR $HOME/.nvm

if test -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
    source $HOMEBREW_PREFIX/opt/nvm/nvm.sh
end
if test -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
    source $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm
end

set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/platform-tools

set -x PATH $HOME/.local/state/fnm_multishells/73499_1748575308524/bin $PATH
set -x FNM_MULTISHELL_PATH $HOME/.local/state/fnm_multishells/73499_1748575308524
set -x FNM_VERSION_FILE_STRATEGY local
set -x FNM_DIR $HOME/.local/share/fnm
set -x FNM_LOGLEVEL info
set -x FNM_NODE_DIST_MIRROR https://nodejs.org/dist
set -x FNM_COREPACK_ENABLED false
set -x FNM_RESOLVE_ENGINES true
set -x FNM_ARCH arm64
set -x PATH $HOME/.codeium/windsurf/bin $PATH
set -x PNPM_HOME $HOME/Library/pnpm
if not string match -q -- ":$PATH:" ":$PNPM_HOME:"
    set -x PATH $PNPM_HOME $PATH
end
