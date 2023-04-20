#!/bin/bash

## Created by Gabriel Barbato to install Zoom - https://github.com/barbatoo

echo "Instalação do Zoom iniciada..."

  curl -o /tmp/zoomusInstallerFull.pkg "https://cdn.zoom.us/prod/5.14.2.17213/zoomusInstallerFull.pkg"

  sudo installer -pkg /tmp/zoomusInstallerFull.pkg -target /

  rm /tmp/zoomusInstallerFull.pkg

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/zoom.us.app" ] 
then
    echo "O Zoom foi instalado com sucesso!"
    exit 0
else
    echo "O Zoom não pode ser instalado."
    exit 1
fi