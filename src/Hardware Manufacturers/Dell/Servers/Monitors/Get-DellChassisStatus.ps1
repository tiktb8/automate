# Monitor Return Codes
# 0 - OK
# 1 - WARNING
# 2 - CRITICAL
# 3 - UNKNOWN
# Remote Monitor Name: HW - Dell Server Chassis Status 
# Remote Monitor Command: "%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -noprofile -command "(new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tiktb8/automate/master/src/Hardware Manufacturers/Dell/Servers/Monitors/Get-DellChassisStatus.ps1') | iex;"
$chassisStatus = omstatus chassis | out-string
if($chassisStatus -Match "Critical")
{
    return 2
}
else
{
    return 0
}
    