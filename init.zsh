#
# Executes commands at the start of an interactive session
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

bundle_init=$ZSH/bundle.init

update-bundles() {(
  local bundles
  local bundle
  local files
  local file

  bundles=("${(@f)$(cat $ZSH/bundle.list)}")

  for bundle in $bundles; do
    echo $bundle

    if [ ! -d "$ZSH/bundles/$bundle" ]; then
      mkdir -p "$ZSH/bundles/${bundle:h}"
      git clone --recursive git@github.com:$bundle.git "$ZSH/bundles/$bundle"
    else
      cd $ZSH/bundles/$bundle
      git pull
      git submodule update --init --recursive
    fi
  done

  rm -f $bundle_init
  touch $bundle_init

  cd $ZSH
  for bundle in $bundles; do
    files=bundles/$bundle/*.plugin.zsh
    for file in $~files; do
      echo source \$ZSH/$file >> $bundle_init
    done
  done

  echo >> $bundle_init

  for bundle in $bundles; do
    echo fpath+=\$ZSH/bundles/$bundle >> $bundle_init
  done
)}

# Source the Prezto configuration file.
if [[ -s "${ZDOTDIR:-$HOME}/.zpreztorc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zpreztorc"
fi

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':prezto:*:*' color 'no'
  zstyle ':prezto:module:prompt' theme 'off'
fi

if [ ! -e "$bundle_init" ]; then
  update-bundles
fi

if [ -r "$bundle_init" ]; then
  source $bundle_init
fi
