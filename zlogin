#
# User configuration sourced by login shells
#

# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh

(
  local dir file
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  zrecompile -pq ${HOME}/.secrets

  for file in ${ZSH}/{completion,functions,startup}/^(*.zwc)(.); do
    zrecompile -pq ${file}
  done
) &!
