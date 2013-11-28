# VCS prompt via http://stackoverflow.com/a/1128583/526501
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
		    '%F{5}(%f%s%F{5}%F{3}@%F{5}%F{2}%b%F{3}|%F{1}%a%F{5})%f '
zstyle ':vcs_info:*' formats       \
		    '%F{5}(%f%s%F{5}%F{3}@%F{5}%F{2}%b%F{5})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

vcs_info_wrapper() {
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}

PROMPT='⚡ %m %~ $(vcs_info_wrapper)'

# Load aliases files (manual for now)
source $HOME/.dotfiles/git/aliases.zsh
source $HOME/.dotfiles/svn/aliases.zsh
source $HOME/.dotfiles/vagrant/aliases.zsh

# Add RVM
PATH=$PATH:$HOME/.rvm/bin
