# Load hub as default git wrapper
# Via Zach Holman: https://github.com/holman/dotfiles/blob/master/git/aliases.zsh
hub_path=$(which hub)
if (( $+commands[hub] ))
then
	alias git=$hub_path
fi

# More helpful aliases
alias gadd='git add'
alias gbranch='git branch'
alias gcheckout='git checkout'
alias gcommit='git commit'
alias gdiff='git diff'
alias glog='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate' 
alias gpull='git pull'
alias gpush='git push'
alias gstatus='git status -sb'
alias gtag='git tag'
alias gfetch='git fetch'
alias gclone='git clone'
alias gpr='git pull request'
alias gremote='git remote'
alias greset='git reset'
