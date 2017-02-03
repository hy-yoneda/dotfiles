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
    local which_cmd
    if ! which_cmd=$(which gwhich > /dev/null 2>&1); then
        which_cmd=which
    fi

    local tmux_cmd
    if ! tmux_cmd=$(eval "$which_cmd --skip-functions tmux"); then
        echo "error: tmux not installed" >&2
        return 1
    fi
    if ! $tmux_cmd ls > /dev/null 2>&1; then
        # tmux ls returned error, so lets try cleaning up /tmp
        find /tmp -maxdepth 1 -name "tmux*" | xargs /bin/rm -rf
    fi
    $tmux_cmd "$@"
}

compdef _sshlogin sshlogin
compdef _sshlogin scplogin
compdef _sshlogin sshcat

# _sshlogin
function _sshlogin {
    local -a _hosts
    _hosts=($(ls ~/.sshpass))
    _describe -t hosts "Hosts" _hosts

    return 1;
}

# _sshpass
function _sshpass {
    source $HOME/.sshpass/$2

    local cmd
    [ -n "$_PASSWORD" ] && cmd="sshpass -p $_PASSWORD"

    if [[ -n $(printenv TMUX) ]]; then
        local window_name=$(tmux display -p '#{window_name}')
        tmux rename-window -- "$2"

        local log_file="$(date +%Y-%m-%d/%H-%M-%S.log)"
        [ ! -d /tmp/.tmuxlog/$(whoami)/$2/$(dirname $log_file) ] && mkdir -p /tmp/.tmuxlog/$(whoami)/$2/$(dirname $log_file)
        tmux pipe-pane "cat >> /tmp/.tmuxlog/$(whoami)/$2/$log_file"
        #tmux display-message "Started logging to /tmp/.tmuxlog/$(whoami)/$2/$log_file"

        eval "$cmd $1 -o StrictHostKeyChecking=no $_USERNAME@$2 ${@:3}"

        tmux pipe-pane
        #tmux display-message "Ended logging to /tmp/.tmuxlog/$(whoami)/$2/$log_file"

        tmux rename-window "$window_name"
    else
        eval "$cmd $1 -o StrictHostKeyChecking=no $_USERNAME@$2 ${@:3}"
    fi
}

# sshlogin
function sshlogin {
    _sshpass ssh ${@}
}

# scplogin
function scplogin {
    _sshpass scp ${@}
}

# sshcat
function sshcat {
    if [ ! -e $HOME/.sshpass/$1 ]; then
        echo "not found. $1"
        return 1;
    fi

    source $HOME/.sshpass/$1
    echo "USERNAME: ${_USERNAME}"
    echo "PASSWORD: ${_PASSWORD}"
}
