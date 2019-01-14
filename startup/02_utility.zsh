# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'
alias grunt='nocorrect grunt'

# Disable globbing.
alias bower='noglob bower'
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'

# Define general aliases.
#alias sudo='sudo '
alias _='sudo '
alias cp="${aliases[cp]:-cp} -i"

# alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
#alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'
alias reload!='. ~/.zshrc'

alias rg='rg --smart-case'

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
#alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

stty -ixon

function is-callable {
  (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

if (( ${terminfo[colors]} >= 8 )); then
  # ls Colors
  if is-callable 'dircolors'; then
    # GNU
    if [[ -s ${HOME}/.dir_colors ]]; then
      eval "$(dircolors --sh ${HOME}/.dir_colors)"
    else
      eval "$(dircolors --sh)"
    fi

    alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
  else
    # BSD

    # colors for ls and completion
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

    # stock OpenBSD ls does not support colors at all, but colorls does.
    if [[ $OSTYPE == openbsd* ]]; then
      if (( ${+commands[colorls]} )); then
        alias ls='colorls -G'
      fi
    else
      alias ls="${aliases[ls]:-ls} -G"
    fi
  fi

  # grep Colors
  export GREP_COLOR='1;33'              # BSD
  export GREP_COLORS="mt=${GREP_COLOR}" # GNU
  if [[ ${OSTYPE} == openbsd* ]]; then
    if (( ${+commands[ggrep]} )); then
      alias grep='ggrep --color=auto'
    fi
  else
   alias grep='grep --color=auto'
  fi

  # less Colors
  if [[ ${PAGER} == 'less' ]]; then
    export LESS_TERMCAP_mb=$'\E[1;31m'    # Begins blinking.
    export LESS_TERMCAP_md=$'\E[1;31m'    # Begins bold.
    export LESS_TERMCAP_me=$'\E[0m'       # Ends mode.
    export LESS_TERMCAP_se=$'\E[0m'       # Ends standout-mode.
    export LESS_TERMCAP_so=$'\E[7m'       # Begins standout-mode.
    export LESS_TERMCAP_ue=$'\E[0m'       # Ends underline.
    export LESS_TERMCAP_us=$'\E[1;32m'    # Begins underline.
  fi
fi

alias l='ls -lAh'         # all files, human-readable sizes
[[ -n ${PAGER} ]] && alias lm="l | ${PAGER}" # all files, human-readable sizes, use pager
alias ll='ls -lh'         # human-readable sizes
alias lr='ll -R'          # human-readable sizes, recursive
alias lx='ll -XB'         # human-readable sizes, sort by extension (GNU only)
alias lk='ll -Sr'         # human-readable sizes, largest last
alias lt='ll -tr'         # human-readable sizes, most recent last
alias lc='lt -c'          # human-readable sizes, most recent last, change time

alias v='ll'

alias c='clear'
alias cdc='cd && clear'
alias screen="screen -T ${TERM}"
alias json='python -mjson.tool'
alias tmux='tmux -f ~/.tmux/not-tmate.conf'

if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias listeners='lsof -nPiTCP | grep LISTEN'
  alias tmux='tmux -f ~/.tmux/osx.conf'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
elif [[ -n "$WAYLAND_DISPLAY" && $+commands[wl-copy] && $+commands[wl-paste] ]]; then
  alias o='xdg-open'
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste --no-newline'
elif [[ -n "$DISPLAY" && $+commands[xclip] ]]; then
  alias o='xdg-open'
  alias pbcopy='xclip -selection clipboard -in'
  alias pbpaste='xclip -selection clipboard -out'
elif [[ -n "$DISPLAY" && $+commands[xsel] ]]; then
  alias o='xdg-open'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
elif [[ $+commands[lemonade] ]]; then
  alias o='lemonade open'
  alias pbcopy='lemonade copy'
  alias pbpaste='lemonade paste'
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# order of preference: aria2c, axel, wget, curl. This order is derrived from speed based on personal tests.
if (( ${+commands[aria2c]} )); then
  alias get='aria2c --max-connection-per-server=5 --continue'
elif (( ${+commands[axel]} )); then
  alias get='axel --num-connections=5 --alternate'
elif (( ${+commands[wget]} )); then
  alias get='wget --continue --progress=bar --timestamping'
elif (( ${+commands[curl]} )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
fi

alias du="${aliases[du]:-du} -kh"
alias df="${aliases[df]:-df} -kh"

if (( $+commands[htop] )); then
  alias top=htop
fi

if [[ "$OSTYPE" == (darwin*|*bsd*) ]]; then
  alias topc='top -o cpu'
  alias topm='top -o vsize'
else
  alias topc='top -o %CPU'
  alias topm='top -o %MEM'
fi

if [[ ${OSTYPE} == linux* ]]; then
  alias chmod='chmod --preserve-root -v'
  alias chown='chown --preserve-root -v'
fi

# not aliasing rm -i, but if safe-rm is available, use condom.
# if safe-rmdir is available, the OS is suse which has its own terrible 'safe-rm' which is not what we want
if (( ${+commands[safe-rm]} && ! ${+commands[safe-rmdir]} )); then
  alias rm='nocorrect safe-rm'
fi

if [[ -d /usr/local/share/zsh/help ]]; then
  autoload run-help
  HELPDIR=/usr/local/share/zsh/help
fi
