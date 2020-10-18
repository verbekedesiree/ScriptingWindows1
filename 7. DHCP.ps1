#install dhcp role
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools
$dnsdomain=$env:USERDNSDOMAIN
$dnsdomain=$dnsdomain.ToLower()

#add dhcpserver scope
Add-DhcpServerv4Scope `
-Computername $env:COMPUTERNAME `
-Name "eerste scope" `
-Startrange 192.168.100.1 `
-Endrange 192.168.100.254 `
-Subnetmask 255.255.255.0 `
-State Active 


#add dns server router gateway options in dhcp
Set-DhcpServerV4OptionValue -DnsServer 192.168.100.2,192.168.100.3 -Router 192.168.100.254 -DnsDomain $dnsdomain

#add extension scope
Add-Dhcpserverv4ExclusionRange `
-Computername $env:COMPUTERNAME `
-ScopeId 192.168.100.0 `
-StartRange 192.168.100.1 `
-EndRange 192.168.100.10  `

Add-DhcpServerv4ExclusionRange `
-Computername $env:COMPUTERNAME `
-Scopeid 192.168.100.0 `
-StartRange 192.168.100.253 `
-EndRange 192.168.100.254 

Add-DhcpServerv4Reservation `
-ScopeId 192.168.100.0 `
-Computername $env:Computername ` 
-IPAdress 192.168.100.200 `
-Name "printer.$dnsdomain" `
-ClientId "b8-e9-37-3e-55-86" `
-Description "hp laserjet"