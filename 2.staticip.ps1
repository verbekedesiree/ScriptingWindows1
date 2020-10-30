$IPaddress= "192.168.100.2"
$prefix = "24"
$gw = "192.168.100.254"

Get-NetIPAddress
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAdress $IPaddress -PrefixLength $prefix -DefaultGateway $gw