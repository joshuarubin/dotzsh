#
# User configuration sourced by interactive shells
#

setopt EXTENDED_GLOB NO_NOMATCH

fpath[1,0]=${ZSH}/functions
autoload -U compinit && compinit

for func in ${ZSH}/functions/*(-.N:t); do
  autoload -Uz ${func}
done
unset func

# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

autoload -Uz bashcompinit && bashcompinit

for file in ${ZSH}/{completion,startup}/^(*.zwc|*.zwc.old)(-.N); do
  source ${file}
done
unset file

# remove non-existent directories
path=($^path(N))
cdpath=($^cdpath(N))

# add relative directories to path
path=(
  bin
  node_modules/.bin
  $path
)
