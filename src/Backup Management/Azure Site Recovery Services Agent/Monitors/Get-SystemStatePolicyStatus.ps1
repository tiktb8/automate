<#
    .SYNOPSIS
    Determines if the system state policy is valid.
    
    .DESCRIPTION
    The Get-SystemStatePolicyStatus function uses the MSOnlineBackup module    
    
    .EXAMPLE
    Get-SystemStatePolicyStatus
    
#>
Import-Module MSOnlineBackup
$policy = Get-OBSystemStatePolicy
if ($policy.PolicyState -ne 'Valid')
{
    return 2
}
else
{
    return 0
}
    