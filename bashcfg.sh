PS1='\[\e[32m\]\u@\H\[\e[0m\]:\[\e[32m\]\w\[\e[0m\]\\$ '

export EDITOR=/bin/vim

alias ssh_server="ssh server@71.85.150.185 -p 16976"

function detach() {
	"$@" &
}

alias g="git"
alias gs="git status"
alias nv="nvim"
alias v="vim"
alias ccat="highlight --out-format=ansi"
alias ls="ls -h --color=auto --group-directories-first"
alias list="ls -Al"

alias pdf="detach evince"
alias image="detach loupe"
alias video="detach celluloid"
alias copygithub="cat $HOME/Documents/Random/github-key.txt | wl-copy"
