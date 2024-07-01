#!/bin/bash

## Created by Gabriel Barbato to update Figma - https://github.com/barbatoo

FIGMA_URL="https://desktop.figma.com/mac-installer/Figma.dmg"
FIGMA_PATH="/tmp/Figma.dmg"

if [ -d "/Applications/Figma.app" ]; then
  echo "Atualizando o Figma..."

  if pgrep -x "Figma" >/dev/null; then
    echo "Fechando o Figma..."
    pkill -x "Figma"
  fi

  curl -L -o "$FIGMA_PATH" "$FIGMA_URL"

  # Monta o arquivo DMG
  hdiutil mount -nobrowse /tmp/Figma.dmg

  # Copia o aplicativo Figma para a pasta Applications
  cp -R "/Volumes/Figma/Figma.app" "/Applications/"

  # Desmonta o volume do Figma
  hdiutil detach "/Volumes/Figma"

  # Remove o arquivo DMG baixado
  rm "$FIGMA_PATH"

  echo "O Figma foi atualizado com sucesso."
else
  echo "O Figma não está instalado. Por favor, instale o Figma antes de executar este script."
fi
