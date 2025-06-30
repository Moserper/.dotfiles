#!/bin/bash

## setting
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="$PATH:${HOMEBREW_PREFIX}/bin"
# export PATH=$HOME/.local/bin:$PATH

export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$PATH"
# GOKU
export PATH="${HOMEBREW_PREFIX}/opt/goku/bin/gokuw:$PATH"
export MANPATH="${HOMEBREW_PREFIX}/share/man:${MANPATH}"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH}"

# history
export HISTCONTROL=ignoreboth:erasedups

## language
# python
export PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
# ruby
export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/ruby/lib"
export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/ruby/include"


# go
export PATH=$PATH:$(go env GOPATH)/bin
# export GOPATH=$(go env GOPATH)

# yarn
# export PATH="$(yarn global bin):$PATH"

# java
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
# export JAVA_HOME="/usr/local/Cellar/openjdk@11/11.0.22/libexec/openjdk.jdk/Contents/Home"
# export PATH="${JAVA_HOME}/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"

## program
# docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64
# export DOCKER_DEFAULT_PLATFORM=linux/arm64

# # nvm
# export NVM_DIR="$HOME/.nvm"
#   [ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# GCP
# export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"
# export GOOGLE_APPLICATION_CREDENTIALS="$HOME/Desktop/key/brightman-staging-tcph/staging-tcph.json"
# export GOOGLE_APPLICATION_CREDENTIALS="$HOME/Desktop/key/hatari/prod/hatari-it-6616a4219e2e.json"
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Downloads/mengkee-stg-a26971af50d6.json
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Desktop/key/brightman-staging-tcma/brightman-tcma-staging-f71ee468efae.json
# export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Desktop/key/brightman-product/brightman-bdaf2cfc91b8.json

# Android
# export ANDROID_HOME=/usr/local/share/android-sdk
# export ANDROID_SDK_ROOT=/usr/local/share/android-sdk

# export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
# export NEXT_PUBLIC_BACKEND_URL=test

# FNM
export PATH="$HOME/.local/state/fnm_multishells/73499_1748575308524/bin":$PATH
export FNM_MULTISHELL_PATH="$HOME/.local/state/fnm_multishells/73499_1748575308524"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="$HOME/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"

# # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# python
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# podman
export DOCKER_HOST='unix:///var/folders/sy/p7sn5l_d5bvfrsjvxm01sv540000gn/T/podman/podman-machine-default-api.sock'

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"
