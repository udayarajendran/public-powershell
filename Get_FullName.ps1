# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the path to the text file containing the usernames
$usernamesFile = "C:\users.txt"

# Specify the path to the output CSV file
$outputFile = "C:\fullnames.csv"

# Initialize an empty array to hold the results
$results = @()

# Read the usernames from the text file
$usernames = Get-Content $usernamesFile

# Loop through each username
foreach ($username in $usernames) {
    # Get the full name for the user from Active Directory
    $user = Get-ADUser -Identity $username -Properties Name

    # Add the username and full name to the results
    $results += New-Object PSObject -Property @{
        "Username" = $username
        "Full Name" = $user.Name
    }
}

# Export the results to a CSV file
$results | Export-Csv $outputFile -NoTypeInformation
