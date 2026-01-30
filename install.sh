#!/bin/bash

# Dotfiles installation script
# Installs development tools via Homebrew and sets up configuration symlinks

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"
echo ""

# =============================================================================
# OS Detection
# =============================================================================

detect_os() {
    case "$(uname -s)" in
        Darwin)
            echo "macos"
            ;;
        Linux)
            echo "linux"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

OS=$(detect_os)

if [ "$OS" = "unknown" ]; then
    echo "Unsupported operating system."
    echo "For Windows, please use install.ps1 instead."
    exit 1
fi

echo "Detected OS: $OS"
echo ""

# =============================================================================
# Homebrew Installation
# =============================================================================

install_homebrew() {
    if command -v brew &> /dev/null; then
        echo "Homebrew is already installed"
        return 0
    fi

    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Set up Homebrew for current session (permanent PATH is in dotfiles .bashrc)
    if [ "$OS" = "linux" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    echo "Homebrew installed successfully"
}

install_homebrew

# Ensure brew is in PATH for this session
if [ "$OS" = "linux" ] && [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo ""

# =============================================================================
# Package Installation via Homebrew
# =============================================================================

echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/packages/Brewfile"

if [ "$OS" = "macos" ]; then
    echo ""
    echo "Installing macOS-specific packages..."
    brew bundle --file="$DOTFILES_DIR/packages/Brewfile.macos"
fi

echo ""

# =============================================================================
# NPM Global Packages
# =============================================================================

echo "Installing npm global packages..."
npm install -g @anthropic-ai/claude-code

echo ""

# =============================================================================
# Configuration Symlinks
# =============================================================================

echo "Setting up configuration symlinks..."

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

# Note: docker/aliases and git/aliases are sourced automatically by .bashrc
# No symlinks needed - they are sourced relative to the dotfiles directory

# Claude Code - symlink config files into ~/.claude/ (not the whole directory)
mkdir -p "$HOME/.claude"
link_file "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link_file "$DOTFILES_DIR/claude/statusline.sh" "$HOME/.claude/statusline.sh"

# Install TPM (Tmux Plugin Manager) if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo ""
echo "============================================="
echo "Installation complete!"
echo "============================================="
echo ""
echo "Next steps:"
echo "  1. Reload bash config:  source ~/.bashrc"
echo "  2. In tmux, install plugins:  prefix + I  (Ctrl-a + I)"
echo "  3. Open nvim to let plugins install automatically"
echo ""
if [ "$OS" = "linux" ]; then
    echo "Linux note: Install xclip for tmux clipboard support:"
    echo "  sudo apt install xclip"
    echo ""
fi
echo "Secrets (SSH keys, API keys) must be set up manually on local machines"
echo "or via Ansible on VPS deployments."
echo ""
