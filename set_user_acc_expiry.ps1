# Prompt for the username and expiration date
$username = Read-Host "Enter the username"
$dateInput = Read-Host "Enter the expiration date and time (MM/DD/YYYY HH:MM AM/PM)"

# Convert the input string to a DateTime object
try {
    $expirationDate = Get-Date $dateInput
} catch {
    Write-Host "Invalid date format. Please use MM/DD/YYYY HH:MM AM/PM." -ForegroundColor Red
    exit
}

# Retrieve the user and update the AccountExpirationDate property
$user = Get-ADUser -Identity $username -Properties "AccountExpirationDate"

if ($user) {
    $user.AccountExpirationDate = $expirationDate
    Set-ADUser -Instance $user
    Write-Host "Account expiration date for user '$username' set to $expirationDate." -ForegroundColor Green
} else {
    Write-Host "User '$username' not found." -ForegroundColor Red
}
