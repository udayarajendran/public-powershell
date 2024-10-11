# Import Active Directory module
Import-Module ActiveDirectory

# Prompt for user names
Write-Host "Enter comma-separated user names (e.g., usera,userb,userc,..):"
$userNames = Read-Host

# Split user names
$missingUsers = @()
$users = $userNames.Split(",") | ForEach-Object {
  $user = Get-ADUser -Filter {SamAccountName -eq $_}
  if ($user -eq $null) {
    $missingUsers += $_
    Write-Warning "User '$_' not found. Skipping..."
  } else {
    return $user
  }
}

# Report missing users
if ($missingUsers.Count -gt 0) {
  Write-Warning "The following users were not found and will be skipped:"
  $missingUsers | ForEach-Object { Write-Warning "- $_" }
}

# Prompt for group names
Write-Host "Enter comma-separated group names (e.g., group1,group2):"
$groupNames = Read-Host

# Split group names
$missingGroups = @()
$groups = $groupNames.Split(",") | ForEach-Object {
  $group = Get-ADGroup -Filter {Name -eq $_}
  if ($group -eq $null) {
    $missingGroups += $_
    Write-Warning "Group '$_' not found. Skipping..."
  } else {
    return $group
  }
}

# Report missing groups
if ($missingGroups.Count -gt 0) {
  Write-Warning "The following groups were not found and will be skipped:"
  $missingGroups | ForEach-Object { Write-Warning "- $_" }
}

# Loop through each user and add them to each group (skip missing users)
foreach ($user in $users) {
  foreach ($group in $groups) {
    # Check if user is already a member
    $isMember = (Get-ADGroupMember -Identity $group).SamAccountName -contains $user.SamAccountName

    if ($isMember) {
      Write-Host "User '$user.SamAccountName' is already a member of group '$group.Name'."
      continue
    }

    # Add user to the group (only if user exists)
    try {
      Add-ADGroupMember -Identity $group -Members $user
      Write-Host "User '$user.SamAccountName' added to security group '$group.Name'."
    } catch {
      Write-Warning "Error adding user to group: $_"
    }
  }
}

Write-Host "Finished processing users and groups (skipping missing entries)."