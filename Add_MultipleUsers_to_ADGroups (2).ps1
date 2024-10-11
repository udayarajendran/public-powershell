# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Prompt the user for the names of the AD groups
$groups = Read-Host "Enter the names of the AD groups, separated by commas (e.g. GROUP1,GROUP2,GROUP3)"

# Split the group names into an array
$groups = $groups.Split(",")

# Prompt the user for the names of the AD users
$users = Read-Host "Enter the names of the AD users, separated by commas (e.g. USER1,USER2,USER3)"

# Split the user names into an array
$users = $users.Split(",")

# Add each user to each group
foreach ($user in $users) {
  foreach ($group in $groups) {
    # Add the user to the group
    Add-ADGroupMember -Identity $group -Members $user

    }
}
