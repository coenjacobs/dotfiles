# Load hub as default git wrapper
# Via Zach Holman: https://github.com/holman/dotfiles/blob/master/git/aliases.zsh
hub_path=$(which hub)
if (( $+commands[hub] ))
then
	alias git=$hub_path
fi