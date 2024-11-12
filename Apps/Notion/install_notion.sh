#!/bin/bash

# start time
start_time=$(date +%s)

notion_url='https://www.notion.so/desktop/mac-universal/download'
notion_DMG_PATH="/tmp/Notion.dmg"

# verify if LibreOffice is already installed
if [ -d "/Applications/Notion.app" ]; then
    echo "O Notion já está instalado."
    exit 1
fi

curl -L -s -o "$notion_DMG_PATH" "$notion_url"

# mount dmg
hdiutil mount -nobrowse "$notion_DMG_PATH" >/dev/null 2>&1

# verify if dmg was mounted
if ! mount | grep -q "/Volumes/Notion"; then
    echo "Falha ao montar o volume do Notion."
    exit 1
fi

# copy LibreOffice to applications
cp -R "/Volumes/Notion/Notion.app" "/Applications/"

# verify if docker was copied
if [ $? -ne 0 ]; then
    echo "Falha ao copiar o Notion."
    hdiutil detach "/Volumes/Notion"
    rm -rf "$notion_DMG_PATH"
    exit 1
fi

#unmount dmg file and remove
hdiutil detach "/Volumes/Notion" >/dev/null 2>&1

rm -rf "$notion_DMG_PATH"

echo "Aguarde uns instantes..."
sleep 15

if [ -d "/Applications/Notion.app" ]; then
    echo "O Notion foi instalado com sucesso!"
else
    echo "O Notion não pode ser atualizado."
    exit 1
fi

# end time
end_time=$(date +%s)

# calculate total time in seconds
elapsed_time=$((end_time - start_time))

# convert time to minutes and seconds format
minutes=$((elapsed_time / 60))
seconds=$((elapsed_time % 60))

echo "Tempo total de execução: $minutes minutos e $seconds segundos."