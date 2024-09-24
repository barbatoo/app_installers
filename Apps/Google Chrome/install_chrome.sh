#!/bin/bash

## Created by Gabriel Barbato to install Chrome - https://github.com/barbatoo

echo "Instalação do Google Chrome iniciada..."

curl -o /tmp/googlechrome.dmg "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"

hdiutil mount -nobrowse /tmp/googlechrome.dmg

cp -R "/Volumes/Google Chrome/Google Chrome.app" "/Applications/"

hdiutil detach "/Volumes/Google Chrome"

rm /tmp/googlechrome.dmg

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Google Chrome.app" ] 
then
    echo "O Google Chrome foi instalado com sucesso!"
    exit 0
else
    echo "O Google Chrome não pode ser instalado."
    exit 1
fi