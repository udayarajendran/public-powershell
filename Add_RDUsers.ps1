$Username = Read-Host "Enter the username for RDUsers:"
$ComputerName = Read-Host "Enter the hostname of the pc where RDUser to be added:"

# Use the Invoke-Command cmdlet to execute the Add-LocalGroupMember cmdlet within a remote session on the target computer
Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    Param($UserName)
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member $UserName
    Get-LocalGroupMember -Group "remote Desktop users"
} -ArgumentList $Username
