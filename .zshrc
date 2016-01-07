[ ! -f ~/.zplug/zplug ] && curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug

source ~/.zplug/zplug

zplug "mollifier/cd-gitroot"
zplug "mollifier/cd-bookmark"
#zplug "b4b4r07/enhancd", of:enhancd.sh

zplug "zsh-users/zsh-syntax-highlighting", of:"zsh-syntax-highlighting.zsh", nice:10

# Make sure you use double quotes
zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-completions"

if [ -z $CYGWIN ]; then
    # Grab binaries from GitHub Releases
    # and rename to use "file:" tag
    zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf
    zplug "junegunn/fzf", as:command, of:bin/fzf-tmux
fi

#zplug "peco/peco", as:command, from:gh-r, of:"*amd64*"

# Support oh-my-zsh plugins and the like
zplug "plugins/git", from:oh-my-zsh, if:"which git"

# Load theme
zplug "~/.themes", of:"wedisagree.zsh-theme", from:local

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
