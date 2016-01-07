#!/bin/sh

dot_files() {
    find . -maxdepth 1 -type f -name ".*" ! -name "." ! -name ".gitmodules" | sed 's!^./!!'
}

dot_directories() {
    find . -maxdepth 1 -type d -name ".*" ! -name "." ! -name ".git" | sed 's!^./!!'
}

CMD=$1

case "$CMD" in
  "dot-files" ) dot_files ;;
  "dot-directories" ) dot_directories ;;
esac
