# Suppress the zsh warning on macOS (harmless on Linux)
export BASH_SILENCE_DEPRECATION_WARNING=1

# Path configuration - add paths that exist
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Shell options
shopt -s histappend      # Append to history, don't overwrite
shopt -s checkwinsize    # Update LINES and COLUMNS after each command
shopt -s cdspell         # Autocorrect minor spelling errors in cd

# History configuration
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates and commands starting with space

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Navigation aliases
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gco='git checkout'
alias ga='git add'
alias gb='git branch'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editor alias
alias vim='nvim'

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
