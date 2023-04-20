#!/bin/bash

## Created by Gabriel Barbato to reinstall Zoom - https://github.com/barbatoo

killall zoom.us   

rm -rf "/Applications/zoom.us.app"
    echo "//////////////////// ZOOM DESINSTALADO, INICIANDO INSTALAÇÃO... ////////////////////"

  curl -o /tmp/zoomusInstallerFull.pkg "https://cdn.zoom.us/prod/5.14.2.17213/zoomusInstallerFull.pkg"

  sudo installer -pkg /tmp/zoomusInstallerFull.pkg -target /

  rm /tmp/zoomusInstallerFull.pkg

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