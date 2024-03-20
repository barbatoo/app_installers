## Created by Gabriel Barbato to reinstall Slack - https://github.com/barbatoo

# Obtém o nome do usuário ativo
$LoggedUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
$UserName = $LoggedUser -replace '.*\\'

# Caminho atalho da desktop
$slackshortcut = "C:\Users\$UserName\Desktop\Slack.lnk"
$slackshortcut2 = "C:\Users\Public\Desktop\Slack.lnk"

# Define o caminho para o diretório do Slack
$slackPath = "C:\Users\$UserName\AppData\Local\slack"
$slackPath2 = "C:\Program Files\Slack"

# Caminho do arquivo executável do aplicativo após instalado
$AppPath = "C:\Program Files\Slack\slack.exe"

# Caminho para o local onde o atalho será criado na área de trabalho
$ShortcutLocation = "C:\Users\Public\Desktop\Slack.lnk"

# Cria um objeto para o WScript.Shell
$WScriptShell = New-Object -ComObject WScript.Shell

# Verifica se o processo Slack está em execução
$slackProcesses = Get-Process "slack" -ErrorAction SilentlyContinue

Write-Host "Iniciando processo de reinstalação do Slack..."

if ($slackProcesses) {
    # Se o processo Slack está em execução, encerra o processo
    Get-Process "slack" | ForEach-Object { $_.Kill() }
    Write-Host "Processo do Slack encerrado com sucesso."
} else {
    # Se nenhum processo Slack está em execução, exibe uma mensagem
    Write-Host "Nenhum processo do Slack em execução."
}

# Espera alguns segundos para garantir que todos os processos foram encerrados
Start-Sleep -Seconds 5

# Verifica se o diretório do Slack no usuário existe
if (Test-Path $slackPath) {
    # Remove o diretório do Slack e todos os seus arquivos e subdiretórios
    Remove-Item -Path $slackPath -Recurse -Force
    Write-Host "Slack desinstalado com sucesso da pasta do usuário!"
} else {
    Write-Host "Slack não está instalado na pasta do usuário."
}

# Verifica se o diretório do Slack no Program Files existe
if (Test-Path $slackPath2) {
    # Remove o diretório do Slack e todos os seus arquivos e subdiretórios
    Remove-Item -Path $slackPath2 -Recurse -Force
    Write-Host "Slack desinstalado com sucesso da pasta Program Files!"
} else {
    Write-Host "Slack não está instalado em Program Files."
}

# Verifica se o atalho do Slack existe, e o apaga (atalho na pasta do usuário)
if (Test-Path $slackshortcut) {
    # Remove o atalho do Slack
    Remove-Item -Path $slackshortcut -Force
    Write-Host "Atalho do Slack removido com sucesso!"
} else {
    Write-Host "Atalho do Slack não encontrado na pasta pública."
}

# Verifica se o atalho do Slack existe, e o apaga (ataho na pasta Public)
if (Test-Path $slackshortcut2) {
    # Remove o atalho do Slack
    Remove-Item -Path $slackshortcut2 -Force
    Write-Host "Atalho do Slack removido com sucesso!"
} else {
    Write-Host "Atalho do Slack não encontrado na pasta do usuário."
}

# Verifica novamente se o diretório do Slack do Usuário existe
if (Test-Path $slackPath) {
    # Remove o diretório do Slack e todos os seus arquivos e subdiretórios
    Remove-Item -Path $slackPath -Recurse -Force
    Write-Host "Verificação concluída. Slack removido da pasta do usuário."
} else {
    Write-Host "Verificação concluída. Slack já removido da pasta do usuário."
}

# Verifica novamente se o diretório do Slack do Program Files existe
if (Test-Path $slackPath2) {
    # Remove o diretório do Slack e todos os seus arquivos e subdiretórios
    Remove-Item -Path $slackPath2 -Recurse -Force
    Write-Host "Verificação concluída. Slack removido da pasta Program Files."
} else {
    Write-Host "Verificação concluída. Slack já removido da pasta Program Files"
}

Write-Host "Iniciando instalação..."

# Instala o MSI do Slack
msiexec /i "https://slack.com/ssb/download-win64-msi" INSTALLLEVEL=2 /qn /norestart

# Aguarda um tempo para garantir que o Slack foi instalado
Start-Sleep -Seconds 10

# Verifica se o Slack foi instalado com sucesso
if (Test-Path $slackPath2) {
    Write-Host "Slack reinstalado com sucesso!"
} else {
    Write-Host "Slack não pode ser instalado."
}

# Cria o atalho do Slack
$Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
$Shortcut.TargetPath = $AppPath
$Shortcut.Save()

Write-Host "Atalho para o Slack criado na área de trabalho em: $ShortcutLocation"

# Verifica se o Slack foi instalado com sucesso
if (Test-Path $ShortcutLocation) {
    Write-Host "Atalho do Slack criado com sucesso!"
    exit 0
} else {
    Write-Host "Atalho do Slack não pode ser criado."
    exit 1
}