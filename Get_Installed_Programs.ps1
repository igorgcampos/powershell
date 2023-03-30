# Insira as credenciais e o nome do computador remoto
$remoteComputer = "RemoteComputerName"
$remoteUsername = "domain\username"
$remotePassword = ConvertTo-SecureString "YourPassword" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($remoteUsername, $remotePassword)

# Execute o psexec e se conecte ao computador remoto para obter a lista de programas instalados
$scriptBlock = {
    $installedPrograms = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, Vendor, InstallDate
    return $installedPrograms
}

# Chame o Invoke-Command para executar o scriptBlock no computador remoto e exibir a lista na tela
Invoke-Command -ComputerName $remoteComputer -Credential $credentials -ScriptBlock $scriptBlock | Format-Table -AutoSize
