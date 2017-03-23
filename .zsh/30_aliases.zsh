## alias
alias vi='vim'
alias df="df -h"
alias du="du -h"
alias screen='screen -U'
alias h='history'
alias less="$(which less) -r"
alias gdir='GDIR=$(git dir) && cd ${GDIR}'
alias gcb='git cb'

case "${OSTYPE}" in
    darwin*)
        alias ll='ls -lFG'
        alias la='ls -laFG'
        alias ls='ls -AFG'
        ;;
    *)
        alias ll='ls -lF --color'
        alias la='ls -laF --color'
        alias ls='ls -AF --color'
        ;;
esac
