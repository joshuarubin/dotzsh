# $PAGER is set in zprofile

if (( $#commands[vimpager] )); then
  eval "
    function less {
      'vimpager' \"\$@\"
    }
  "

  eval "
    function zless {
      'vimpager' \"\$@\"
    }
  "
fi

if (( $#commands[vimcat] )); then
  eval "
    function cat {
      'vimcat' \"\$@\"
    }
  "
fi

