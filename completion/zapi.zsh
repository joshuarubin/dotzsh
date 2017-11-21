_zapi_autocomplete() {
  local -a opts
  opts=("${(@f)$(${words[@]:0:#words[@]-1} --compgen)}")

  _describe 'values' opts

  return
}

compdef _zapi_autocomplete zapi
