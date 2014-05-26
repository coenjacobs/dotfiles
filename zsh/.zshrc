# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/zsh/bundle/oh-my-zsh

# Disable auto updates as it's version controlled
DISABLE_AUTO_UPDATE="true"

# Theme
ZSH_THEME="cloud"

# Plugins
plugins=(git vagrant brew)

# Fire up Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Load aliases files (manual for now)
source $HOME/.dotfiles/git/aliases.zsh
source $HOME/.dotfiles/svn/aliases.zsh
source $HOME/.dotfiles/vagrant/aliases.zsh

# User configuration
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add RVM
#PATH=$PATH:$HOME/.rvm/bin