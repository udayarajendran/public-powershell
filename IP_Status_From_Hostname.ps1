$hostnames = Get-Content -Path "C:\!Intel\Workstations.txt"
$outputFile = "C:\!Intel\PC.csv"

$report = foreach ($hostname in $hostnames) {
    $ping = Test-Connection -ComputerName $hostname -Count 1 -Quiet -ErrorAction SilentlyContinue
    
    if ($ping) {
        $ipAddress = [System.Net.Dns]::GetHostAddresses($hostname) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -ExpandProperty IPAddressToString
        [PSCustomObject]@{
            Hostname = $hostname
            IPAddress = $ipAddress
            Status = "Online"
        }
    }
    else {
        [PSCustomObject]@{
            Hostname = $hostname
            IPAddress = ""
            Status = "Offline"
        }
    }
}

$report | Export-Csv -Path $outputFile -NoTypeInformation
