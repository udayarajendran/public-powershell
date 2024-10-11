# Specify the path to your text file containing hostnames
$hostnameFilePath = "C:\\!Intel\\Workstations.txt"

# Read hostnames from the text file
$hostnames = Get-Content -Path $hostnameFilePath

# Initialize an array to store the results
$results = @()

# Loop through each hostname from the text file
foreach ($hostname in $hostnames) {
    # Test connection to the remote computer with a timeout of 30 seconds
    if (Test-Connection -ComputerName $hostname -Count 1 -Quiet -TimeToLive 30) {
        # Query system information using the Invoke-Command cmdlet
        try {
            $systemInfo = Invoke-Command -ComputerName $hostname -ScriptBlock {
                $model = Get-WmiObject -Class Win32_ComputerSystem
                $processor = Get-WmiObject -Class Win32_Processor
                $ram = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
                $drives = Get-WmiObject -Class Win32_DiskDrive
                $graphicsCard = Get-WmiObject -Class Win32_VideoController

                foreach ($drive in $drives) {
                    [PSCustomObject]@{
                        Hostname = $env:COMPUTERNAME
                        Model = $model.Model
                        Processor = $processor.Name
                        RAM_GB = [math]::Round($ram.Sum / 1GB, 2)
                        Drive_Model = $drive.Model
                        Drive_Size_GB = [math]::Round($drive.Size / 1GB, 2)
                        Drive_MediaType = $drive.MediaType
                        GraphicsCard_Name = $graphicsCard.Name
                    }
                }
            } -HideComputerName -ErrorAction Stop

            # Add the system information to the results array
            $results += $systemInfo
        } catch {
            Write-Host "Failed to retrieve information from $hostname."
        }
    } else {
        Write-Host "Could not connect to $hostname within 30 seconds."
    }
}

# Export the results to a CSV file using the Export-Csv cmdlet
$results | Export-Csv -Path "C:\\!Intel\\SystemInfo.csv" -NoTypeInformation

Write-Host "System information has been exported to SystemInfo.csv"