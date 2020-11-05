##DC2 update naar windows domein.

#set ip address
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress "192.168.100.3" -PrefixLength 24 -DefaultGateway '192.168.100.254'
#set dns
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2") 


##hostname
$Hostname = "win14-dc2"
Rename-computer -NewName $Hostname -Restart


#DC2 in domain stoppen inloggen met intranet.mijnschool.be\administrator
Add-computer -DomainName intranet.mijnschool.be -Credential intranet.mijnschool.be\Administrator 