if (( $+commands[gitjk_cmd] )); then
  alias gitjk="history -n | tail -n 10 | (tac || tail -r) | gitjk_cmd"
fi

if (( $+commands[hub] )); then
  eval "$(hub alias -s)"
fi

_git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)'
_git_log_brief_format='%C(green)%h%C(reset) %s %C(blue)(%ar by %an)%C(red)%d%C(reset)'

unalias gb
unalias grc
alias gbr='git branch'
alias gcam='git commit --verbose --all --message'
