if [[ -s ${HOME}/.gvm/scripts/gvm ]]; then
  source ${HOME}/.gvm/scripts/gvm

  if [[ -s ${HOME}/.gvm/scripts/completion ]]; then
    source ${HOME}/.gvm/scripts/completion
  fi
fi

GOPATH=${HOME}/go
cdpath+=${GOPATH}/src

if [[ -x /usr/local/include ]]; then
  export CGO_CFLAGS="-I/usr/local/include"
fi

if [[ -x /usr/local/lib ]]; then
  export CGO_LDFLAGS="-L/usr/local/lib"
fi
