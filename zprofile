#
# Executes commands at login pre-zshrc.
#

export ZSH=${HOME}/.dotfiles/zsh

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export PAGER='less'

if (( $#commands[vim] )); then
  export EDITOR="vim"
  export VISUAL="vim"
fi

manpath=('')

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
typeset -gU cdpath fpath mailpath path manpath

export MANPATH

GOPATH=${HOME}/go

if [[ -d /usr/local/include ]]; then
  export CGO_CFLAGS="-I/usr/local/include"
fi

if [[ -d /usr/local/lib ]]; then
  export CGO_LDFLAGS="-L/usr/local/lib"
fi

# Set the list of directories that Zsh searches for programs.
path=(
  ${GOPATH}/bin
  ${HOME}/.yarn/bin
  ${HOME}/.rbenv/bin
  ${HOME}/.rbenv/shims
  ${HOME}/.cargo/bin
  ${HOME}/.cabal/bin
  ${HOME}/.nodenv/bin
  ${HOME}/.nodenv/shims
  ${HOME}/.node-build/bin
  ${HOME}/.fzf/bin
  ${HOME}/.local/bin
  ${HOME}/bin
  ${HOME}/.linuxbrew/bin
  /home/linuxbrew/.linuxbrew/bin
  /usr/local/{bin,sbin}
  $path
)

if (( $#commands[perl] )); then
  path[1,0]=$(perl -V:prefix | cut -d"'" -f2)/bin
fi

cdpath=(
  .
  ${HOME}
  ${GOPATH}/src
)

# remove non-existent directories
path=($^path(N))
cdpath=($^cdpath(N))

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

#
# Temporary Files
#

if [[ -z "${TMPDIR}" ]]; then
  if [[ -d /var/tmp && -w /var/tmp ]]; then
    export TMPDIR=/var/tmp
  elif [[ -d /tmp && -w /tmp ]]; then
    export TMPDIR=/tmp
  fi
fi

if [[ -n "${XDG_RUNTIME_DIR}" && -z "${TMPDIR}" ]]; then
  export TMPDIR=${XDG_RUNTIME_DIR}
fi

export RBENV_SHELL=zsh
export NODENV_SHELL=zsh

if [[ -e /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2> /dev/null)
  export STUDIO_JDK=$JAVA_HOME/../..
  STUDIO_JDK=$STUDIO_JDK:A
fi

if [[ -f ${HOME}/.fzf.conf ]]; then
  source ${HOME}/.fzf.conf
fi

if [[ -d ${HOME}/.fzf ]]; then
  manpath[1,0]=${HOME}/.fzf/man
fi

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Setup prompt
zprompt_theme='lean'
PROMPT_LEAN_VIMODE=1
