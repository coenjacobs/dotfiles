# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/zsh/bundle/oh-my-zsh

export LC_ALL=en_US.UTF-8

export GOPATH=$(go env GOPATH)

# Disable auto updates as it's version controlled
DISABLE_AUTO_UPDATE="true"

ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom/

# Theme
ZSH_THEME="coenjacobs"

# Plugins
plugins=(git vagrant brew composer gpg-agent zsh-autosuggestions)

# Fire up Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Load aliases files (manual for now)
source $HOME/.dotfiles/docker/aliases.zsh
source $HOME/.dotfiles/git/aliases.zsh
source $HOME/.dotfiles/svn/aliases.zsh
source $HOME/.dotfiles/vagrant/aliases.zsh
source $HOME/.dotfiles/php/aliases.zsh
source $HOME/.dotfiles/tmux/aliases.zsh

# User configuration
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$HOME/.npm-global/bin/:/home/coenjacobs/.composer/vendor/bin:node_modules/.bin::vendor/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Add RVM
#PATH=$PATH:$HOME/.rvm/bin

[ -f ~/.dotfiles/fzf/.fzf.zsh ] && source ~/.dotfiles/fzf/.fzf.zsh

# via: https://gist.github.com/gfguthrie/9f9e3908745694c81330c01111a9d642
# normal brew nvm shell config lines minus the 2nd one
# lazy loading the bash completions does not save us meaningful shell startup time, so we won't do it
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# add our default nvm node (`nvm alias default 10.16.0`) to path without loading nvm
export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"
# alias `nvm` to this one liner lazy load of the normal nvm script
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"
