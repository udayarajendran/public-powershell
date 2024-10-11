$username = Read-Host "Enter the username of the account to unlock"
net user $username /domain
$user = Get-ADUser -Identity $username -Properties "LockedOut"
if ($user.LockedOut) {
    Unlock-ADAccount -Identity $username
    Write-Host "The account for user $username has been unlocked."
}
else {
    Write-Host "The account for user $username is not locked."
}
