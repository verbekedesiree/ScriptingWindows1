$dnsdomain=$env:USERDNSDOMAIN
$dnsdomain=$dnsdomain.ToLower()

#install dhcp role
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools

#add dhcpserver scope
Add-DhcpServer4Scope `
-Computername $env:Computername `
-Name "eerste scope" `
-Startrange 192.168.100.1 `
-Endrange 192.168.100.254 `
-Subnetmask 255.255.255.0 `
-State Active 

#add dns server router gateway options in dhcp
Set-DhcpServerv4OptionValue -DnsServer 192.168.100.2, 192.168.100.3 -ScopeId 192.168.100.0 -Router 192.168.100.254 -DnsDomain $dnsdomain

#add exclusion range
Add-DhcpServer4ExclusionRange `
-Computername $env:Computername `
-ScopeId 192.168.100.0 `
-Startrange 192.168.100.1 `
-Endrange 192.168.100.10 `

add-DhcpServerv4ExclusionRange `
-Computername $env:Computername `
-Scopeid 192.168.100.0 `
-Startrange 192.168.100.253 `
-Endrange 192.168.100.254

Add-DhcpServer4Reservation `
-Computername $env:Computername `
-IPAddress 192.168.100.200 `
-Name "printer.$dnsdomain"
-ClientId "b8-e9-37-3e-55-86"
-Description "HP Laserjet" 
