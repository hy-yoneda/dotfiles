#!/bin/sh

function dot_files {
    find . -maxdepth 1 -type f -name ".*" ! -name "." ! -name ".git*" | sed 's!^./!!'
}

function dot_directories {
    find . -maxdepth 1 -type d -name ".*" ! -name "." ! -name ".git*" | sed 's!^./!!'
}
