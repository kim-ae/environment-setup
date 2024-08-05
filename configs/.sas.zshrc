copy-context(){
    cp $LINUX_SETUP_HOME/configs/.sas.p10k.zsh $HOME/.p10k.zsh
    cp $LINUX_SETUP_HOME/configs/sas.kube.config.yaml $HOME/.kube/config
}
update-context-files(){
    cp $HOME/.p10k.zsh $LINUX_SETUP_HOME/linux-setup/configs/.sas.p10k.zsh
    cp $HOME/.kube/config $LINUX_SETUP_HOME/linux-setup/configs/sas.kube.config.yaml
}

mkdir -p $HOME/sas

alias kubility="code ~/sas/"
alias connect-vpn="sudo tailscale up --operator=$USER --accept-routes=true --advertise-exit-node=false --shields-up=true --stateful-filtering"
alias disconnect-vpn="tailscale down"