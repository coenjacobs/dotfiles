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
alias gstatus='git status -sb'
alias gcheckout='git checkout'
alias glog='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate' 
alias gadd='git add'
