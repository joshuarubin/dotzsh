typeset -UTx KUBECONFIG kubeconfig

if [[ -s $HOME/.kube/config ]]; then
  kubeconfig+=$HOME/.kube/config
fi

if [[ -x $HOME/.kube/config.d ]]; then
  kubeconfig+=($HOME/.kube/config.d/**/*)
fi
