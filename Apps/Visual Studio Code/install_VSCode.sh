#!/bin/bash

vscode_url='https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal'
vscode_ZIP_PATH="/tmp/VSCode-darwin-universal.zip"

# check if VS Code is already installed
if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "O VS Code já está instalado."
  exit 1
fi

# download the zip file of VS Code
curl -L -s -o "$vscode_ZIP_PATH" "$vscode_url"

# unzip the zip file in /tmp
unzip -q "$vscode_ZIP_PATH" -d /tmp

# move app to Aplicativos
mv /tmp/Visual\ Studio\ Code.app /Applications/

# remove zip file
rm -rf "$vscode_ZIP_PATH"

echo "Aguarde uns instantes..."
sleep 15

# check if the installation was sucessfull
if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo "O VS Code foi instalado com sucesso!"
    exit 0
else
    echo "O VS Code não pôde ser instalado."
    exit 1
fi