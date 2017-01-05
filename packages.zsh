zplug "joshuarubin/zsh-custom"
zplug "joshuarubin/zsh-environment"
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "joshuarubin/zsh-history"
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/helper", from:prezto
zplug "joshuarubin/zsh-completion"
zplug "joshuarubin/zsh-linuxbrew"
zplug "joshuarubin/zsh-git"
zplug "modules/ssh", from:prezto, if:"[[ "$OSTYPE" != darwin* ]] && (( $+commands[ssh-agent] ))"
zplug "modules/prompt", from:prezto
zplug "modules/command-not-found", from:prezto, if:"[[ -s '/etc/zsh_command_not_found' ]] || [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]"
zplug "joshuarubin/zsh-zmv"
zplug "joshuarubin/zsh-gvm"
zplug "joshuarubin/zsh-nodenv"
zplug "joshuarubin/zsh-java"
zplug "modules/python", from:prezto
zplug "joshuarubin/zsh-direnv"
zplug "joshuarubin/zsh-typescript"
zplug "joshuarubin/zsh-gnu-utility"
zplug "joshuarubin/zsh-utility", defer:1 # after gnu-utility
zplug "joshuarubin/zsh-grc"
zplug "joshuarubin/zsh-secrets"
zplug "joshuarubin/zsh-iterm2"
zplug "joshuarubin/zsh-rvm", defer:2 # after compinit
zplug "modules/syntax-highlighting", from:prezto, defer:2 # nice:15
zplug "modules/history-substring-search", from:prezto, defer:2 # nice:16
zplug "joshuarubin/zsh-autosuggestions", defer:2 # nice:17
zplug "joshuarubin/zsh-fzf", defer:2 # nice:18
zplug "joshuarubin/zsh-fasd", defer:3 # nice:19 # last, after fzf
