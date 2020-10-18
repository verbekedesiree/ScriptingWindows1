$cred = Get-Credential
Invoke-command ` 
-ComputerName 192.168.1.4 `
-Credential (Get-Credential)
-Add-Computer -DomainName intranet.mijnschool.be -credential $using:cred -Restart