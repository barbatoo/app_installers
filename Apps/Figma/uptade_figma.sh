#!/bin/bash

## Created by Gabriel Barbato to update Figma - https://github.com/barbatoo

if [ -d "/Applications/Figma.app" ]; then
  echo "Atualizando o Figma..."

  if pgrep -x "Figma" > /dev/null; then
    echo "Fechando o Figma..."
    pkill -x "Figma"
  fi

  curl -o /tmp/Figma.dmg "https://desktop.figma.com/mac-installer/Figma.dmg"

  cp -R "/tmp/Figma.app" "/Applications/"

  rm -rf /tmp/Figma.app

  echo "O Figma foi atualizado com sucesso."
else
  echo "O Figma não está instalado. Por favor, instale o Figma antes de executar este script."
fi