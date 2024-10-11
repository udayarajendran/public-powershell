$date = Get-Date -Format "yyyyMMdd_HHmmss"
Import-Module ActiveDirectory
$results = Get-ADUser -Filter {(Enabled -eq "True")} -SearchBase "OU=ou,DC=domain,DC=com" -Properties Name, SamAccountName, AccountExpirationDate, description, distinguishedName | Select-Object Name, SamAccountName, AccountExpirationDate, description, distinguishedName
$results | Export-Csv -Path "C:\$date.csv" -NoTypeInformation