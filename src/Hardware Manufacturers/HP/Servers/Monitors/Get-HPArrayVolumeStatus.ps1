<#
    .SYNOPSIS
    Retrieves array volume information for HP servers.
    
    .DESCRIPTION
    The Get-HPArrayVolumeStatus function works through WMI and requires
    that the HP Insight Management WBEM Providers are installed on
    the server that is being queried.
    
    .EXAMPLE
    Get-HPArrayVolumeStatus
    Lists array volume information for the local machine
    
    #>
try {
    $arraySystems = Get-WmiObject -Namespace root\hpq -Class HPSA_ArraySystem
    ForEach ($arraySystem in $arraySystems) {
        $arrayVolumes = Get-WmiObject -Namespace root\hpq -Query ("associators of {HPSA_ArraySystem.CreationClassName='HPSA_ArraySystem',Name='" + $arraySystem.Name + "'} WHERE AssocClass=HPSA_ArraySystemStorageVolume")
        ForEach ($arrayVolume in $arrayVolumes) {
            if ($arrayVolume.OperationalStatus -ne 2) {
                return 2
            }

        }
       
        
        
    }
    
}
catch {
    return "Failed to retrieve array volume status"
    
}
return 0