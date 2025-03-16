if status is-interactive

    function detach;
        command $argv & disown
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
        podman run --network=podman -it --rm --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files localhost/school_custom fish
    end

    function container
        podman run --network=podman -it --rm --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files $argv
    end

    function perm_container
        podman run --network=podman -it --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files $argv
    end

    alias g="git"
    alias gs="git status"
    alias nv="nvim"
    alias vim="nvim --clean"
    alias ccat="highlight --out-format=ansi"
    alias ls="ls -h --color=auto --group-directories-first"
    alias list="ls -Al"
    alias sysupdate="systemd-inhibit --what='handle-lid-switch:sleep' --who='update script' --why='Prevent sleep while running update' --mode=block $HOME/update.sh"

    alias copygithub="cat $HOME/Documents/Random/github-key.txt | wl-copy"
    alias copygitlab="cat $HOME/Documents/School/mst\ gitlab.txt | wl-copy"
    alias proj="cd $HOME/Documents/Random/Projects"
end
