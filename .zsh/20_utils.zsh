# 検索
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }

# svn cleanup
cleanup-svn () {
    find $@ -type d -name ".svn" -print | xargs -i sh -cx "svn cleanup {}/.."
}

# create server command
create_server_command () {
    echo 'for i in $(seq '$1'); do for j in $(seq -w '$2'); do echo ${i}${j}; done; done | xargs -i '"${@:3}"''
}

# enum server
enum_server () {
    for i in $(seq $1); do for j in $(seq -w $2); do echo ${i}${j}; done; done
}

# make and cd
mkcd () {
    mkdir -p $1 && cd $1
}

# tmux
tmux() {
    local tmux_cmd
    if ! tmux_cmd=$(where tmux | grep -E "^/.*/bin/tmux$" | head -n1); then
        echo "error: tmux not installed" >&2
        return 1
    fi
    if ! $tmux_cmd ls > /dev/null 2>&1; then
        # tmux ls returned error, so lets try cleaning up /tmp
        find /tmp -maxdepth 1 -name "tmux*" | xargs /bin/rm -rf
    fi
    $tmux_cmd "$@"
}

