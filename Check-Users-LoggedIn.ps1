$computer_list = Get-Content "C:\!Intel\Workstations.txt"
foreach ($computer in $computer_list) {
    $computer_name = $computer
    $output = "$computer_name : " + (Invoke-Command -ComputerName $computer -ScriptBlock {quser})
    $output | Out-File "C:\!Intel\output.txt" -Append -Width 200
}
