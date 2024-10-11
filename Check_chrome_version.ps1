$computers = Get-Content "C:\!Intel\Workstations.txt"
Invoke-Command -ComputerName $computers -ScriptBlock {(Get-Item "C:\Program Files\Google\Chrome\Application\chrome.exe").VersionInfo}