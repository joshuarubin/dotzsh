#
# Executes commands at the start of an interactive session.
#

fpath[1,0]=${ZSH}/functions

for func in ${ZSH}/functions/*(-.N:t); do
  autoload -Uz ${func}
done

if [[ ! ${TERM} == (linux|*bsd*|dumb) ]]; then
  autoload -Uz promptinit && promptinit
  prompt pure
fi

zmodules=(directory environment spectrum git ssh history input meta \
          syntax-highlighting history-substring-search completion)

zhighlighters=(main brackets pattern cursor root line)

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

autoload -Uz bashcompinit
bashcompinit

for file in ${ZSH}/{completion,startup}/^(*.zwc)(-.N); do
  source ${file}
done

# remove non-existent directories
path=($^path(N))
cdpath=($^cdpath(N))

path=(
  bin
  node_modules/.bin
  $path
)
