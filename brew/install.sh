#!/bin/bash

# --- Configuration ---
LEAVES_FILE="$HOME/.dotfiles/brew/leaves"
CASKS_FILE="$HOME/.dotfiles/brew/casks"

# --- Functions ---

# Function to check and install Homebrew packages (leaves)
install_brew_leaves() {
    echo "--- Installing Homebrew Packages (Leaves) ---"
    if [ ! -f "$LEAVES_FILE" ]; then
        echo "Error: Homebrew leaves file not found at $LEAVES_FILE. Skipping package installation."
        return 1
    fi

    while IFS= read -r package || [[ -n "$package" ]]; do
        package=$(echo "$package" | xargs) # Trim whitespace
        if [ -z "$package" ]; then # Skip empty lines
            continue
        fi

        if brew list --formula | grep -q "^$package\$"; then
            echo "ℹ️  '$package' is already installed."
        else
            echo "✨ Installing '$package'..."
            if brew install "$package"; then
                echo "✅ Successfully installed '$package'."
            else
                echo "❌ Failed to install '$package'. Please check the error messages above."
                # Optionally, you could log failures to a file here
            fi
        fi
    done < "$LEAVES_FILE"
    echo "--- Finished Homebrew Package (Leaves) Installation ---"
}

# Function to check and install Homebrew casks
install_brew_casks() {
    echo "" # Add a newline for better readability
    echo "--- Installing Homebrew Applications (Casks) ---"
    if [ ! -f "$CASKS_FILE" ]; then
        echo "Error: Homebrew casks file not found at $CASKS_FILE. Skipping cask installation."
        return 1
    fi

    while IFS= read -r cask || [[ -n "$cask" ]]; do
        cask=$(echo "$cask" | xargs) # Trim whitespace
        if [ -z "$cask" ]; then # Skip empty lines
            continue
        fi

        if brew list --cask | grep -q "^$cask\$"; then
            echo "ℹ️  '$cask' is already installed."
        else
            echo "🚀 Installing '$cask'..."
            if brew install --cask "$cask"; then
                echo "✅ Successfully installed '$cask'."
            else
                echo "❌ Failed to install '$cask'. Please check the error messages above."
                # Optionally, you could log failures to a file here
            fi
        fi
    done < "$CASKS_FILE"
    echo "--- Finished Homebrew Application (Casks) Installation ---"
}

# --- Main Script Execution ---

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first:"
    echo "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Run the installation functions
install_brew_leaves
install_brew_casks

echo "" # Add a newline for better readability
echo "🎉 Homebrew setup complete!"
