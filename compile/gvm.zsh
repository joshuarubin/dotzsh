if [[ -d ${HOME}/.gvm ]]; then
  for file in ${HOME}/.gvm/scripts{,/env}/^(*.zwc)(.); do
    zcompare ${file}
  done
fi
