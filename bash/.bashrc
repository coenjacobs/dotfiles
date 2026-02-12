# Suppress the zsh warning on macOS (harmless on Linux)
export BASH_SILENCE_DEPRECATION_WARNING=1

# Homebrew setup (must come before other PATH additions)
# Linux
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# macOS (Apple Silicon)
elif [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Additional paths
[[ -d "$HOME/.claude/local/bin" ]] && export PATH="$HOME/.claude/local/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Shell options
shopt -s histappend      # Append to history, don't overwrite
shopt -s checkwinsize    # Update LINES and COLUMNS after each command
shopt -s cdspell         # Autocorrect minor spelling errors in cd

# History configuration
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates and commands starting with space

# Navigation aliases
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git-aware prompt
__git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " ($branch)"
    fi
}

# Prompt: user@host:directory (branch)$
export PS1='\u@\h:\w\[\033[0;32m\]$(__git_branch)\[\033[0m\]\$ '

# Bash completion (multi-platform)
if [[ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# Source topic-based config files (aliases, env)
DOTFILES_DIR="$(dirname "$(readlink -f ~/.bashrc)" 2>/dev/null || dirname "$(realpath ~/.bashrc)" 2>/dev/null)"
for source_file in "$DOTFILES_DIR"/../*/env "$DOTFILES_DIR"/../*/aliases; do
    [[ -f "$source_file" ]] && . "$source_file"
done

# Source local overrides (secrets, machine-specific settings)
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
