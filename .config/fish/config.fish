if status is-interactive
    # Commands to run in interactive sessions can go here
    alias g="git"
    alias gs="git status"
    alias nv="nvim"
    alias vim="nvim --clean"
    alias ccat="highlight --out-format=ansi"
    alias ls="ls -h --color=auto --group-directories-first"
    alias list="ls -Al"

    # alias pdf="detach evince"
    # alias image="detach loupe"
    # alias video="detach celluloid"
    alias copygithub="cat $HOME/Documents/Random/github-key.txt | wl-copy"
    alias proj="cd $HOME/Documents/Random/Projects"
end
