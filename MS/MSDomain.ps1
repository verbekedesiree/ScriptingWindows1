$domain = "intranet.mijnschool.be"
$ipaddress = "192.168.100.3"
$dg = "192.168.100.254"
$Name ="WIN14MS"

Add-Computer `
-DomainName $domain
New-NetIPAddress –InterfaceAlias “Ethernet0” –IPAddress $ipaddress –PrefixLength 24 -DefaultGateway $dg
Set-DnsClientServerAddress -InterfaceAlias "ethernet0" -ServerAddress "192.168.100.2"