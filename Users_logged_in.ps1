$machines = Get-Content -Path "C:\Workstations.txt"
$session = New-PSSession -ComputerName $machines
$results = Invoke-Command -Session $session -ScriptBlock {
    $hostname = hostname
    $quserOutput = quser
    $quserOutput | Out-File "C:\quserOutput.txt" # Write quser output to file for debugging
    $hostname + "," + $quserOutput
}
$results | ConvertFrom-Csv -Delimiter "," | Export-Csv -Path "C:\!Intel\Users_logged.csv" -NoTypeInformation
Remove-PSSession -Session $session