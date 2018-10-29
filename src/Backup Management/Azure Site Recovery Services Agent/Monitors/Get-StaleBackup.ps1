<#
    .SYNOPSIS
    Determines if the last backup is more than 7 days old.
    
    .DESCRIPTION
    The Get-StaleBackup function uses the MSOnlineBackup module    
    
    .EXAMPLE
    Get-StaleBackup
    
#>
Import-Module MSOnlineBackup
[System.Collections.ArrayList]$dataSources = @{}
$policy = Get-OBPolicy
$dateThreshold = (Get-Date).AddDays(-7)
Foreach ($ds in $policy.DsList) {
    #$dataSources.Add($ds.DataSourceName)
    $dataSourceName = $ds.DataSourceName
    $jobs = Get-OBAllRecoveryPoints | Where-Object {$_.DataSources -like "*$dataSourceName*"} | Sort-Object {$_.BackupTime} -Descending
    if (-not $jobs) {
        return 2
    }
    $lastJob = $jobs[0]  
    if ($lastJob.BackupTime -lt $dateThreshold)
    {
        return 2
    }
}

return 0