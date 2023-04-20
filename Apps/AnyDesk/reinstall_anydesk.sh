#!/bin/bash

## Created by Gabriel Barbato to reinstall AnyDesk - https://github.com/barbatoo

killal AnyDesk

rm -rf /Applications/AnyDesk.app
echo "AnyDesk desinstalado, iniciando reinstalação..."

echo "AnyDesk está sendo instalado..."

curl -o /tmp/anydesk.dmg "https://download.anydesk.com/anydesk.dmg"

hdiutil mount -nobrowse /tmp/anydesk.dmg

cp -R "/Volumes/AnyDesk/AnyDesk.app" "/Applications/"

hdiutil detach "/Volumes/AnyDesk"

rm /tmp/anydesk.dmg

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/AnyDesk.app" ]
then
    echo "O AnyDesk foi instalado com sucesso!"
    exit 0
else
    echo "O AnyDesk não pode ser instalado."
    exit 1
fi
