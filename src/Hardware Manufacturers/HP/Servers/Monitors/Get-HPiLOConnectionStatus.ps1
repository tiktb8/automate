<#
    .SYNOPSIS
    Retrieves status of iLO connection status information for HP servers.
    
    .DESCRIPTION
    The Get-HPiLOConnectionStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPiLOConnectionStatus
    Lists iLO connection status for the local machine
    
#>
try {
    $mpFirmwares =  Get-WmiObject -Namespace root\hpq -Query "select * from HP_MPFirmware"
    ForEach ($mpFirmware in $mpFirmwares){
        $mp = Get-WmiObject -Namespace root\hpq -Query ("ASSOCIATORS OF {HP_MPFirmware.InstanceID='" + $mpFirmware.InstanceID + "'} WHERE AssocClass=HP_MPInstalledFirmwareIdentity")

        if (($mp.NICCondition -eq 2) -or ($mp.NICCondition -eq 4))
        {
            return 0
        }
    }
    
}
catch {
    return "Failed to retrieve iLO connection status"
    
}