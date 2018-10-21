<#
    .SYNOPSIS
    Retrieves status of iLO health status information for HP servers.
    
    .DESCRIPTION
    The Get-HPiLOHealthStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPiLOHealthStatus
    Lists iLO health status for the local machine
    
#>
try {
    $mpFirmwares =  Get-WmiObject -Namespace root\hpq -Query "select * from HP_MPFirmware"
    ForEach ($mpFirmware in $mpFirmwares){
        $mp = Get-WmiObject -Namespace root\hpq -Query ("ASSOCIATORS OF {HP_MPFirmware.InstanceID='" + $mpFirmware.InstanceID + "'} WHERE AssocClass=HP_MPInstalledFirmwareIdentity")

        if ($mp.HealthState -ne 5)
        {
            return 2
        }
    }
    
}
catch {
    return "Failed to retrieve iLO health status"
    
}
return 0