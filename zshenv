export ZSH=${HOME}/.dotfiles/zsh

#
# Editors
#

export PAGER='less'

if (( $#commands[vim] )); then
  export EDITOR="vim"
  export VISUAL="vim"
fi

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

if [[ -z "$LC_ALL" ]]; then
  export LC_ALL=$LANG
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath path

# Set the list of directories that Zsh searches for programs.
path=(
  ${HOME}/go/bin
  ${HOME}/.yarn/bin
  ${HOME}/.rbenv/bin
  ${HOME}/.rbenv/shims
  ${HOME}/.cargo/bin
  ${HOME}/.cabal/bin
  ${HOME}/.nodenv/bin
  ${HOME}/.nodenv/shims
  ${HOME}/.node-build/bin
  ${HOME}/.luarocks/bin
  ${HOME}/.local/bin
  ${HOME}/Library/Python/3.7/bin
  ${HOME}/Library/Python/2.7/bin
  ${HOME}/.gem/ruby/2.3.0/bin
  ${HOME}/.gem/ruby/2.5.0/bin
  ${HOME}/bin
  /snap/bin
  /usr/local/{bin,sbin}
  $path
)

cdpath=(
  .
  ${HOME}
  $(go env GOPATH)/src
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

PROMPT_LEAN_VIMODE=1

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK
fi
