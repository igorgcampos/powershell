Import-Module ActiveDirectory

$OUs = @("OU=Admins,OU=TPZ.BR,DC=TELESPAZIO,DC=local", "OU=TPZ.RJ,OU=TPZ.BR,DC=TELESPAZIO,DC=local", "OU=Terceirizados,DC=TELESPAZIO,DC=local")
$DisabledUsers = @()

foreach ($OU in $OUs) {
    $DisabledUsers += Get-ADUser -Filter {Enabled -eq $False} -SearchBase $OU
}

$Body = "<p>Lista de Usuarios Desabilitados que nao estao na OU=Disable:</p>`n`n"
$Body += "<html><body><table border='1' cellspacing='0' cellpadding='2'>"
$Body += "<tr><th>Nome de Usuario</th><th>Nome Completo</th><th>OU</th></tr>"

foreach ($User in $DisabledUsers) {
    $Body += "<tr><td>" + $User.SamAccountName + "</td><td>" + $User.Name + "</td><td>" + $User.distinguishedName + "</td></tr>"
}

$Body += "</table></body></html>"

Send-MailMessage -From "desativados@telespazio.com.br" -To "TPZ.BR.Engenharia.Sistemas@telespazio.com", "TPZ.BR.TI@telespazio.com" -Subject "Usuarios desabilitados do AD" -Body $Body -BodyAsHtml -SmtpServer "192.168.100.15" -Port "25"
