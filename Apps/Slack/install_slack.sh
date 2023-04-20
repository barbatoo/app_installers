#!/bin/bash

## Created by Gabriel Barbato to install Slack - https://github.com/barbatoo

echo "Slack sendo instalado..."

curl -o /tmp/Slack-4.31.156-macOS.dmg "https://downloads.slack-edge.com/releases/macos/4.31.156/prod/universal/Slack-4.31.156-macOS.dmg"

hdiutil mount -nobrowse /tmp/Slack-4.31.156-macOS.dmg

cp -R "/Volumes/Slack/Slack.app" "/Applications/"

hdiutil detach "/Volumes/Slack"

rm /tmp/Slack-4.31.156-macOS.dmg

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Slack.app" ] 
then
    echo "O Slack foi instalado com sucesso!"
    exit 0
else
    echo "O Slack não pode ser instalado."
    exit 1
fi