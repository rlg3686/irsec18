#An example logging off Active Directory users of a specific Organizational Unit:
$users = Get-ADUser -filter * -SearchBase "ou=YOUR_OU_NAME,dc=contoso,dc=com"

Get-RDUserSession | where { $users.sAMAccountName -contains $_.UserName } | % { $_ | Invoke-RDUserLogoff -Force }
#At the end of the pipe, if you try to use only foreach (%), it will log off only one user. But using this combination of foreach and pipe:
#| % { $_ | command }