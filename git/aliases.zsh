# Load hub as default git wrapper
# Via Zach Holman: https://github.com/holman/dotfiles/blob/master/git/aliases.zsh
hub_path=$(which hub)
if (( $+commands[hub] ))
then
	alias git=$hub_path
fi

# More helpful aliases
alias gitb='git branch'
alias gitc='git commit'
alias gitd='git diff'
alias gits='git status -sb' # show minimized list of status