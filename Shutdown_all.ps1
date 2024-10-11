$computers = Get-Content -Path "C:\!Intel\Shutdown.txt"
foreach ($computer in $computers) {
    Write-Host "Shutting down $computer..."
    $job = Stop-Computer -ComputerName $computer -Force -Confirm:$false -AsJob
    Wait-Job $job -Timeout 5
    if ($job.State -eq "Running") {
        Write-Host "Timed out while waiting for $computer to shut down."
        Remove-Job $job
    }
}
