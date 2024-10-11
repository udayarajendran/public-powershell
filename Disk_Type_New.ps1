$machines = Get-Content -Path C:\workstations.txt
foreach ($servers in $machines)
{
    $results = Invoke-Command -ComputerName $Servers -ScriptBlock { 
        Get-PhysicalDisk | Select-Object FriendlyName,SerialNumber,MediaType,Size,@{Name='HostName';Expression={[System.Net.Dns]::GetHostName()}}
    }
    $results | Out-File "C:\!Intel\disk_type.txt"  -Append

    }