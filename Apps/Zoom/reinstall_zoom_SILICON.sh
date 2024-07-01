#!/bin/bash

## Created by Gabriel Barbato to reinstall Zoom - https://github.com/barbatoo

ZOOM_PKG_URL="https://zoom.us/client/6.1.1.36333/zoomusInstallerFull.pkg?archType=arm64&amp_device_id=34d38e8b-35b2-4edc-b60b-6801962ed09e"
ZOOM_PKG_PATH="/tmp/zoomusInstallerFull.pkg"

killall zoom.us   

rm -rf "/Applications/zoom.us.app"
    echo "//////////////////// ZOOM DESINSTALADO, INICIANDO INSTALAÇÃO... ////////////////////"

curl -L -o "$ZOOM_PKG_PATH" "$ZOOM_PKG_URL"

sudo installer -pkg "$ZOOM_PKG_PATH" -target /

rm -rf "$ZOOM_PKG_PATH"

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/zoom.us.app" ] 
then
    echo "O Zoom foi atualizado com sucesso!"
    exit 0
else
    echo "O Zoom não pode ser atualizado."
    exit 1
fi