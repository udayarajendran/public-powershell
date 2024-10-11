# Import the Active Directory module
Import-Module ActiveDirectory
# Get the target OU
$targetOU = 'OU=disabled,OU=OU,DC=domain,DC=com'
# Prompt for usernames
do {
    $username = Read-Host "Enter a username (or 'exit' to quit)"
    if ($username -ne 'exit') {
        # Get the user account        
        $user = Get-ADUser -Identity $username
        # Disable the user account        
        Disable-ADAccount -Identity $user.DistinguishedName

        # Move the user account to the target OU        
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $targetOU    }
} while ($username -ne 'exit')