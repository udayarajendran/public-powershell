$computers = Get-Content -Path "C:\!Intel\Workstations.txt"

$status = foreach ($computer in $computers) {
    if (Test-NetConnection -ComputerName $computer -InformationLevel Quiet) {
        "$computer is online"
    } else {
        "$computer is offline"
    }
}

$status | Out-File -FilePath "C:\!Intel\status.txt" -Encoding utf8