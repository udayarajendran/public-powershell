# Define the path to the text file containing hostnames
$hostnameFile = "C:\!Intel\shutdown.txt"

# Read the hostnames from the text file
$hostnames = Get-Content $hostnameFile

# Create an empty array to store the results
$results = @()

# Loop through each hostname and check its online status and operating system
foreach ($hostname in $hostnames) {
    $online = $false
    $operatingSystem = "Unknown"

    # Check if the machine is online
    if (Test-Connection -ComputerName $hostname -Quiet -Count 1) {
        $online = $true

        # Determine the operating system
        $pingResponse = Test-Connection -ComputerName $hostname -Quiet -Count 1
        if ($pingResponse) {
            $osInfo = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $hostname -ErrorAction SilentlyContinue
            if ($osInfo) {
                $operatingSystem = "Windows"
            } else {
                $operatingSystem = "Linux"
            }
        }
    }

    # Create a custom object with the hostname, online status, and operating system
    $result = [PSCustomObject] @{
        Hostname = $hostname
        Online = $online
        OperatingSystem = $operatingSystem
    }

    # Add the result to the array
    $results += $result
}

# Export the results to a CSV file
$results | Export-Csv -Path "C:\!Intel\Check_Online_OS.csv" -NoTypeInformation
