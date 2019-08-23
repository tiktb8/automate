<#
    .SYNOPSIS
    Retrieves array controller battery information for HP servers.
    
    .DESCRIPTION
    The Get-HPArrayControllerBatteryStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPArrayControllerBatteryStatus
    Lists array controller battery information for the local machine
    
    #>
try {
    $arraySystems =  Get-WmiObject -Namespace root\hpq -Class HPSA_ArraySystem
    ForEach ($arraySystem in $arraySystems){
        $arrayController = Get-WmiObject -Namespace root\hpq -Query ("associators of {HPSA_ArraySystem.CreationClassName='HPSA_ArraySystem',Name='" + $arraySystem.Name + "'} WHERE AssocClass=HPSA_ArraySystemArrayController")
        if ($arrayController.BatteryStatus -eq $null)
        {
            #No Battery
            return 0
        }
                
        
        if ($arrayController.BatteryStatus -ne 1)
        {
            return 2
        }
    }
    
}
catch {
    return "Failed to retrieve array controller battery status"
    
}
return 0