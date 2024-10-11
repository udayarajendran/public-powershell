$computerNames = Get-Content -Path "C:\!Intel\Workstations.txt"
$outputFile = "C:\!Intel\RDuser.txt"

# Clear the output file if it already exists
if (Test-Path $outputFile) {
    Clear-Content $outputFile
}

foreach ($computerName in $computerNames) {
    # Query the local Remote Desktop Users group on the current machine
    $group = [ADSI]"WinNT://$computerName/Remote Desktop Users,group"
    $members = $group.psbase.Invoke("Members") | Foreach-Object {
        [ADSI]$_.GetType().InvokeMember("Adspath", "GetProperty", $null, $_, $null)
    }

    # Write the machine name and group members to the output file
    Add-Content $outputFile "Machine: $computerName"
    Add-Content $outputFile "-----------------------------"
    foreach ($member in $members) {
        Add-Content $outputFile "User: $($member.Name)"
    }
    Add-Content $outputFile ""
}
