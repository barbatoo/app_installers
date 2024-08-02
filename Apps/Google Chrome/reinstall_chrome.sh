#!/bin/bash

## Created by Gabriel Barbato to reinstall Chrome - https://github.com/barbatoo

if pgrep "Google Chrome" > /dev/null; then
    sudo killall "Google Chrome"
    echo "Processo do Google Chrome encerrado, inciciando desisntalação..."
else
    echo "Não há processo do Google Chrome aberto, inciando verificação do Chrome..."
fi

if [ -d "/Applications/Google Chrome.app" ] 
then
    rm -rf "/Applications/Google Chrome.app"
    echo "Google Chrome desinstalado, iniciando reinstalação..."
else
    echo "Google Chrome não está instalado, inciando instalação..."
fi

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
    echo "O Google Chrome não pode ser atualizado/instalado."
    exit 1
fi