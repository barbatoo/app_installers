# Obtém o nome do usuário ativo
$LoggedUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
$UserName = $LoggedUser -replace '.*\\'

# Encerra todos os processos relacionados ao Discord
Get-Process "discord" | ForEach-Object { $_.Kill() }

# Espera alguns segundos para garantir que todos os processos foram encerrados
Start-Sleep -Seconds 5

# Define o caminho para o diretório do Discord
$discordPath = "C:\Users\$UserName\AppData\Local\Discord"

# Verifica se o diretório do Discord existe
if (Test-Path $discordPath) {
    # Remove o diretório do Discord e todos os seus arquivos e subdiretórios
    Remove-Item -Path $discordPath -Recurse -Force
    Write-Host "Discord removido com sucesso!"
} else {
    Write-Host "Discord não encontrado."
}

# Caminho atalho da desktop
$discordshortcut = "C:\Users\$UserName\Desktop\Discord.lnk"

# Verifica se o atalho do Discord existe
if (Test-Path $discordshortcut) {
    # Remove o atalho do Discord
    Remove-Item -Path $discordshortcut -Force
    Write-Host "Atalho do Discord removido com sucesso!"
} else {
    Write-Host "Atalho do Discord não encontrado."
}

# Verifica novamente se o diretório do Discord existe
if (Test-Path $discordPath) {
    # Remove o diretório do Discord e todos os seus arquivos e subdiretórios
    Remove-Item -Path $discordPath -Recurse -Force
    Write-Host "Discord removido com sucesso!"
} else {
    Write-Host "Discord já desinstalado."
}
