_zb_autocomplete() {
     COMPREPLY=()
     local cur="${COMP_WORDS[COMP_CWORD]}"
     local opts=$( ${COMP_WORDS[@]:0:$COMP_CWORD} --compgen )
     COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
     return 0
 }

 complete -o default -F _zb_autocomplete zb
