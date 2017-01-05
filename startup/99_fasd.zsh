alias z='fasd_cd -di'
alias j="fasd_cd -di"
alias e="fasd -ftie nvim -b nviminfo" # quick opening files with vim
alias nv="fasd -ftib nviminfo"

if (( $+commands[fzf-tmux] )); then
  fasd_i() {
    fasd -l "$@" | fzf-tmux --tac --no-sort
  }

  fasd_i_cd() {
    local _fasd_all=$(fasd -ld "$@")
    [ -z "$_fasd_all" ] && return
    if [ "$(echo "$_fasd_all" | wc -l)" -eq 1 ]; then
      cd "$_fasd_all"
      return
    fi
    local _fasd_ret="$(fasd -ld "$@" | fzf-tmux --tac --no-sort)"
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  }

  fasd_i_e() {
    local _fasd_all=$(fasd -lfb nviminfo "$@")
    [ -z "$_fasd_all" ] && return
    if [ "$(echo "$_fasd_all" | wc -l)" -eq 1 ]; then
      nvim "$_fasd_all"
      return
    fi
    local _fasd_ret="$(fasd -lfb nviminfo "$@" | fzf-tmux --tac --no-sort)"
    [ -f "$_fasd_ret" ] && nvim "$_fasd_ret" || printf %s\n "$_fasd_ret"
  }

  alias s="fasd_i"
  alias sd="fasd_i -d"
  alias sf="fasd_i -f"
  alias zz="fasd_i_cd"

  alias z="fasd_i_cd"
  alias j="fasd_i_cd"
  alias e="fasd_i_e"
  alias nv="fasd_i -ftb nviminfo"
fi
