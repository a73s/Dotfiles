if status is-interactive

    function detach;
        command $argv &; disown
    end
    function image;
        detach loupe $argv
    end
    function pdf;
        detach evince $argv
    end
    function video;
        detach celluloid $argv
    end

    set -U fish_greeting ""

    alias ssh_server="ssh server@71.85.150.185 -p 16976"

    alias g="git"
    alias gs="git status"
    alias nv="nvim"
    alias vim="nvim --clean"
    alias ccat="highlight --out-format=ansi"
    alias ls="ls -h --color=auto --group-directories-first"
    alias list="ls -Al"

    alias copygithub="cat $HOME/Documents/Random/github-key.txt | wl-copy"
    alias proj="cd $HOME/Documents/Random/Projects"
end
