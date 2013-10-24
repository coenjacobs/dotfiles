# Load hub as default git wrapper
# Via Zach Holman: https://github.com/holman/dotfiles/blob/master/git/aliases.zsh
hub_path=$(which hub)
if (( $+commands[hub] ))
then
	alias git=$hub_path
fi

# More helpful aliases
alias gbranch='git branch'
alias gcommit='git commit'
alias gdiff='git diff'
alias gstatus='git status -sb' # show minimized list of status
alias gcheckout='git checkout'
