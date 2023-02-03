# Connect to remote computer
$computer = "rjralves"
$credential = Get-Credential
$session = New-PSSession -ComputerName $computer -Credential $credential

# Get list of installed programs
$installedPrograms = Invoke-Command -Session $session -ScriptBlock { Get-WmiObject -Class Win32_Product | Select-Object Name }

# Display list of installed programs
$installedPrograms.Name

# Close remote session
Remove-PSSession $session
