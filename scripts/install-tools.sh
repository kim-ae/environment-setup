#!/bin/bash

cd $HOME

echo "Install Tailscale"
curl -fsSL https://tailscale.com/install.sh | sh

echo "Install Slack"
sudo snap install slack