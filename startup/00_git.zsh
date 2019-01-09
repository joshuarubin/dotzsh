if (( $+commands[gitjk_cmd] )); then
  alias gitjk="history -n | tail -n 10 | (tac || tail -r) | gitjk_cmd"
fi

if (( $+commands[hub] )); then
  alias git=hub
fi

_git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)'
_git_log_brief_format='%C(green)%h%C(reset) %s %C(blue)(%ar by %an)%C(red)%d%C(reset)'

unalias gb
unalias grc
alias gbr='git branch'
alias gcam='git commit --signoff --verbose --all --message'

# add --signoff to default git aliases
alias gc='git commit --signoff --verbose'
alias gca='git commit --signoff --verbose --all'
alias gcm='git commit --signoff --message'
alias gcf='git commit --signoff --amend --reuse-message HEAD'
alias gcF='git commit --signoff --verbose --amend'
alias gcS='git commit --signoff -S'
alias gws='git status'
