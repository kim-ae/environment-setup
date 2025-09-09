#!/bin/bash

echo "Configure fonts"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip && \
mkdir -p ~/.local/share/fonts && \
unzip RobotoMono.zip -d ~/.local/share/fonts/ && \
rm RobotoMono.zip

echo "Configure cinnamon settings"
dconf load /org/cinnamon/ < $LINUX_SETUP_HOME/configs/cinnamon-settings.conf  

echo "Installing zsh, oh my zsh and p10k"
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo chsh -s $(which zsh)

echo "Download and install hyper "
wget https://github.com/vercel/hyper/releases/download/v3.4.1/hyper_3.4.1_amd64.deb -P $HOME/Downloads && \
    sudo apt install ./Downloads/hyper_3.4.1_amd64.deb && \
    rm $HOME/Downloads/hyper_3.4.1_amd64.deb

echo "Install VS Code"
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1e16e1e6214d7c44d078b1f0607b2388f29d729/code_1.91.1-1720564633_amd64.deb -P $HOME/Downloads && \
    sudo apt install ./Downloads/code_1.91.1-1720564633_amd64.deb && \
    rm $HOME/Downloads/code_1.91.1-1720564633_amd64.deb

echo "Install vim"
sudo apt install -y vim

echo "Install Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

echo "install jq"
sudo apt-get install -y jq

echo "Install Flatpak"
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak

echo "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install Obsidian"
flatpak install flathub md.obsidian.Obsidian

echo "Restart the session"