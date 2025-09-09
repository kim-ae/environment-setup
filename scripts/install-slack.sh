#!/bin/bash

echo "Install Slack and Discord"

sudo apt install -y alien

wget https://downloads.slack-edge.com/desktop-releases/linux/x64/${SLACK_VERSION}/slack-${SLACK_VERSION}-0.1.el8.x86_64.rpm

sudo alien slack-${SLACK_VERSION}-0.1.el8.x86_64.rpm

sudo apt install -y ./slack_${SLACK_VERSION}-1.1_amd64.deb

wget https://dl.discordapp.net/apps/linux/${DISCORD_VERSION}/discord-${DISCORD_VERSION}.deb

sudo apt install -y ./discord-${DISCORD_VERSION}.deb && rm discord-${DISCORD_VERSION}.deb