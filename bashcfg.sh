PS1='\[\e[32m\]\u@\H\[\e[0m\]:\[\e[32m\]\w\[\e[0m\]\\$ '

alias server-ssh="ssh server@71.85.150.185 -p 16976"

function detach() {
	"$@" &
}

alias open_pdf="detach evince"
alias open_image="detach loupe"
alias open_video="detach celluloid"
alias list="ls -al"
