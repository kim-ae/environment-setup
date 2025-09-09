#!/bin/bash

echo "Install sdkman"
curl -s "https://get.sdkman.io" | bash

echo "Install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

echo "Install rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


## VIrtual Box
# sudo apt install dkms build-essential linux-headers-$(uname -r) -y
# sudo apt install curl wget apt-transport-https gnupg2
# curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg
# echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/vbox.gpg] http://download.virtualbox.org/virtualbox/debian noble contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
# sudo apt update

