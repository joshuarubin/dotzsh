if [[ -s ${HOME}/.gvm/scripts/gvm ]]; then
  source ${HOME}/.gvm/scripts/gvm

  if [[ -s ${HOME}/.gvm/scripts/completion ]]; then
    source ${HOME}/.gvm/scripts/completion
  fi

  GOPATH=${HOME}/go
fi
