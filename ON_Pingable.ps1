$computers = Get-Content "C:\workstations.txt"
$outputFile = "C:\outfile.txt"

foreach ($computer in $computers) {
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
        $message = "$computer is online and pingable."
    } else {
        $message = "$computer is either offline or not responding to pings."
    }
    Write-Host $message
    Add-Content $outputFile $message
}
