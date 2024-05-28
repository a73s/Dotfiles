PS1='\[\e[32m\]\u@\H\[\e[0m\]:\[\e[32m\]\w\[\e[0m\]\\$ '

export EDITOR=/bin/vim

alias ssh_server="ssh server@71.85.150.185 -p 16976"

function detach() {
	"$@" &
}

# TODO: look into making a merge directoris command with rsync

alias nv="nvim"
alias v="vim"
alias ccat="highlight --out-format=ansi"
alias ls="ls -h --color=auto --group-directories-first"
alias list="ls -al"

alias pdf="detach evince"
alias image="detach loupe"
alias video="detach celluloid"
