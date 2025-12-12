#!/bin/bash

# Define version variables

echo "Update package lists and upgrade existing packages"
sudo mv /etc/apt/preferences.d/nosnap.pref /etc/apt/preferences.d/nosnap.backup
sudo apt update

echo "Install Snap"
sudo apt install -y snapd

echo "Configure fonts"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/RobotoMono.zip && \
mkdir -p ~/.local/share/fonts && \
unzip RobotoMono.zip -d ~/.local/share/fonts/ && \
rm RobotoMono.zip

echo "Configure cinnamon settings"
dconf load /org/cinnamon/ < $LINUX_SETUP_HOME/configs/cinnamon-settings.conf  

echo "Installing zsh and oh my zsh"
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s $(which zsh)

echo "Install p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Install oh-my-posh"
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "Install VS Code"
snap install code

echo "Install vim"
sudo apt install -y vim

echo "Install Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-${CHROME_VERSION}_amd64.deb && \
    sudo apt install -y ./google-chrome-${CHROME_VERSION}_amd64.deb && \
    rm google-chrome-${CHROME_VERSION}_amd64.deb

echo "install jq"
sudo apt-get install -y jq

echo "Install Flatpak"
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak

echo "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install Obsidian"
flatpak install flathub md.obsidian.Obsidian

echo "Install CopyQ"
sudo apt install -y copyq

echo "Install Flameshot"
sudo apt-get install -y flameshot

echo "Install kitty"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

cp $LINUX_SETUP_HOME/configs/.zshrc $HOME/.zshrc
cp $LINUX_SETUP_HOME/configs/.custom.envs $HOME/.custom.envs

echo ". $HOME/.custom.envs" >> "$HOME/.zshenv"

echo "Restart the session"