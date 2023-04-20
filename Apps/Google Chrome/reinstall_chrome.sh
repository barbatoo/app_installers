#!/bin/bash

## Created by Gabriel Barbato to reinstall Chrome - https://github.com/barbatoo

sudo killall Google\ Chrome

rm -rf "/Applications/Google Chrome.app"
    echo "Google Chrome desinstalado, iniciando reinstalação..."

curl -o /tmp/googlechrome.dmg "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"

hdiutil mount -nobrowse /tmp/googlechrome.dmg

cp -R "/Volumes/Google Chrome/Google Chrome.app" "/Applications/"

hdiutil detach "/Volumes/Google Chrome"

rm /tmp/googlechrome.dmg

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Google Chrome.app" ] 
then
    echo "O Google Chrome foi atualizado com sucesso!"
    exit 0
else
    echo "O Google Chrome não pode ser atualizado."
    exit 1
fi