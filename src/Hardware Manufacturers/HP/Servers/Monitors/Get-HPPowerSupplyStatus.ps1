<#
    .SYNOPSIS
    Retrieves status of power supplies for HP servers.
    
    .DESCRIPTION
    The Get-HPiPowerSupplyStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPiPowerSupplyStatus
    Lists power supply status for the local machine
    
#>
try {
    $powerSupplyModules = Get-WmiObject -Namespace "Root\Hpq" -Class "HP_PowerSupplyModule"                
    ForEach ($psu in $powerSupplyModules){

        if ($psu.HealthState -ne 5)
        {
            return 2
        }
    }
    
}
catch {
    return "Failed to retrieve power supply status"
    
}
return 0