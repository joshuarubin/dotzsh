#
# Executes commands at the start of an interactive session.
#

setopt EXTENDED_GLOB

fpath[1,0]=${ZSH}/functions

for func in ${ZSH}/functions/*(-.N:t); do
  autoload -Uz ${func}
done

zmodules=(archive directory environment git ssh history input \
          syntax-highlighting history-substring-search completion pacman git-info \
          prompt autosuggestions)

zhighlighters=(main brackets pattern cursor root line)

zinput_mode=vi

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

autoload -Uz bashcompinit && bashcompinit

for file in ${ZSH}/{completion,startup}/^(*.zwc)(-.N); do
  source ${file}
done

# remove non-existent directories
path=($^path(N))
cdpath=($^cdpath(N))

# add relative directories to path
path=(
  bin
  node_modules/.bin
  $path
)

autoload -Uz promptinit && promptinit
