#!/bin/bash

cd $HOME

cp $HOME/Documents/linux-setup/configs/.zshrc $HOME

curl -fsSL https://tailscale.com/install.sh | sh

source $HOME/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

copy-context

reload 

cd $HOME/$MAIN_FOLDER

git clone git@github.com:kim-ae/pergaminhos.git

dconf load /org/cinnamon/ < $HOME/Documents/linux-setup/configs/cinnamon-settings.conf  

