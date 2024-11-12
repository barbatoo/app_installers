#!/bin/bash

## Created by Gabriel Barbato to reinstall Slack - https://github.com/barbatoo

SLACK_DMG_URL="https://slack.com/api/desktop.latestRelease?arch=universal&variant=dmg&redirect=true"
SLACK_DMG_PATH="/tmp/Slack.dmg"

## Encerra o Slac se estiver aberto
if pgrep "Slack" > /dev/null; then
    sudo killall Slack
    echo "Processo do Slack encerrado, iniciando desinstalação..."
else
    echo "Não há processo do Slack aberto, iniciando verificação do Slack..."
fi

# Desinstala o Slack
if [ -d "/Applications/Slack.app" ]; then
    sudo rm -rf /Applications/Slack.app
    echo "Slack desinstalado, iniciando reinstalação..."
else
    echo "Slack não está instalado, iniciando instalação..."
fi

# Baixa a versão mais recente do Slack
curl -L -o "$SLACK_DMG_PATH" "$SLACK_DMG_URL"

# Verifica se o download foi realizado
if [ $? -ne 0 ]; then
    echo "Falha ao baixar o Slack. Verifique sua conexão com a internet."
    exit 1
fi

# Monta o arquivo DMG
hdiutil mount -nobrowse "$SLACK_DMG_PATH"

# Verifica se o DMG foi montado corretamente
if [ $? -ne 0 ]; then
    echo "Falha ao montar o arquivo DMG."
    exit 1
fi

# Copia o Slack.app para a pasta Applications
cp -R "/Volumes/Slack/Slack.app" "/Applications/"

# Verifica se a cópia foi realizada
if [ $? -ne 0 ]; then
    echo "Falha ao copiar o Slack.app para /Applications."
    hdiutil detach "/Volumes/Slack"
    rm "$SLACK_DMG_PATH"
    exit 1
fi

# Desmonta o volume do Slack
hdiutil detach "/Volumes/Slack"

# Remove o arquivo DMG
rm -rf "$SLACK_DMG_PATH"

echo "Aguarde uns instantes..."
sleep 15

# Verifica se o Slack foi instalado
if [ -d "/Applications/Slack.app" ]; then
    echo "O Slack foi atualizado com sucesso!"
else
    echo "O Slack não pode ser atualizado."
    exit 1
fi

# Configurações do Slack
defaults write /Users/$USER/Library/Preferences/com.tinyspeck.slackmacgap SlackNoAutoUpdates -bool YES
if [ $? -ne 0 ]; then
    echo "Falha ao configurar as preferências do Slack."
    exit 1
fi

exit 0