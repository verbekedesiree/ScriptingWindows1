$Hostname = "win14-DC1"
#change name
Rename-Computer -NewName "Dc1-SiteK" -Restart

#get ip address
Get-NetIPAddress

#set ip address
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress "192.168.100.2" -PrefixLength 24 -DefaultGateway '192.168.100.254'
#set dns
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("172.20.0.2","172.20.0.3") 

# install Active directory
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
