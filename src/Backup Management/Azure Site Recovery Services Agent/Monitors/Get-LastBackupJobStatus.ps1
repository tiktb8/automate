# Remote Monitor Name: BU - Azure Recovery Services Agent - Last Backup Status 
# Remote Monitor Command: "%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -noprofile -command "(new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tiktb8/automate/master/src/Backup Management/Azure Site Recovery Services Agent/Get-LastBackupJobStatus.ps1') | iex;"
Import-Module MSOnlineBackup
$lastJob = Get-OBJob -Previous 1
if ($lastJob.JobStatus.JobState -ne 'Completed')
{
    return 2
}
else
{
    return 0
}
    