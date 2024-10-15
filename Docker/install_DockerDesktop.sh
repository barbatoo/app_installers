#!/bin/bash

# start time
start_time=$(date +%s)

arch=$(uname -m)
docker_x86='https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*8pmyqb*_gcl_au*MTA3ODY1MTAzNy4xNzI4OTM1MDc3*_ga*MzI5OTQ3NDE1LjE3Mjg5MzUwNzc.*_ga_XJWPQMJYHQ*MTcyODkzNTA3Ny4xLjEuMTcyODkzNTA4MC41Ny4wLjA.'
docker_ARM='https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*1f4vs8y*_gcl_au*MTA3ODY1MTAzNy4xNzI4OTM1MDc3*_ga*MzI5OTQ3NDE1LjE3Mjg5MzUwNzc.*_ga_XJWPQMJYHQ*MTcyODkzNTA3Ny4xLjEuMTcyODkzNTA4MC41Ny4wLjA.'
docker_DMG_PATH="/tmp/Docker.dmg"

# verify if docker is already installed
if [ -d "/Applications/Docker.app" ]; then
  echo "O Docker já está instalado."
  exit 1
fi

if [ "$arch" = "arm64" ]; then
    
    echo "Instalando versão: $arch"
    
    curl -L -s -o "$docker_DMG_PATH" "$docker_ARM"

    # mount dmg
    hdiutil mount -nobrowse "$docker_DMG_PATH" >/dev/null 2>&1
    
    # verify if dmg was mounted
    if ! mount | grep -q "/Volumes/Docker"; then
        echo "Falha ao montar o volume do Docker."
        exit 1
    fi

    # copy docker to applications
    cp -R "/Volumes/Docker/Docker.app" "/Applications/"
    
    # verify if docker was copied
    if [ $? -ne 0 ]; then
        echo "Falha ao copiar o Docker."
        hdiutil detach "/Volumes/Docker"
        rm -rf "$docker_DMG_PATH"
        exit 1
    fi

    #unmount dmg file and remove
    hdiutil detach "/Volumes/Docker" >/dev/null 2>&1

    rm -rf "$docker_DMG_PATH"

    echo "Aguarde uns instantes..."
    sleep 15

    if [ -d "/Applications/Docker.app" ]; then
        echo "O Docker foi instalado com sucesso!"
    else
        echo "O Docker não pode ser atualizado."
        exit 1
    fi
else
    echo "Instalando versão: $arch"
    
    curl -L -s -o "$docker_DMG_PATH" "$docker_x86"

    # mount dmg
    hdiutil mount -nobrowse "$docker_DMG_PATH" >/dev/null 2>&1
    
    # verify if dmg was mounted
    if ! mount | grep -q "/Volumes/Docker"; then
        echo "Falha ao montar o volume do Docker."
        exit 1
    fi

    #copy docker to applications
    cp -R "/Volumes/Docker/Docker.app" "/Applications/"
 
    if [ $? -ne 0 ]; then
        echo "Falha ao copiar o Docker."
        hdiutil detach "/Volumes/Docker"
        rm -rf "$docker_DMG_PATH"
        exit 1
    fi

    #unmount dmg file and remove
    hdiutil detach "/Volumes/Docker" >/dev/null 2>&1

    rm -rf "$docker_DMG_PATH"

    echo "Aguarde uns instantes..."
    sleep 15

    if [ -d "/Applications/Docker.app" ]; then
        echo "O Docker foi instalado com sucesso!"
    else
        echo "O Docker não pode ser atualizado."
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