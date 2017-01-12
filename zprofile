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

if (( $#commands[nvim] )); then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export MANPAGER="nvim -c 'set ft=man' -"
fi

manpath=('')

if [ -d ${HOME}/.vim/plugged/vimpager ]; then
  path[1,0]=${HOME}/.vim/plugged/vimpager
  manpath[1,0]=${HOME}/.vim/plugged/vimpager
fi

if (( $#commands[vimpager] )); then
  export PAGER=vimpager
  export MANPAGER=vimpager
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
typeset -gU cdpath fpath mailpath path manpath

GOPATH=${HOME}/go

if [[ -x /usr/local/include ]]; then
  export CGO_CFLAGS="-I/usr/local/include"
fi

if [[ -x /usr/local/lib ]]; then
  export CGO_LDFLAGS="-L/usr/local/lib"
fi

# Set the list of directories that Zsh searches for programs.
path=(
  ${GOPATH}/bin
  ${HOME}/.rbenv/bin
  ${HOME}/.rbenv/shims
  ${HOME}/.cargo/bin
  ${HOME}/.cabal/bin
  ${HOME}/.nodenv/bin
  ${HOME}/.nodenv/shims
  ${HOME}/.node-build/bin
  ${HOME}/.fzf/bin
  ${HOME}/bin
  /usr/local/{bin,sbin}
  $path
)

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

export GREP_COLOR='1;33'            # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

if [[ ${PAGER} == 'less' ]]; then
  export LESS_TERMCAP_mb=$'\E[1;31m'    # Begins blinking.
  export LESS_TERMCAP_md=$'\E[1;31m'    # Begins bold.
  export LESS_TERMCAP_me=$'\E[0m'       # Ends mode.
  export LESS_TERMCAP_se=$'\E[0m'       # Ends standout-mode.
  export LESS_TERMCAP_so=$'\E[7m'       # Begins standout-mode.
  export LESS_TERMCAP_ue=$'\E[0m'       # Ends underline.
  export LESS_TERMCAP_us=$'\E[1;32m'    # Begins underline.
fi

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if [[ -d ${HOME}/.fzf ]]; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='
    --inline-info
    --ansi
    --color fg:-1,bg:-1,hl:67,fg+:110,bg+:-1,hl+:67
    --color info:229,prompt:242,pointer:73,marker:131,spinner:240
  '
  export FZF_CTRL_R_OPTS='--exact'
  manpath[1,0]=${HOME}/.fzf/man
fi

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# BSD Core Utilities
# Define colors for BSD ls.
export LSCOLORS='exfxcxdxbxGxDxabagacad'

# Define colors for the completion system.
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
