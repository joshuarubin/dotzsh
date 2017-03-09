#
# Executes commands at the start of an interactive session.
#

setopt EXTENDED_GLOB

fpath[1,0]=${ZSH}/functions

for func in ${ZSH}/functions/*(-.N:t); do
  autoload -Uz ${func}
done

zmodules=(directory environment spectrum git ssh history input meta \
          syntax-highlighting history-substring-search completion git-info prompt)

zhighlighters=(main brackets pattern cursor root line)

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
