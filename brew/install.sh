#!/bin/bash

# Install the packages listed in the leaves file
echo "Installing Homebrew packages..."

while read -r package; do
    if ! brew leaves | grep -q "^$package\$"; then
        echo "Installing $package..."
        if brew install "$package"; then
            echo "✅ Successfully installed $package"
        else
            echo "❌ Failed to install $package"
        fi
    else
        echo "ℹ️  $package is already installed"
    fi
done < ~/.dotfiles/brew/leaves

echo "Finished installing Homebrew packages"

# # Install the casks listed in the cask file
# while read -r cask; do
#     if ! brew list --cask | grep -q "^$cask\$"; then
#         brew install --cask "$cask"
#     else
#         echo "$cask is already installed."
#     fi
# done < casks
