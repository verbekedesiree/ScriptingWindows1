#region - Name Computer RUN ON DC1
        Rename-Computer -NewName Win14-DC1
        Restart-computer 
#endregion
#region - Set IP, Timezone, Install AD & DNS RUN ON DC1

    #Set IP Address
        New-netIPAddress -IPAddress 192.168.100.2`
        -PrefixLength 24 `
        -DefaultGateway 192.168.100.254 `
        -InterfaceAlias Ethernet0
    #Set TimeZone
        Tzutil.exe /s "Central Standard Time"
    #Install AD & DNS
       #Install ADDS Role and Mgt Tools
        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
       ##Import ADDSDeployment Module
        Import-Module ADDSDeployment
       ##Install a new AD Forest
        Install-ADDSForest `
	        -CreateDnsDelegation:$false `
	        -DatabasePath "C:\Windows\NTDS" `
	        -DomainMode "Win2012R2" `
	        -DomainName "intranet.mijnschool.be" `
	        -DomainNetbiosName "intranet" `
	        -ForestMode "Win2012r2" `
	        -InstallDns:$true `
	        -LogPath "C:\Windows\NTDS" `
	        -NoRebootOnCompletion:$false `
	        -SysvolPath "C:\Windows\SYSVOL" `
	        -Force:$true
#endregion