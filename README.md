Script PowerShell – Préconfiguration de base pour Windows Server

📋 Description

Ce script PowerShell permet d’automatiser une série de **tâches essentielles post-installation** sur un système **Windows Server**. Il facilite la mise en route d’un serveur en appliquant rapidement les premières configurations réseau et système, avec une logique simple, adaptable et directe.
Note: Ouvrir PowerShell en tant qu’administrateur
-- Windows Server (testé sur 2019/2022/2025)

✅ Fonctionnalités incluses

- 🔍 **Détection de Winget**
  - Vérifie si `winget` (Windows Package Manager) est disponible.
  - Si oui, met automatiquement à jour PowerShell en mode silencieux.

- 🆙 **Mise à jour de l’aide PowerShell**
  - Lance `Update-Help -Force` pour télécharger la dernière documentation des modules.

- 🌐 **Configuration réseau**
  - Détecte automatiquement la première interface réseau active et physique.
  - Attribue une **adresse IP fixe**, un masque, une passerelle et un DNS.
  - **Désactive IPv6** sur l’interface détectée.

- 💻 **Personnalisation système**
  - Change automatiquement le **nom du poste** (à définir dans le script).
  - **Redémarre** la machine pour appliquer les modifications.

---

⚙️ Personnalisation requise

Avant d’exécuter le script, modifiez les valeurs suivantes dans le code source :

```powershell
# Configuration IP
$IPAddress = "192.168.***.***"
$SubnetMask = "24"
$Gateway = "192.168.***.***"
$DNSServer = "192.168.***.***"

# Nom du poste
$NewName = "***"

