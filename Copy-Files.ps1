$file = 'C:\!Install\installer.msi'
$PCName = Get-content "C:\Workstations.txt"
foreach ($Server in $PCName){
Copy-Item -Path $file -Recurse -Destination "\\$Server\c$\"
}