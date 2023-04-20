#!/bin/bash

## Created by Gabriel Barbato to update SuperPowered - https://github.com/barbatoo

if [ ! -d "/Applications/Superpowered.app" ]; then
  echo "O Superpowered não está instalado. Por favor, instale o Superpowered primeiro."
  exit 1
fi

versao_atual=$(defaults read /Applications/Superpowered.app/Contents/Info.plist CFBundleShortVersionString)

echo "A versão atual do Superpowered é: $versao_atual"

curl -o /tmp/superpowered.zip "https://download.superpowered.me/?timestamp=1681396270997"

unzip -o /tmp/superpowered.zip -d /tmp/

pkill -f "Superpowered"

cp -R /tmp/Superpowered.app /Applications/

rm /tmp/superpowered.zip
rm -rf /tmp/Superpowered.app

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Superpowered.app" ] 
then
    echo "O Superpowered foi atualizado com sucesso!"
    exit 0
else
    echo "O Superpowered não pode ser atualizado."
    exit 1
fi