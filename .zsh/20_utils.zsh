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
