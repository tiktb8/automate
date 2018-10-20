# Monitor Return Codes
# 0 - OK
# 1 - WARNING
# 2 - CRITICAL
# 3 - UNKNOWN
# Remote Monitor Name: HW - Dell Server Virtual Disk Status 
# Remote Monitor Command: "%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -noprofile -command "(new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tiktb8/automate/master/src/Hardware Manufacturers/Dell/Servers/Monitors/Get-DellVirtualDiskStatus.ps1') | iex;"
omconfig preferences cdvformat delimiter=comma
$OmReport = omreport storage vdisk -fmt cdv |  select-string -SimpleMatch "ID,Status," -Context 0,5000

$vdisks = ConvertFrom-Csv $OmReport -Delimiter ","
foreach ($vdisk in $vdisks)
{
  if ($vdisk.Status -ne "Ok")
  {
    return 2
  }
}
return 0