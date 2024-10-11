$list = Get-content "C:\intel\Workstations.txt"


foreach ($PC in $list){

echo $PC 
Get-PhysicalDisk | Out-File "c:\Intel\datadisk.txt"
 }  


