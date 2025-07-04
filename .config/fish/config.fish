if status is-interactive

    function detach;
        command $argv &>/dev/null & disown
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
    function fm;
        detach nautilus -w .
    end

    set -U fish_greeting ""
    set fish_color_command blue

    function school_container
        podman run --network=podman -it --rm --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files localhost/school_custom fish
    end

    function container
        podman run --network=podman -it --rm --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files $argv
    end

    function perm_container
        podman run --network=podman -it --privileged --mount type=bind,source="$(pwd)"/,target=/host_files --workdir=/host_files $argv
    end

    alias ccat="highlight --out-format=ansi"
    alias ls="ls -h --color=auto --group-directories-first"
    alias list="ls -Al"

    alias copygithub="cat $HOME/Documents/Random/github-key.txt | wl-copy"
    alias copygitlab="cat $HOME/Documents/School/mst\ gitlab.txt | wl-copy"
    alias proj="cd $HOME/Documents/Random/Projects"
end
