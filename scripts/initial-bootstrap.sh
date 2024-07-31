#!/bin/bash

echo "Installing git, zsh and oh my zsh
sudo apt install git -y
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo chsh -s $(which zsh)

echo "Create ssh key"
ssh-keygen -t ed25519 -C "kim.ae09@gmail.com"
echo "Copy the pub key and place on git tool"
echo "--------------------------------------"
cat $HOME/.ssh/id_ed25519.pub 
echo "--------------------------------------"

echo "Download and install hyper and tool"
wget https://github.com/vercel/hyper/releases/download/v3.4.1/hyper_3.4.1_amd64.deb -P $HOME/Downloads
sudo apt install ./Downloads/hyper_3.4.1_amd64.deb
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1e16e1e6214d7c44d078b1f0607b2388f29d729/code_1.91.1-1720564633_amd64.deb -P $HOME/Downloads
sudo apt install ./Downloads/code_1.91.1-1720564633_amd64.deb

echo "Restart the session"