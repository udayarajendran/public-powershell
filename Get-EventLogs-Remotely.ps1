# Prompt the user for the names of the Computer
$computer = Read-Host "Enter the names of the PC:"
Get-EventLog -LogName System -ComputerName $computer -After 12/14/2022 |Export-Csv output1.csv
