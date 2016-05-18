[ ! -d ~/.zplug ] && curl -sL get.zplug.sh | zsh

source ~/.zplug/init.zsh

zplug "mollifier/cd-gitroot"
zplug "mollifier/cd-bookmark"
#zplug "b4b4r07/enhancd", use:enhancd.sh

zplug "zsh-users/zsh-syntax-highlighting", use:"zsh-syntax-highlighting.zsh", nice:10

# Make sure you use double quotes
zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-completions"

if [ -z $CYGWIN ]; then
    # Grab binaries from GitHub Releases
    # and rename to use "rename-to:" tag
    zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
    zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

    # Group dependencies. Load emoji-cli if jq is installed in this example
    zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
    zplug "b4b4r07/emoji-cli", on:"stedolan/jq"
fi

#zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

# Support oh-my-zsh plugins and the like
zplug "plugins/git", from:oh-my-zsh, if:"which git", nice:10

# Load theme
zplug "~/.themes", use:"wedisagree.zsh-theme", from:local

# Can manage local plugins
zplug "~/.zsh", from:local

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose
