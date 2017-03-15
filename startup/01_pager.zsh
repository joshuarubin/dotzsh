if [ -d ${HOME}/.vim/plugged/vimpager ]; then
  path[1,0]=${HOME}/.vim/plugged/vimpager
  manpath[1,0]=${HOME}/.vim/plugged/vimpager
fi

if (( $#commands[nvim] )); then
  export MANPAGER="nvim -c 'set ft=man' -"
fi

if (( $#commands[vimpager] )); then
  export PAGER=vimpager
  export MANPAGER=vimpager
fi
