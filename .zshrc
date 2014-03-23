export LANG=ja_JP.UTF-8
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }

## alias
alias ls='ls -AFG --color=auto'
alias ll='ls -lFG'
alias la='ls -lAFG'
alias df="df -h"
alias du="du -h"
alias screen='screen -U'
alias h='history'

## not distinguish between lower case and upper case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*:*:git:*' script ~/git-completion.bash
fpath=(~/.zsh/completion $fpath)

## git-prompt
[ -f ~/git-prompt.sh ] && source ~/git-prompt.sh

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

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors

# gitのブランチ名と変更状況をプロンプトに表示する
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
	autoload -Uz add-zsh-hook
	#autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/nul
	zstyle ':vcs_info:git:*' check-for-changes false
	zstyle ':vcs_info:git:*' stagedstr "+"
	zstyle ':vcs_info:git:*' unstagedstr "-"
	zstyle ':vcs_info:git:*' formats '[%b[%c%u]]'
	zstyle ':vcs_info:git:*' actionformats '[%b|%a[%c%u]]'

	# VCSの更新時にPROMPTを自動更新する
	local _pre=''
	function _preexec() {
		_pre="$1"
	}

	function _update_vcs_info_msg() {
		_r=$?

		case "${_pre}" in
			cd*|svn*|git*)

			psvar=()
			LANG=en_US.UTF-8 vcs_info
			[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
			;;
		esac

		return ${_r}
	}

	add-zsh-hook -Uz preexec _preexec
	add-zsh-hook -Uz precmd _update_vcs_info_msg
fi

# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!%B(*'-') >>%b!%B(*;-;%)? >>%b) %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%1(v|%B%F{green}%1v%f%b|) %B%F{yellow}[%30<..<%~]%f%b%{${reset_color}%}"
tmp_sprompt="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%{$fg[yellow]%}%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color}"
#tmp_prompt_gitbr="%{${fg[magenta]}%}$(__git_ps1 '(%s) ')%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
#  tmp_prompt_gitbr="%B%U${tmp_prompt_gitbr}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT="${tmp_prompt_gitbr}${tmp_rprompt}"  # 右側のプロンプト
#RPROMPT="${tmp_prompt_gitbr}${tmp_rprompt}"  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  #PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#;

case "${TERM}" in
    kterm*|xterm*)
	precmd() {
            echo -ne "\033]0;${USER}@${HOST}\007"
	}
	;;
    screen*)
        if [ "$OS" != "Windows_NT" ]
        then
            preexec() {
                mycmd=(${(s: :)${1}})
                echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):#$mycmd[1]\e\\"
            }
            precmd() {
                echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$(basename $(pwd))\e\\"
            }
        fi
        ;;
esac

## prioritize homebrew
export PATH=~/bin:/usr/local/bin:$PATH

export PATH=$PATH:$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

## for tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/zaw/zaw.zsh ] && source ~/zaw/zaw.zsh
