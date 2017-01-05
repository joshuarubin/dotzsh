for file in ${ZSH}/completion/^(*.zwc)(.); do
  zcompare ${file}
done
