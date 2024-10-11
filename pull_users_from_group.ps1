# Import the Active Directory module
Import-Module ActiveDirectory

# Replace 'YourGroupName' with the name of the security group you want to query
$groupName = "sidgroup"

# Replace 'OU=Users,OU=OU,DC=Domain,DC=com' with the distinguished name of the OU you want to filter
$ouFilter = "DC=domain,DC=com"

# Retrieve all members of the security group within the specified OU
$groupMembers = Get-ADGroupMember -Identity $groupName | Where-Object {$_.ObjectClass -eq "user"} | Get-ADUser -Properties *

# Filter members based on OU
$filteredMembers = $groupMembers | Where-Object {$_.DistinguishedName -like "*$ouFilter*"}

# Replace 'C:\Path\To\OutputFile.csv' with the path where you want to save the output CSV file
$outputFile = "C:\!Intel\maf.csv"

# Convert members to a PowerShell custom object
$membersObject = $filteredMembers | Select-Object DisplayName, SamAccountName, Title

# Export the members to a CSV file
$membersObject | Export-Csv -Path $outputFile -NoTypeInformation
