#!/bin/bash
# Install the packages listed in the leaves file
while read -r package; do
    if ! brew list --formula | grep -q "^$package\$"; then
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done < leaves

# Install the casks listed in the cask file
while read -r cask; do
    if ! brew list --cask | grep -q "^$cask\$"; then
        brew install --cask "$cask"
    else
        echo "$cask is already installed."
    fi
done < casks
