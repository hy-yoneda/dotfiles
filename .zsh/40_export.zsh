export LANG=ja_JP.UTF-8
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man

## prioritize homebrew
export PATH=~/bin:~/usr/bin:~/usr/local/bin:/usr/local/bin:$PATH

export PATH=$PATH:$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

if [[ -n $TMUX ]]; then
    export TERM="xterm-256color"
fi
