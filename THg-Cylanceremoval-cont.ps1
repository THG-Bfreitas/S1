$S1File64 = "c:\temp\SentinelInstaller-x64_windows_64bit_v21_7_4_1043.exe"
$S1URL64 = "https://eusthginfrastructure.blob.core.windows.net/thg-remediation-scripts/SentinelInstaller-x64_windows_64bit_v21_7_4_1043.exe"
$s1keycsv = "C:\temp\THG-S1Key.CSV"
$SentinelSiteToken = Get-Content $s1keycsv

#removing Cylance
Start-Process -FilePath "$env:systemroot\system32\msiexec.exe" -ArgumentList '/quiet /X{3138EAD3-700B-4A10-B617-B3F8096EE30D} /norestart' -Wait 

#installing S1
mkdir c:\temp\ -ErrorAction SilentlyContinue

#download S1 Installer
Invoke-WebRequest -Uri "$S1URL64" -OutFile $S1File64
Start-BitsTransfer -Source $S1URL64 -Destination $S1File64

#Installing S1
Start-Process $S1File64 -ArgumentList "/SILENT /norestart /SITE_TOKEN=$SentinelSiteToken /log:C:\temp\S1Hilblogs.log"

Unregister-ScheduledTask -TaskName Hilb-S1Installer -Confirm:$false

Remove-Item –path $s1keycsv
