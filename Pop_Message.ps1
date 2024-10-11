Function remote_message{

$server = read-host -prompt 'Input PC name';
$message = read-host -prompt 'Enter the message';

Invoke-WmiMethod -Class win32_process -ComputerName $server -Name create -ArgumentList  "c:\windows\system32\msg.exe * $message" }

remote_message