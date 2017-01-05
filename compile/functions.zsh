for file in ${ZSH}/functions/^(*.zwc)(.); do
  zcompare ${file}
done
