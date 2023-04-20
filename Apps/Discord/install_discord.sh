#!/bin/bash

## Created by Gabriel Barbato to install Discord - https://github.com/barbatoo

echo "Instalando o Discord..."

curl -o /tmp/discord.dmg "https://dl.discordapp.net/apps/osx/0.0.274/Discord.dmg"

hdiutil attach -nobrowse /tmp/discord.dmg

cp -R "/Volumes/Discord/Discord.app" "/Applications/"

hdiutil detach "/Volumes/Discord"

rm /tmp/discord.dmg

if [ -d "/Applications/Discord.app" ]
then
    echo "O Discord foi instalado com sucesso!"
    exit 0
else
    echo "O Discord não pode ser instalado."
    exit 1
fi
