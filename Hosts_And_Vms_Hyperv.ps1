#Variaveis

$smtpServer = "192.168.100.15"
$to = "TPZ.BR.Engenharia.Sistemas@telespazio.com", "TPZ.BR.TI@telespazio.com"
$from = "hyperv@telespazio.com.br"
$subject = "Hyper-V Virtual Machines Report"
$remoteComputers = "SRV-HYPERV01","SRV-HYPERV02","SRV-HYPERV03","SRV-HYPERV04","SRV-HYPERV05","SRV-HYPERV06", "SRV-HYPERV07","SRV-HYPERV8","SRV-HYPERV9","SRV-HYPERV10","SRV-HYPERV11","TPZ-SRV-BKP01"

# Cria um array para armazenar as informações da máquina virtual
$vms = @()

# Percorrendo cada computador remoto
foreach ($remoteComputer in $remoteComputers) {
  # Conecta ao computador remoto
  $session = New-PSSession -ComputerName $remoteComputer

  # Get a list of virtual machines on the remote computer
  $tempVMs = Invoke-Command -Session $session -ScriptBlock {Get-VM}

  # Store the virtual machine information in the array
  foreach ($vm in $tempVMs) {
    $vms += New-Object PSObject -Property @{
      ComputerName = $remoteComputer
      VirtualMachineName = $vm.Name
      State = $vm.State
    }
  }

  # Disconnect from the remote computer
  Remove-PSSession $session
}

# Criando o HTML para o corpo do email
$body = "<p>Lista de Hosts Hyper-V e suas respectivas VMs:</p>`n`n"
$body += "<html><body><table border=1>"
$body += "<tr><th>Host</th><th>Virtual Machine Name</th><th>State</th></tr>"
foreach ($vm in $vms) {
  $body += "<tr>"
  $body += "<td>" + $vm.ComputerName + "</td>"
  $body += "<td>" + $vm.VirtualMachineName + "</td>"
  $body += "<td>" + $vm.State + "</td>"
  $body += "</tr>"
}
$body += "</table></body></html>"

# Envia o email
Send-MailMessage -To $to -From $from -Subject $subject -BodyAsHtml $body -SmtpServer $smtpServer
