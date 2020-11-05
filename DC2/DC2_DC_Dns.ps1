
## upgrade van dc in een bestaande domain. inloggen met administrator@intranet.mijnschool.be
Install-WindowsFeature -ComputerName Win14-DC2 -Name AD-Domain-Services
    Enter-PSSession -ComputerName Win14-DC2 -Credential administrator
    Get-Command -Module ADDSDeployment
    Install-ADDSDomainController -InstallDns -Credential (Get-Credential "intranet.mijnschool.be\Administrator") -DomainName "intranet.mijnschool.be"
    Exit-PSSession
    
    #Verify DCs in Domain
    Get-DnsServerResourceRecord -ComputerName Win14-DC2 -ZoneName intranet.mijnschool.be -RRType Ns
    Get-ADDomainController -Filter * -Server Win14-DC2 |
        ft Name,ComputerObjectDN,IsGlobalCatalog

#set dns op dc1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2", "192.168.100.3") 

#dns op dc2

Invoke-Command -ComputerName Win14-DC2 -ScriptBlock {Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses ("192.168.100.2", "192.168.100.3") } -Credential Administrator
