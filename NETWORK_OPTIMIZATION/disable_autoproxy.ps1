 $regkey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
 Set-ItemProperty -path $regkey -name ProxyEnable -Value 0
