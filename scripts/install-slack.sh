#!/bin/bash

echo "Install Slack and Discord"

sudo apt install -y alien

wget https://downloads.slack-edge.com/desktop-releases/linux/x64/4.39.88/slack-4.39.88-0.1.el8.x86_64.rpm

sudo alien slack-4.39.88-0.1.el8.x86_64.rpm

sudo apt install -y ./slack_4.39.88-1.1_amd64.deb

wget https://dl.discordapp.net/apps/linux/0.0.62/discord-0.0.62.deb

sudo apt install -y ./discord-0.0.62.deb && rm discord-0.0.62.deb