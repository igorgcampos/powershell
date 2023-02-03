Import-Module ActiveDirectory

# Define o endereço do servidor AD
$adServer = "192.168.100.15"

# Define o nome do grupo Domain Admins
$groupName = "Domain Admins"

# Busca todos os usuários no grupo Domain Admins
$users = Get-ADGroupMember -Identity $groupName -Server $adServer -Recursive | 
         Select-Object -ExpandProperty SamAccountName

# Define o destinatário do e-mail
$to = "TPZ.BR.Engenharia.Sistemas@telespazio.com", "TPZ.BR.TI@telespazio.com"

# Define a origem do e-mail
$From = "domainadmin@telespazio.com.br"

# Define o assunto do e-mail
$subject = "Lista de usuarios no grupo Domain Admins"

# Define o corpo do e-mail
$body = "Segue a lista de usuarios que estao no grupo Domain Admins: `n"

# Adiciona os usuários à lista do corpo do e-mail
foreach ($user in $users) {
    $body += "$user`n"
}

# Envia o e-mail
Send-MailMessage -To $to -From $From -Subject $subject -Body $body -SmtpServer "192.168.100.15" -Port "25"