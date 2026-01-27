#!/bin/bash

# Dotfiles installation script
# Creates symlinks and sets up configurations

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Backup and symlink function
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    elif [ -L "$dest" ]; then
        rm "$dest"
    fi

    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# Create ~/.config if it doesn't exist
mkdir -p "$HOME/.config"

# Bash - link both files (works on any OS)
link_file "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
link_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

# Tmux
link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Git global ignore
link_file "$DOTFILES_DIR/git/.gitignore" "$HOME/.gitignore"
git config --global core.excludesfile "$HOME/.gitignore"

# Install TPM (Tmux Plugin Manager) if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Reload bash config:  source ~/.bashrc"
echo "  2. In tmux, install plugins:  prefix + I  (Ctrl-a + I)"
echo "  3. Open nvim to let plugins install automatically"
echo ""
echo "Linux note: Install xclip for tmux clipboard support:"
echo "  sudo apt install xclip"
