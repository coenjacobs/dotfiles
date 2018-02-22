# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/zsh/bundle/oh-my-zsh

export GOPATH=$(go env GOPATH)

# Disable auto updates as it's version controlled
DISABLE_AUTO_UPDATE="true"

ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom/

# Theme
ZSH_THEME="coenjacobs"

# Plugins
plugins=(laravel4 git vagrant brew composer) 

# Fire up Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Load aliases files (manual for now)
source $HOME/.dotfiles/git/aliases.zsh
source $HOME/.dotfiles/svn/aliases.zsh
source $HOME/.dotfiles/vagrant/aliases.zsh
source $HOME/.dotfiles/php/aliases.zsh
source $HOME/.dotfiles/tmux/aliases.zsh

# User configuration
export PATH="$GOPATH/bin:/home/coenjacobs/.npm:/home/coenjacobs/.composer/vendor/bin:vendor/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Add RVM
#PATH=$PATH:$HOME/.rvm/bin

# In order for gpg to find gpg-agent, gpg-agent must be running,
# # and there must be an env variable pointing GPG to the gpg-agent socket.
# # This little script, which must be sourced
# # in your shell's init script (ie, .bash_profile, .zshrc, whatever),
# # will either start gpg-agent or set up the
# # GPG_AGENT_INFO variable if it's already running.
#
# # Add the following
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ];
then
     source ~/.gnupg/.gpg-agent-info
     export GPG_AGENT_INFO
else
     eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi
