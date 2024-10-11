# Define the path to the file
$filePath = "C:\Workstations.txt"
# Define the path to the output CSV file
$outputPath = "C:\IPAddresses.csv"

# Check if the file exists
if (Test-Path $filePath) {
    # Read the file line by line
    $hostnames = Get-Content $filePath

    # Create an array to store the results
    $results = @()

    # Loop through each hostname
    foreach ($hostname in $hostnames) {
        # Try to resolve the IP address
        try {
            $ipAddress = [System.Net.Dns]::GetHostAddresses($hostname) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -ExpandProperty IPAddressToString
            $results += New-Object PSObject -Property @{
                "Hostname" = $hostname
                "IP Address" = $ipAddress
            }
        }
        catch {
            Write-Output "Could not resolve IP for $hostname"
        }
    }

    # Export the results to a CSV file
    $results | Export-Csv -Path $outputPath -NoTypeInformation
}
else {
    Write-Output "File $filePath does not exist."
}
