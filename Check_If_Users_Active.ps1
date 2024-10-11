$usernames = Get-Content -Path "C:\!Intel\users.txt"
$results = @()

foreach ($username in $usernames) {
    $user = Get-ADUser $username -Properties Enabled
    $status = if ($user.Enabled) {"active"} else {"not active"}
    $results += New-Object PSObject -Property @{
        Username = $username
        Status = $status
    }
}

$results | Export-Csv -Path "C:\!Intel\user_status.csv" -NoTypeInformation