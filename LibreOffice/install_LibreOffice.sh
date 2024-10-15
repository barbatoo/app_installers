#!/bin/bash

# start time
start_time=$(date +%s)

arch=$(uname -m)
libre_x86='https://download.documentfoundation.org/libreoffice/stable/24.8.2/mac/x86_64/LibreOffice_24.8.2_MacOS_x86-64.dmg'
libre_ARM='https://download.documentfoundation.org/libreoffice/stable/24.8.2/mac/aarch64/LibreOffice_24.8.2_MacOS_aarch64.dmg'
libre_DMG_PATH="/tmp/LibreOffice_24.8.2_MacOS_aarch6.dmg"

# verify if LibreOffice is already installed
if [ -d "/Applications/LibreOffice.app" ]; then
  echo "O LibreOffice já está instalado."
  exit 1
fi

if [ "$arch" = "arm64" ]; then
    
    echo "Instalando versão: $arch"
    
    curl -L -s -o "$libre_DMG_PATH" "$libre_ARM"

    # mount dmg
    hdiutil mount -nobrowse "$libre_DMG_PATH" >/dev/null 2>&1
    
    # verify if dmg was mounted
    if ! mount | grep -q "/Volumes/LibreOffice"; then
        echo "Falha ao montar o volume do LibreOffice."
        exit 1
    fi

    # copy LibreOffice to applications
    cp -R "/Volumes/LibreOffice/LibreOffice.app" "/Applications/"
    
    # verify if docker was copied
    if [ $? -ne 0 ]; then
        echo "Falha ao copiar o LibreOffice."
        hdiutil detach "/Volumes/LibreOffice"
        rm -rf "$libre_DMG_PATH"
        exit 1
    fi

    #unmount dmg file and remove
    hdiutil detach "/Volumes/LibreOffice" >/dev/null 2>&1

    rm -rf "$libre_DMG_PATH"

    echo "Aguarde uns instantes..."
    sleep 15

    if [ -d "/Applications/LibreOffice.app" ]; then
        echo "O LibreOffice foi instalado com sucesso!"
    else
        echo "O LibreOffice não pode ser atualizado."
        exit 1
    fi
else
    echo "Instalando versão: $arch"
    
    curl -L -s -o "$libre_DMG_PATH" "$libre_x86"

    # mount dmg
    hdiutil mount -nobrowse "$libre_DMG_PATH" >/dev/null 2>&1
    
    # verify if dmg was mounted
    if ! mount | grep -q "/Volumes/LibreOffice"; then
        echo "Falha ao montar o volume do LibreOffice."
        exit 1
    fi

    #copy LibreOffice to applications
    cp -R "/Volumes/LibreOffice/LibreOffice.app" "/Applications/"
 
    if [ $? -ne 0 ]; then
        echo "Falha ao copiar o LibreOffice."
        hdiutil detach "/Volumes/LibreOffice"
        rm -rf "$libre_DMG_PATH"
        exit 1
    fi

    #unmount dmg file and remove
    hdiutil detach "/Volumes/LibreOffice" >/dev/null 2>&1

    rm -rf "$libre_DMG_PATH"

    echo "Aguarde uns instantes..."
    sleep 15

    if [ -d "/Applications/LibreOffice.app" ]; then
        echo "O LibreOffice foi instalado com sucesso!"
    else
        echo "O LibreOffice não pode ser atualizado."
        exit 1
    fi
fi

# end time
end_time=$(date +%s)

# calculate total time in seconds
elapsed_time=$((end_time - start_time))

# convert time to minutes and seconds format
minutes=$((elapsed_time / 60))
seconds=$((elapsed_time % 60))

echo "Tempo total de execução: $minutes minutos e $seconds segundos."