INSERT INTO RoleDefinitions( `RoleName`, `RoleType`, `RoleSubType`, `DetectionString`, `ComparisonOperator`, `ComparisonResult`, `SerialKeyString`, `ProductKeyString`, `SearchId`,`IsSupport`,`ParentRoleDefinitionGuid`,`IsRemote`,`RoleDetectionGuid`, `OSType` ) VALUES('Azure Site Recovery Services Agent','Backup','Agent','{%@powershell.exe \"Import-module MSOnlineBackup -ErrorAction SilentlyContinue\;get-obpolicy | select state\;\"@%}','ct','Existing','','',0,0,'',1,'5e764fa6-d54f-11e8-bc01-000d3a06af94',1);