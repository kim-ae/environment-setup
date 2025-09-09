#!/bin/bash

cd $HOME

echo "Install Tailscale"
curl -fsSL https://tailscale.com/install.sh | sh

echo "Install Flameshot"
sudo apt-get update
sudo apt-get install -y flameshot