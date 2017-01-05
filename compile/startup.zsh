for file in ${ZSH}/startup/^(*.zwc)(.); do
  zcompare ${file}
done
