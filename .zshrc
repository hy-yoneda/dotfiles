[ ! -d ~/.zplug ] && curl -sL zplug.sh/installer | zsh

source ~/.zplug/init.zsh

case "$OSTYPE" in
    cygwin ) env_os=windows ;;
    msys ) env_os=windows ;;
    * ) env_os=$OSTYPE ;;
esac

zplug "mollifier/cd-gitroot"
zplug "mollifier/cd-bookmark"

zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "mollifier/anyframe"

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions", if:"[[ $env_os != windows ]]"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zaw", use:"zsh-users/zaw.zsh", defer:3
zplug "zsh-users/zsh-syntax-highlighting", on:"zsh-users/zaw", defer:3

# Grab binaries from GitHub Releases
# and rename to use "rename-to:" tag
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, if:"[[ $env_os != windows ]]"
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux, if:"[[ $env_os != windows ]]"

# Group dependencies. Load emoji-cli if jq is installed in this example
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq, if:"[[ $env_os != windows ]]"
zplug "b4b4r07/emoji-cli", on:"stedolan/jq", if:"[[ $env_os != windows ]]"

#zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

# Support oh-my-zsh plugins and the like
#zplug "plugins/git", from:oh-my-zsh, if:"which git", defer:3

# Load theme
zplug "~/.themes", use:"wedisagree.zsh-theme", from:local

# Can manage local plugins
zplug "~/.zsh", from:local

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if [ -z $TMUX ]; then
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=15"
