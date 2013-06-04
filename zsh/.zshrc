# oh-my-zsh config
ZSH=$HOME/.dotfiles/zsh/bundle/oh-my-zsh 
ZSH_CUSTOM=$HOME/.dotfiles/zsh/oh-my-zsh-custom
ZSH_THEME="coenjacobs" # Theme name
DISABLE_AUTO_UPDATE="true" # Updates via submodule

# oh-my-zsh plugins
plugins=(git)

# Launch main oh-my-zsh file
source $ZSH/oh-my-zsh.sh

# Add RVM
PATH=$PATH:$HOME/.rvm/bin
