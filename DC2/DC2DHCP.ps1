### installatie server role
Invoke-Command -ComputerName Win14-DC2 -ScriptBlock {
Install-WindowsFeature -Name DHCP -ComputerName Win14-DC2
$dnsdomain=$env:USERDNSDOMAIN
$dnsdomain=$dnsdomain.ToLower()
} -Credential Administrator

Invoke-Command -ComputerName Win14-DC2 -ScriptBlock {
Add-DhcpServerInDC -DnsName Win14-DC2 -IPAddress 192.168.100.3
Restart-service dhcpserver
} -Credential Administrator

##Configure dhcp failover
Add-DhcpServerv4Failover -Name Win14-DC1 -ScopeId 192.168.100.0 -PartnerServer Win14-DC2
