# Specify the name of the file you want to copy
$fileToCopy = "C:\!Install\qb.conf"

# Specify the path to the file containing the list of machines
$machineListFile = "C:\!Intel\Workstations.txt"

# Specify the path to the log file
$logFile = "C:\!Intel\file.log"

# Read the list of machines from the file and loop through each machine
Get-Content $machineListFile | ForEach-Object {
    $machine = $_
    $destinationFolder = "\\$machine\C$\ProgramData\Pfx\Qube"

    # Create the destination folder if it does not exist
    if (-not (Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder | Out-Null
    }

    # Copy the file to the destination folder and log the result
    try {
        Copy-Item $fileToCopy $destinationFolder -ErrorAction Stop | Out-Null
        $message = "File copied to $machine"
        Write-Host $message
        Add-Content $logFile $message
    } catch {
        $errorMessage = $_.Exception.Message
        $message = "Failed to copy file to $machine. Error message: $errorMessage"
        Write-Host $message -ForegroundColor Red
        Add-Content $logFile $message
    }
}
