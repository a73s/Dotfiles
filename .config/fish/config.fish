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

    function school_container
        podman pull git-docker.mst.edu/os/container && podman run --network=host --interactive --tty --rm --privileged --mount type=bind,source="$(pwd)"/,target=/your_code --workdir=/your_code git-docker.mst.edu/os/container fish
    end

    function container
        podman pull $argv[1] && podman run --interactive --tty --rm --privileged --mount type=bind,source="$(pwd)"/,target=/your_code --workdir=/your_code $argv[1]
    end

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
