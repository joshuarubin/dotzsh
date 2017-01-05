if [[ -d ${HOME}/.rvm ]]; then
  for file in ${HOME}/.rvm/scripts/^(*.zwc|*.rb|irbrc)(.); do
    zcompare ${file}
  done
fi
