# Read the list of computer names from a file
$computers = Get-Content "C:\!Intel\workstations.txt"

# Loop through each computer and retrieve the installed applications
foreach ($computer in $computers) {
    $products = Get-WmiObject -Class Win32_Product -ComputerName $computer | Select-Object Name, Version
    
    # Format the output as a list
    $header = "Installed applications on computer: $computer`n"
    $output = $products | ForEach-Object { "- $($_.Name) $($_.Version)" }
    $output = $header + ($output -join "`n")
    
    # Save the output to a text file
    $output | Out-File "C:\!Intel\Installed.txt" -Append -Encoding UTF8
}
