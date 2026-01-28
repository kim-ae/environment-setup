alias linux-setup="code $LINUX_SETUP_HOME"
alias use-minikube="kubectl config use-context minikube"
alias sandbox='cd ~/Document/sandbox'
alias pergaminhos='cd $KNOWLEDGE'
alias tc='cd ~/Code'
alias reload="source ~/.zshenv && source ~/.zshrc"
alias git-refresh="git checkout main && git pull"
alias push-zsh-changes="cp $LINUX_SETUP_HOME/configs/.zshrc $HOME/.zshrc"
alias load_desktop_config="dconf load /org/cinnamon/ < $LINUX_SETUP_HOME/configs/cinnamon-settings.conf"
alias save_desktop_config="dconf dump /org/cinnamon/ > $LINUX_SETUP_HOME/configs/cinnamon-settings.conf "
alias connect-vpn="sudo tailscale up --operator=$USER --accept-routes=true --advertise-exit-node=false --shields-up=true --stateful-filtering"
alias disconnect-vpn="tailscale down"
alias k="kubectl"
alias code_kim7s="code $HOME/github/kimbernetes-k8s-flux"