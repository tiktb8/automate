<#
    .SYNOPSIS
    Determines if the last system state backup is more than 10 days old.
    
    .DESCRIPTION
    The Get-StaleSystemStateBackup function uses the MSOnlineBackup module    
    
    .EXAMPLE
    Get-StaleSystemStateBackup
    
#>
Import-Module MSOnlineBackup
$systemStateJobs = Get-OBAllRecoveryPoints | Where-Object {$_.DataSources -eq 'System State'} | Sort-Object {$_.BackupTime} -Descending
if (-not $systemStateJobs)
{
    return 2
}
$lastJob = $systemStateJobs[0]
$dateThreshold = (Get-Date).AddDays(-10)

if ($lastJob.BackupTime -lt $dateThreshold)
{
    return 2
}
else
{
    return 0
}
    