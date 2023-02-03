$emailFrom = "TPZ.BR.Engenharia.Sistemas@telespazio.com", "TPZ.BR.TI@telespazio.com"
$emailTo = "igor.campos@external.telespazio.com"
$smtpServer = "192.168.100.15"
$date = Get-Date
$threshold = $date.AddMonths(-3)

$users = Get-ADUser -Filter {Enabled -eq $True} -SearchBase "OU=TPZ.RJ,OU=TPZ.BR,DC=TELESPAZIO,DC=local" -Properties LastLogonDate |
          Where-Object {$_.LastLogonDate -lt $threshold}

$users += Get-ADUser -Filter {Enabled -eq $True} -SearchBase "OU=Terceirizados,DC=TELESPAZIO,DC=local" -Properties LastLogonDate |
           Where-Object {$_.LastLogonDate -lt $threshold}

$body = "<p>Lista de usuarios habilitados que nao logaram-se ha mais de 3 meses:</p>`n`n"
$body += "<table border=1 cellpadding=5 cellspacing=0>"
$body += "<tr><th>Nome do Usuario</th><th>Ultimo Login</th></tr>"

foreach ($user in $users) {
  $body += "<tr><td>" + $user.Name + "</td><td>" + $user.LastLogonDate + "</td></tr>"
}

$body += "</table>"

$mailParams = @{
  To = $emailTo
  From = $emailFrom
  Subject = "Usuarios inativos do AD "
  Body = $body
  BodyAsHtml = $True
  SmtpServer = $smtpServer
}

Send-MailMessage @mailParams
