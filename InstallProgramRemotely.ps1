# Definir o nome do host remoto
$RemoteHost = "RJICAMPOS"

# Verificar se o Chocolatey está instalado
if (!(Get-Command choco.exe -errorAction SilentlyContinue)) {
  # Instalar o Chocolatey caso ele não esteja instalado
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Instalar o Firefox no computador remoto
Invoke-Command -ComputerName $RemoteHost -ScriptBlock { choco install Opera -y }
