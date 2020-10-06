if [ ! -d ~/.zinit ]; then
    curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh | zsh
    #curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ -z "$TMUX" ]] && [[ -z "$STY" ]]
then
  # tmux が起動していなければ起動します。
  . "${HOME}/.zsh/rc/exports.rc.zsh"
fi

source ~/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

case "$OSTYPE" in
    cygwin ) env_os=windows ;;
    msys ) env_os=windows ;;
    * ) env_os=$OSTYPE ;;
esac

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=15"

zinit wait lucid for \
    is-snippet "OMZ::lib/clipboard.zsh" \
    is-snippet "OMZ::plugins/git/git.plugin.zsh" \
    is-snippet "OMZ::plugins/github/github.plugin.zsh" \
    is-snippet "OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh" \
    is-snippet "OMZ::plugins/zsh_reload/zsh_reload.plugin.zsh"

# Can manage local plugins
zpl ice atinit'local i; for i in *.zsh; do source $i; done'
zinit light "${HOME}/.zsh"

# Load theme
zinit snippet "${HOME}/.themes/wedisagree.zsh-theme"

zinit wait'!0' lucid for \
    light-mode atclone'rm -rf conf.d; rm -rf functions; rm -f *.fish;' pick'init.sh' nocompile'!' "b4b4r07/enhancd" \
               "zdharma/history-search-multi-word"

zinit wait lucid for \
               "mollifier/cd-bookmark" \
    light-mode "mollifier/cd-gitroot" \
    light-mode "mollifier/anyframe" \
    light-mode "b4b4r07/emoji-cli" \
    light-mode pick'k.sh' "supercrabtree/k" \
               pick'zaw.zsh' "zsh-users/zaw" \
               from"gh-r" as"program" if"[[ $env_os != windows ]]" "junegunn/fzf-bin" \
               atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' "zdharma/fast-syntax-highlighting" \
               atload'!_zsh_autosuggest_start' if"[[ $env_os != windows ]]" "zsh-users/zsh-autosuggestions" \
               blockf "zsh-users/zsh-completions"

