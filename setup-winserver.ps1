# Vérifier si winget est disponible
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Winget trouvé. Mise à jour de PowerShell via Winget."
    
    # Mise à jour de PowerShell via winget
    winget install --id Microsoft.Powershell --source winget --silent --scope machine

    # Vérifier si PowerShell est mis à jour correctement
    $PSVersionAfterUpdate = $PSVersionTable.PSVersion
    Write-Host "PowerShell a été mis à jour avec succès. Version actuelle: $PSVersionAfterUpdate"

} else {
    Write-Host "Winget n'est pas installé sur ce système. Veuillez installer winget pour mettre à jour PowerShell."
    Write-Host "Visitez https://github.com/microsoft/winget-cli/releases pour télécharger Winget."
}

# Mise à jour de l'aide pour tous les modules
try {
    Write-Host "Mise à jour de l'aide pour tous les modules PowerShell..."
    Update-Help -Force
    Write-Host "L'aide a été mise à jour avec succès."
} catch {
    Write-Host "Une erreur est survenue lors de la mise à jour de l'aide : $_"
}

# Récupérer l'InterfaceAlias de la première interface active (Up) qui n'est pas une interface de boucle (Loopback)
$InterfaceAlias = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.HardwareInterface -eq $true }).InterfaceAlias

# Vérifier si une interface active a été trouvée
if ($InterfaceAlias) {
    Write-Host "Interface trouvée : $InterfaceAlias"

    # Configuration des paramètres d'une adresse IP fixe (Remplacer les étoiles par les octets voulus)
    $IPAddress = "192.168.***.***"
    $SubnetMask = "24"
    $Gateway = "192.168.***.***"
    $DNSServer = "192.168.***.***"

    # Configurer une adresse IP fixe
    New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength $SubnetMask -DefaultGateway $Gateway
    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNSServer

    Write-Host "Configuration de l'adresse IP terminée pour l'interface $InterfaceAlias."
} else {
    Write-Host "Aucune interface active trouvée."
}
#  Désactiver IPv6
Disable-NetAdapterBinding -Name $InterfaceAlias -ComponentID ms_tcpip6

#  Changer le nom du poste (Remplacer les étoiles par le nom de l'ordinateur choisi /redémarrage requis)
$NewName = "***"
Rename-Computer -NewName $NewName -Force
Restart-Computer -Force
