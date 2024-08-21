#!/bin/bash

cd $HOME/Documents
git clone git@github.com:kim-ae/linux-setup.git

cd $HOME

cp $HOME/Documents/linux-setup/configs/.zshrc $HOME

curl -fsSL https://tailscale.com/install.sh | sh

source $HOME/.zshrc

cd $HOME/$MAIN_FOLDER

git clone git@github.com:kim-ae/pergaminhos.git

dconf load /org/cinnamon/ < $HOME/Documents/linux-setup/configs/cinnamon-settings.conf  