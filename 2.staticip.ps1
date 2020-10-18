Get-NetIPAddress
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAdress "192.168.100.2" -PrefixLength 24 -DefaultGateway "192.168.100.254"