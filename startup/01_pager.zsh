if [ -d ${HOME}/.vim/plugged/vimpager ]; then
  path[1,0]=${HOME}/.vim/plugged/vimpager
  manpath[1,0]=${HOME}/.vim/plugged/vimpager
fi

if (( $#commands[vimpager] )); then
  export PAGER=vimpager
  export MANPAGER=vimpager

  # vimpager is broken on neovim which may be picked up from $EDITOR,
  # force it to use regular vim
  export VIMPAGER_VIM=vim
fi
