# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Insert 'sudo ' at the beginning of the line.
bindkey "$key_info[Control]X$key_info[Control]S" prepend-sudo

# Edit command in an external editor.
bindkey -M vicmd "v" edit-command-line

# Undo/Redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "$key_info[Control]R" redo

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M vicmd "?" history-incremental-pattern-search-backward
  bindkey -M vicmd "/" history-incremental-pattern-search-forward
else
  bindkey -M vicmd "?" history-incremental-search-backward
  bindkey -M vicmd "/" history-incremental-search-forward
fi

# Reduce time between insert and normal mode switching
export KEYTIMEOUT=1

# Use vim cli mode
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history

# ^w and ^h working even after returning from command mode
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^h' backward-delete-char

bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^b' vi-backward-char
bindkey -M viins '^f' vi-forward-char
bindkey -M viins '^e' vi-end-of-line
bindkey -M viins '^u' backward-kill-line

# ctrl-r starts searching history backward
bindkey -M viins '^r' history-incremental-search-backward

# meta-b and meta-f move back and forward by word while in insert mode
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[f' forward-word
bindkey -M viins '^[d' kill-word

# insert the contents of the kill buffer
bindkey -M viins '^y' yank

# kill from the cursor to the end of the line
bindkey -M viins '^k' kill-line

# incrementally undo the last text modification
bindkey -M viins '^_' undo
