#
# Executes commands at the start of an interactive session.
#

zmodules=(directory environment spectrum git ssh history input meta \
          prompt syntax-highlighting history-substring-search completion)

zprompt_theme='pure'

zhighlighters=(main brackets pattern cursor root line)

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

autoload -Uz bashcompinit
bashcompinit

if [[ -d ${ZSH}/functions ]]; then
  fpath[1,0]=${ZSH}/functions

  for func in ${ZSH}/functions/*(-.N:t); do
    autoload -Uz ${func}
  done
fi

if [[ -d ${ZSH}/completion ]]; then
  for file in ${ZSH}/completion/^(*.zwc)(-.N); do
    source ${file}
  done
fi

if [[ -d ${ZSH}/startup ]]; then
  for file in ${ZSH}/startup/^(*.zwc)(-.N); do
    source ${file}
  done
fi

# remove non-existent directories from $PATH
path=($^path(N))

path=(
  bin
  node_modules/.bin
  $path
)
