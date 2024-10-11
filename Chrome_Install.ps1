$installer = "C:\googlechromestandaloneenterprise64.msi"
$arguments = '/quiet'
$computer = Read-Host -Prompt "Enter the remote computer name:"

Invoke-Command -ComputerName $computer -ScriptBlock {msiexec.exe /i $using:installer $using:arguments}
