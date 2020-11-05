##DC2 update naar windows domein.

#Static maken dc2 kijken bij dhcp welke ip adres hij geeft. 192.168.100.13
$ipdc2="192.168.100.12"

Invoke-Command -ComputerName $ipdc2 -ScriptBlock {

#set ip address
New-NetIPAddress -InterfaceAlias "Ethernet0" -IPAddress "192.168.100.3" -PrefixLength 24 -DefaultGateway '192.168.100.254'
#set dns
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2") 

} -Credential Administrator

#DC2 in domain stoppen inloggen met intranet.mijnschool.be\administrator
Invoke-Command -ComputerName Win14-DC2 -ScriptBlock {Add-computer -DomainName intranet.mijnschool.be} -Credential Administrator 

## upgrade van dc in een bestaande domain. inloggen met administrator@intranet.mijnschool.be
##eerst dit in selectie runnen daarna enter pssession, get command, install-adds en exit alles apart uitvoeren
Install-WindowsFeature -ComputerName Win14-DC2 -Name AD-Domain-Services
    Enter-PSSession -ComputerName Win14-DC2
    Get-Command -Module ADDSDeployment
    Install-ADDSDomainController `
        -Credential (Get-Credential) `
        -InstallDns:$True `
        -DomainName 'intranet.mijnschool.be' `
        -DatabasePath 'C:\Windows\NTDS' `
        -LogPath 'C:\Windows\NTDS' `
        -SysvolPath 'C:\Windows\SYSVOL' `
        -NoGlobalCatalog:$false `
        -NoRebootOnCompletion:$False `
        -Force
    Exit-PSSession
    
    #Verify DCs in Domain
    Get-DnsServerResourceRecord -ComputerName Win14-DC2 -ZoneName intranet.mijnschool.be -RRType Ns
    Get-ADDomainController -Filter * -Server Win14-DC2 |
        ft Name,ComputerObjectDN,IsGlobalCatalog

#set dns op dc1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2", "192.168.100.3") 

#dns op dc2

Invoke-Command -ComputerName Win14-DC2 -ScriptBlock {Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2", "192.168.100.3") } -Credential Administrator
