copy-context(){
    cp ~/github/linux-setup/configs/.sas.p10k.zsh ~/.p10k.zsh
    cp ~/github/linux-setup/configs/sas.kube.config.yaml ~/.kube/config
}
update-context-files(){
    cp ~/.p10k.zsh ~/github/linux-setup/configs/.sas.p10k.zsh
    cp ~/.kube/config ~/github/linux-setup/configs/sas.kube.config.yaml
}
source ~/.sas.ids.zshrc
source ~/.sas.secrets.zshrc
source ~/.sas.zshrc
alias kubility="i ~/repo/"
alias connect-vpn="sudo tailscale up --operator=$USER --accept-routes=true --advertise-exit-node=false --shields-up=true --stateful-filtering"
alias disconnect-vpn="tailscale down"