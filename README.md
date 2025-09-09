# Pre-requisites

* Linux Mint

# Steps
1. Install git `sudo apt install git -y`
2. Import SSH Key to github
```sh
echo "Create ssh key"
ssh-keygen -t ed25519 -C "kim.ae09@gmail.com"
echo "Copy the pub key and place on git tool"
echo "--------------------------------------"
cat $HOME/.ssh/id_ed25519.pub 
echo "--------------------------------------"
```
3. Execute `export MAIN_FOLDER="Documents" && export LINUX_SETUP_HOME="$HOME/$MAIN_FOLDER/linux-setup" && bootstrap.sh`

# Tooling that will be installed

- Git
- Docker
- kubectl
- kubectx
- flux
- kubelogin
- tailscale
- k9s
- code
- nordpass
- teams
- slack
- discord
- flameshot
- zsh
- oh my zsh
- p10k
- google chrome
- intelij
- hyper
- gcloud
- az
- discord
- minikube
- helm
- kubectl
- krew
  - ingress nginx
  - krew
  - rabbitmq
  - sniff
- brew
- kubeseal
- terraform
- flameshot
- linkerd
- cilium
- 
