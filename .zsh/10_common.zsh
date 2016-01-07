## not distinguish between lower case and upper case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
fpath=(~/.zsh/completion $fpath)

autoload -U compinit && compinit -u

## options
setopt BASH_AUTO_LIST
setopt LIST_AMBIGUOUS
setopt AUTO_PUSHD
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt list_packed
setopt list_types
setopt no_beep
setopt no_list_types
setopt magic_equal_subst
setopt mark_dirs
setopt print_eight_bit
setopt prompt_subst
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
 
## history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt append_history
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## Key bind
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey '^h'    zaw-history

tmp_sprompt="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%{$fg[yellow]%}%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color}"
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

## for tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
