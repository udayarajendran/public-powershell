# prompt for the group names and usernames
$groupNames = Read-Host "Enter the names of the groups you want to check (separated by commas)"
$usernames = Read-Host "Enter the usernames you want to check (separated by commas)"

# split the group names and usernames into an array
$groupNames = $groupNames -split ","
$usernames = $usernames -split ","

foreach ($groupName in $groupNames) {
    # get the group object from Active Directory
    $group = Get-ADGroup $groupName

    foreach ($username in $usernames) {
        # check if the user is a member of the group
        $isMember = Get-ADGroupMember $group | Where-Object {$_.samaccountname -eq $username}

        if ($isMember) {
            Write-Host "$username is a member of $groupName."
        } else {
            Write-Host "$username is not a member of $groupName."
        }
    }
}
