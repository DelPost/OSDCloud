$Global:Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-OOBEScripts.log"
Start-Transcript -Path (Join-Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\OSD\" $Global:Transcript) -ErrorAction Ignore | Out-Null

Write-Host -ForegroundColor DarkGray "Installing AutopilotOOBE PS Module"
Start-Process PowerShell -ArgumentList "-NoL -C Install-Module AutopilotOOBE -Force -Verbose" -Wait

Write-Host -ForegroundColor DarkGray "Installing OSD PS Module"
Start-Process PowerShell -ArgumentList "-NoL -C Install-Module OSD -Force -Verbose" -Wait

Write-Host -ForegroundColor DarkGray "Executing Product Key Script"
Start-Process PowerShell -ArgumentList "-NoL -C Invoke-WebPSScript https://gist.githubusercontent.com/DelPost/e3542596fbdffdb872d68074e31b9b6f/raw/358709149f6c4b32d225487525c4925a6f9b5a10/Install-EmbeddedProductKey.ps1" -Wait

Write-Host -ForegroundColor DarkGray "Executing Autopilot Check Script"
Start-Process PowerShell -ArgumentList "-NoL -C Invoke-WebPSScript https://gist.githubusercontent.com/DelPost/b76fffec50cbe69a693a91eee1c1d2b1/raw/dfef85435e211a1c46ac07afabb35c54342e602b/AP-Prereq.ps1" -Wait

Write-Host -ForegroundColor DarkGray "Installing Get-WindowsAutopilotInfo module"
Start-Process PowerShell -ArgumentList "-NoL -C Invoke-WebPSScript https://gist.githubusercontent.com/DelPost/d0318b5894a3ec7d262c57f89aa05035/raw/78cbaaabac5cc44f9db49d3296ff4139f51f0440/AddAutopilotDeviceRITA.ps1" -Wait

Write-Host -ForegroundColor DarkGray "Executing OOBEDeploy Script from OSDCloud Module"
Start-Process PowerShell -ArgumentList "-NoL -C Start-OOBEDeploy" -Wait

Write-Host -ForegroundColor DarkGray "Executing Cleanup Script"
Start-Process PowerShell -ArgumentList "-NoL -C Invoke-WebPSScript https://gist.githubusercontent.com/DelPost/3c208aceb40b8083f0bc043c0097bf0c/raw/463a7ef49d23fd0ee1f47d5b728b0aec53f2cc62/CleanUp.ps1" -Wait

# Cleanup scheduled Tasks
Write-Host -ForegroundColor DarkGray "Unregistering Scheduled Tasks"
Unregister-ScheduledTask -TaskName "Scheduled Task for SendKeys" -Confirm:$false
Unregister-ScheduledTask -TaskName "Scheduled Task for OSDCloud post installation" -Confirm:$false

Write-Host -ForegroundColor DarkGray "Restarting Computer"
Start-Process PowerShell -ArgumentList "-NoL -C Restart-Computer -Force" -Wait

Stop-Transcript -Verbose | Out-File
