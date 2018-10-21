<#
    .SYNOPSIS
    Retrieves the status of the last backup job from the MARS Agent.
    
    .DESCRIPTION
    The Get-LastBackupJobStatus function uses the MSOnlineBackup module    
    
    .EXAMPLE
    Get-LastBackupJobStatus    
    
#>
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
    