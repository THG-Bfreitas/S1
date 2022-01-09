$SentinelSiteToken = "eyJ1cmwiOiAiaHR0cHM6Ly91c2VhMS0wMTQuc2VudGluZWxvbmUubmV0IiwgInNpdGVfa2V5IjogImQzNDY1MDVjM2U3M2RmNjEifQ=="
$S1File64 = "c:\temp\SentinelInstaller-x64_windows_64bit_v21_7_4_1043.exe"
$S1URL64 = "https://eusthginfrastructure.blob.core.windows.net/thg-remediation-scripts/SentinelInstaller-x64_windows_64bit_v21_7_4_1043.exe"

#removing Cylance
Start-Process -FilePath "$env:systemroot\system32\msiexec.exe" -ArgumentList '/quiet /X{3138EAD3-700B-4A10-B617-B3F8096EE30D} /norestart' -Wait 

#installing S1

mkdir c:\temp\ -ErrorAction SilentlyContinue

#download S1 Installer
#Invoke-WebRequest -Uri "$S1URL64" -OutFile $S1File64
Start-BitsTransfer -Source $S1URL64 -Destination $S1File64

#Installing S1
Start-Process $S1File64 -ArgumentList "/SILENT /norestart /SITE_TOKEN=$SentinelSiteToken /log:C:\temp\S1Hilblogs.log"
