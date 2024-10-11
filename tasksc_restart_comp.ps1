# Create a trigger for the scheduled task (weekly on Fridays at 2 AM)
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday -At 02:00AM

# Create an action for the scheduled task (restart the computer)
$action = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '/r /t 0'

# Register the scheduled task
Register-ScheduledTask -TaskName 'Restart Computer on Fridays' -Trigger $trigger -Action $action -RunLevel Highest -Force

# Display the newly created scheduled task
Get-ScheduledTask -TaskName 'Restart Computer on Fridays'