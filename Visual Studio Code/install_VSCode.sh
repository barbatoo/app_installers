#!/bin/bash

vscode_url='https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal'
vscode_ZIP_PATH="/tmp/VSCode-darwin-universal.zip"
curUser=$(/usr/bin/stat -f%Su /dev/console)

# verify if VSCode is already installed
if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "O VS Code já está instalado."
  exit 1
fi

curl -L -o -s "$vscode_ZIP_PATH" "$vscode_url"

unzip $vscode_ZIP_PATH -d /tmp

mv mv /tmp/Visual\ Studio\ Code.app /Users/$curUser/Applications/

rm -rf "$vscode_ZIP_PATH"

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo "O VS Code foi instalado com sucesso!"
    exit 0
else
    echo "O VS Code não pode ser atualizado."
    exit 1
fi