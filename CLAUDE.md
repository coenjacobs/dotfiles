# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository organized by topic (tool-based) rather than by purpose. Each tool has its own directory containing related configurations and scripts.

## Installation

```bash
# macOS/Linux
./install.sh

# Windows (PowerShell as admin)
./install.ps1
```

The install script:
1. Installs Homebrew (or winget on Windows) if missing
2. Installs packages from `packages/Brewfile` (and `Brewfile.macos` on macOS)
3. Creates symlinks from config files to their expected locations
4. Backs up existing files with `.backup` suffix before replacing

Post-install steps:
- `source ~/.bashrc` to load shell config
- In tmux: `Ctrl-a + I` to install plugins
- Open nvim to auto-install plugins via lazy.nvim

## Architecture

### Directory Organization

- `bash/` - Shell configuration (`.bash_profile`, `.bashrc`)
- `nvim/` - Neovim config using lazy.nvim plugin manager
- `tmux/` - Tmux configuration with TPM
- `git/` - Global gitignore and git aliases
- `docker/` - Docker compose aliases
- `claude/` - Claude Code settings and status line script
- `packages/` - Package definitions (Brewfile, winget.json)

### Key Patterns

**Alias sourcing**: `.bashrc` dynamically sources aliases from `docker/aliases` and `git/aliases` by resolving the dotfiles directory from the symlinked `.bashrc` location.

**Symlink-based**: Configs are symlinked (not copied) so changes in this repo are immediately reflected.

**Cross-platform**: OS detection in install scripts with conditional behavior for macOS, Linux, and Windows.

### Neovim Structure

- `init.lua` - Entry point, requires config modules
- `lua/config/vim.lua` - Core settings (leader=space, relative numbers, color columns at 81/121)
- `lua/config/lazy.lua` - lazy.nvim bootstrap
- `lua/plugins/*.lua` - Individual plugin configurations

LSP servers: lua_ls, ts_ls, phpactor, cssls, html (managed via mason)

### Consistent Theme

Catppuccin theme used across both Neovim and Tmux.

## Key Keybindings

**Tmux** (prefix: `Ctrl-a`):
- `|` / `-` for splits (instead of `"` / `%`)
- `Alt+1-9` for quick window switching

**Neovim** (leader: `space`):
- `K` hover docs, `gd` go to definition
- `<leader>ha` add to Harpoon, `<leader>hh` Harpoon menu
- `<leader>1-5` quick Harpoon file selection
