# Check for a git branch
parse_git_branch () {
	git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/ (\1)/g'
}

# Called after every command
function precmd() {
	# Set the prompt
	PROMPT="%{%~%}$(parse_git_branch) › "
}
