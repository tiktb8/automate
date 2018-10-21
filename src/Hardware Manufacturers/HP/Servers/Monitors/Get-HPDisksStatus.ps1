<#
    .SYNOPSIS
    Retrieves status of physical hard disk information for HP servers.
    
    .DESCRIPTION
    The Get-HPDisksStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPDisksStatus
    Lists physical disk information for the local machine
    
#>
try {
    $diskdrives =  Get-WmiObject -Namespace root\hpq -Query "select * from HPSA_DiskDrive"
    ForEach ($disk in $diskdrives){
        if ($disk.OperationalStatus -ne 2)
        {
            return 2
        }
    }
    
}
catch {
    return "Failed to retrieve disk status"
    
}
return 0