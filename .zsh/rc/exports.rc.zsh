# Homebrew/Linuxbrew
# ------------------

# Homebrew/Linuxbrew でプリフィックスのパスが違う。
# $(brew --prefix) は時間がかかる処理であるため、ここで判定して HOMEBREW_PREFIX に格納する。
if [[ -d "${HOME}/.linuxbrew" ]]
then
  HOMEBREW_PREFIX="${HOME}/.linuxbrew"
elif [[ -x '/usr/local/bin/brew' ]]
then
  HOMEBREW_PREFIX='/usr/local'
fi

if [[ -n "$HOMEBREW_PREFIX" ]]
then
  # Homebrew の PATH の解決をここで行う。
  export HOMEBREW_PREFIX
  path=( "${HOMEBREW_PREFIX}/bin" "${path[@]}" )

  export XDG_DATA_DIRS="${HOMEBREW_PREFIX}/share:${XDG_DATA_DIRS}"
fi

if [[ -d "${HOME}/.zsh" ]]
then
  fpath=(
    "${HOME}/.zsh/completions"
    #"${HOME}/.zsh/functions"
    "${fpath[@]}"
  )
  export FPATH
fi

export XDG_CONFIG_HOME="${HOME}/.config"
