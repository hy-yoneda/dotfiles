GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[1;36m\]'
GRAY='\[\033[1;37m\]'
DEFAULT='\[\033[0;m\]'

export PS1="${CYAN}\u${GRAY}@${GREEN}\h ${YELLOW}\w \n${DEFAULT}$ "

## for tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
