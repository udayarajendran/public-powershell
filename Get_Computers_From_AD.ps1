# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path and filename for the CSV file
$csvPath = "C:\WorkstationsAD.csv"

# Retrieve all computer objects from Active Directory
$computers = Get-ADComputer -Filter * -Property *

# Create an empty array to store computer information
$computerInfo = @()

# Iterate through each computer object
foreach ($computer in $computers) {
    # Create a custom object to store computer information
    $computerObj = [PSCustomObject]@{
        Name        = $computer.Name
        DNSHostName = $computer.DNSHostName
        IPAddress   = $computer.IPv4Address
        OperatingSystem = $computer.OperatingSystem
        LastLogonDate  = $computer.LastLogonDate
    }

    # Add the computer object to the array
    $computerInfo += $computerObj
}

# Export the computer information to a CSV file
$computerInfo | Export-Csv -Path $csvPath -NoTypeInformation

# Display a confirmation message
Write-Host "Computer information exported to $csvPath"