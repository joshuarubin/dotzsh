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
alias b='${(z)BROWSER}'
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

if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if [[ -s "$HOME/.dir_colors" ]]; then
    eval "$(dircolors --sh "$HOME/.dir_colors" 2> /dev/null)"
  else
    eval "$(dircolors --sh 2> /dev/null)"
  fi

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  if [[ $OSTYPE == openbsd* ]]; then
    if (( ${+commands[colorls]} )); then
      alias ls='colorls -G'
    fi
  else
    alias ls='ls -G'
  fi
fi

if [[ ${OSTYPE} == openbsd* ]]; then
  if (( ${+commands[ggrep]} )); then
    alias grep='ggrep --color=auto'
  fi
else
  alias grep='grep --color=auto'
fi

[[ -n ${PAGER} ]] && alias lm="ls -lhA | ${PAGER}" # all files, human-readable sizes, use pager

alias l='ls -1A'    # Lists in one column, hidden files.
alias la='ls -lhA'  # Lists human readable sizes, hidden files.
alias lr='ls -lhR'  # Lists human readable sizes, recursively.
alias lx='ls -lhXB' # Lists sorted by extension (GNU only).
alias lk='ls -lhSr' # Lists sorted by size, largest last.
alias lt='ls -lhtr' # Lists sorted by date, most recent last.
alias lc='ls -lhc'  # Lists sorted by date, most recent last, shows change time.
alias lu='ls -lhu'  # Lists sorted by date, most recent last, shows access time.

alias v='ls -lh'
alias sl='ls'

alias c='clear'
alias cdc='cd && clear'
alias screen="screen -T ${TERM}"
alias json='python -mjson.tool'

if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias listeners='lsof -nPiTCP | grep LISTEN'
  alias tmux='tmux -f ~/.tmux-osx.conf'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
else
  alias o='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
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

alias du='du -kh'

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

if [[ -d /usr/local/share/zsh/help ]]; then
  autoload run-help
  HELPDIR=/usr/local/share/zsh/help
fi
