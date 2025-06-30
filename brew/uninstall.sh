#!/bin/bash

# --- Configuration ---
LEAVES_FILE="$HOME/.dotfiles/brew/leaves"
CASKS_FILE="$HOME/.dotfiles/brew/casks"

# --- Functions ---

# Function to uninstall Homebrew packages (formulas)
uninstall_brew_leaves() {
    echo "--- Uninstalling Homebrew Packages (Formulas) ---"

    if [ ! -f "$LEAVES_FILE" ]; then
        echo "Error: Homebrew packages file not found at '$LEAVES_FILE'. Skipping package uninstallation."
        return 1
    fi

    while IFS= read -r package || [[ -n "$package" ]]; do
        package=$(echo "$package" | xargs) # Trim whitespace
        if [ -z "$package" ]; then # Skip empty lines
            continue
        fi

        # Check if the package is actually installed by Homebrew
        if brew list --formula | grep -q "^$package\$"; then
            echo "🗑️  Uninstalling package '$package'..."
            if brew uninstall "$package"; then
                echo "✅ Successfully uninstalled package '$package'."
            else
                echo "❌ Failed to uninstall package '$package'. Please check the error messages above."
            fi
        else
            echo "ℹ️  Package '$package' is not installed or not found by Homebrew. Skipping uninstallation."
        fi
    done < "$LEAVES_FILE"
    echo "--- Finished Homebrew Package (Formulas) Uninstallation ---"
}

# Function to uninstall Homebrew casks (applications)
uninstall_brew_casks() {
    echo "" # Add a newline for better readability
    echo "--- Uninstalling Homebrew Applications (Casks) ---"

    if [ ! -f "$CASKS_FILE" ]; then
        echo "Error: Homebrew casks file not found at '$CASKS_FILE'. Skipping cask uninstallation."
        return 1
    fi

    while IFS= read -r cask || [[ -n "$cask" ]]; do
        cask=$(echo "$cask" | xargs) # Trim whitespace
        if [ -z "$cask" ]; then # Skip empty lines
            continue
        fi

        # Check if the cask is actually installed by Homebrew
        if brew list --cask | grep -q "^$cask\$"; then
            echo "🗑️  Uninstalling cask '$cask'..."
            if brew uninstall --cask "$cask"; then
                echo "✅ Successfully uninstalled cask '$cask'."
            else
                echo "❌ Failed to uninstall cask '$cask'. Please check the error messages above."
            fi
        else
            echo "ℹ️  Cask '$cask' is not installed or not found by Homebrew. Skipping uninstallation."
        fi
    done < "$CASKS_FILE"
    echo "--- Finished Homebrew Application (Casks) Uninstallation ---"
}


# --- Main Script Execution ---

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Run the uninstallation functions
uninstall_brew_leaves
uninstall_brew_casks

echo ""
echo "🎉 Homebrew uninstallation process complete!"
