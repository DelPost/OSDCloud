# autopilotreg.osdcloud.ch
$Title = "Add device to Autopilot"
$host.UI.RawUI.WindowTitle = $Title
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
$env:APPDATA = "C:\Windows\System32\Config\SystemProfile\AppData\Roaming"
$env:LOCALAPPDATA = "C:\Windows\System32\Config\SystemProfile\AppData\Local"
$Env:PSModulePath = $env:PSModulePath+";C:\Program Files\WindowsPowerShell\Scripts"
$env:Path = $env:Path+";C:\Program Files\WindowsPowerShell\Scripts"

$Global:Transcript = "$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-AddToAutopilot.log"
Start-Transcript -Path (Join-Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\OSD\" $Global:Transcript) -ErrorAction Ignore

Write-Host "Adding device to Autopilot" -ForegroundColor Green

Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

$name = Read-Host 'New Computer Name'
Rename-Computer -NewName $name -Force

Install-Module -Name Get-WindowsAutopilotInfo -Force -Verbose

Get-WindowsAutoPilotInfo -Online -TenantId 'ea6a4d50-f637-4468-a256-dc0ecb7121dd' -AppId 'af491ae1-674d-4c32-b2b2-0a0917035f4c' -AppSecret 'Rrt8Q~jBXSxyCsPjadecYw6DGZ0Rbo7ui38o3aWM' -GroupTag 'BabysamPOS' -Assign

Stop-Transcript

Write-Host -ForegroundColor Green "Running Autopilot Assignment"
