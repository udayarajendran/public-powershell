# Define the path to the input and output files
$workstationFile = "C:\!Intel\workstations.txt"
$outputFile = "C:\!Intel\boot_times.csv"

# Check if the output file exists, if not, create it and add the header
if (!(Test-Path -Path $outputFile)) {
    "hostname,boot_time" | Out-File -FilePath $outputFile
}

# Read the hostnames from the file
$hostnames = Get-Content -Path $workstationFile

foreach ($hostname in $hostnames) {
    # Use a try-catch block to handle errors (like unreachable hosts)
    try {
        # Use the Get-WmiObject cmdlet to get the boot time
        $os = Get-WmiObject -ComputerName $hostname -Class Win32_OperatingSystem
        $bootTime = $os.ConvertToDateTime($os.LastBootUpTime)

        # Write the hostname and boot time to the CSV file
        "$hostname,$bootTime" | Out-File -FilePath $outputFile -Append
    }
    catch {
        Write-Warning "Could not retrieve boot time from $hostname"
    }
}