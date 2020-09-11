# SET EXECUTION POLICY TO UNRESTRICTED
Write-Host "Allowing System to Run this Script ..."
Set-ExecutionPolicy unrestricted

# SET TIME TO DC
Write-Host "Synchronizing Time with Domain Controller ..."
net time /set

# REMOVES THE UNWANTED APPS
# KEEPS CALCULATOR AND PAINT
Write-Host "Removing Unwanted Windows Apps ..."
$appList = Get-AppxPackage | Where-Object {$_.name -notlike "Microsoft.WindowsCalculator" -and $_.name -notlike "Microsoft.MSPaint"}

ForEach ($app in $appList) {
        Write-Output "Removing: $app"
        Remove-AppxPackage -AllUsers -Package $app
}

# DISABLE IPV6
Write-Host "Disabling IPv6 ..."
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

# DISABLE WEB PROXY
Write-Host "Disabling Automatic Proxy Detection ..."
$regkey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
Set-ItemProperty -path $regkey -name ProxyEnable -Value 0

# DISABLE NETBIOS
Write-Host "Disabling NetBios ..."
$regkey = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces"
Get-ChildItem $regkey | foreach { Set-ItemProperty -Path "$regkey\$($_.pschildname)" -Name NetbiosOptions -Value 2 -Verbose }

# DISABLE FIREWALL
Write-Host "Disabling Firewall ..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# ENABLE REMOTE DESKTOP CONNECTION
Write-Host "Enabling Remote Desktop Connections ..."
$path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
Set-ItemProperty -Path $path -Name "fDenyTSConnections" -value 0

# ENABLE ADMINISTRATOR ACCOUNT
Write-Host "Enabling and Setting Administrator Account ..."
$adminpass = ConvertTo-SecureString -String "PASSWORD" -AsPlainText -Force
Get-LocalUser -Name "Administrator" | Enable-LocalUser
Set-LocalUser -Name "Administrator" -Password $adminpass -AccountNeverExpires -PasswordNeverExpires $True

# ENABLE REMOTE REGISTRY
Write-Host "Enabling Remote Registry ..."
Set-Service -Name remoteregistry -StartupType Automatic
Get-Service -Name remoteregistry | Start-Service

# INSTALL IE8
Write-Host "Installing IE8 ..."
Start-Process msiexec.exe -Wait -ArgumentList '/I "PATH_TO_IE8_MSI" /quiet'

# INSTALL KASPERSKY NETWORK AGENT
Write-Host "Installing Kaspersky Network Agent ..."
Start-Process msiexec.exe -Wait -ArgumentList '/I "PATH_TO_NETWORK_AGENT_msi" /qn SERVERADDRESS="KSC_IP_ADDRESS" DONT_USE_ANSWER_FILE=1 PRIVACYPOLICY=1 EULA=1'

# INSTALL KASPERSKY ENDPOINT SECURITY
Write-Host "Installing Kaspersky Endpoint Security ..."
Start-Process msiexec.exe -Wait -ArgumentList '/I "PATH_TO_KES_.msi" /qn EULA=1 PRIVACYPOLICY=1 KSN=0'

# INSTALL OFFICE 2010
Write-Host "Installing Microsoft Office 2010 ..."
Start-Process "PATH_TO_\Office_2010\setup.exe" -Wait -ArgumentList '/config "PATH_TO\config.xml"' -NoNewWindow

# INSTALL ADOBE READER
Write-Host "Installing Adobe Reader ..."
Start-Process "PATH_TO_ADOBE_INSTALLER.exe" -Wait -ArgumentList '/msi /q' -NoNewWindow
