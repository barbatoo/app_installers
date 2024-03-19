## Created by Gabriel Barbato to clean cache from Chrome - https://github.com/barbatoo

# Obtain the active user
$LoggedUser = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName
$UserName = $LoggedUser -replace '.*\\'

# Wait a few seconds to make sure Chrome closes
Start-Sleep -Seconds 5

# Path to Chrome cache directory
$chromeCachePath = "C:\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\Cache"
$chromeCachePath2 = "C:\Users\$UserName\AppData\Local\Google\Chrome\User Data\Profile *\Cache\*"

# Clean cache from Google Chrome
Remove-Item -Path $chromeCachePath\* -Force -Recurse
Remove-Item -Path $chromeCachePath2\* -Force -Recurse

# End the Chrome process
Get-Process "chrome" | ForEach-Object { $_.Kill() }