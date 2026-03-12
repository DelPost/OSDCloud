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

Get-WindowsAutoPilotInfo -Online -TenantId 'd37a9f10-93f8-4619-89c3-e9a2d02d04ea' -AppId '44ebbefc-a8f2-4b60-a798-f508b9e5797f' -AppSecret 'hTi8Q~RsbPvvtHQqRlpLBIJCrqDN4lbinklftb5G' -GroupTag 'BabysamPOS' -Assign

Stop-Transcript

Write-Host -ForegroundColor Green "Running Autopilot Assignment"
