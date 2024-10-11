$machines = Get-Content -Path "C:\!Intel\Workstations.txt"
$session = New-PSSession -ComputerName $machines
$results = Invoke-Command -Session $session -ScriptBlock {
    $hostname = hostname
    $quserOutput = quser
    $hostname + "," + $quserOutput
}
$results | ConvertFrom-Csv -Delimiter "," | Export-Csv -Path "C:\!Intel\loggeduser.csv" -NoTypeInformation
Remove-PSSession -Session $session
