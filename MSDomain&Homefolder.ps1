#MS in domain stoppen
Invoke-Command -ComputerName Win14MS -ScriptBlock {Add-Computer -DomainName intranet.mijnschool.be } -Credential Administrator 

#home folder maken

Invoke-Command -ComputerName Win14MS -ScriptBlock { New-Item -Name "home" -Path 'C:\home' -ItemType Directory} -Credential Administrator 

#iedereen full controle
Invoke-Command -ComputerName Win14MS -ScriptBlock {
New-SmbShare  -Path 'C:\home' -FullAccess Everyone}
-Credential Administrator

#disable inheritance
Invoke-Command -ComputerName Win14MS -ScriptBlock{
$folder='C:\home'
$acl = Get-ACL -Path $folder
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path $folder -AclObject $acl

 } -Credential Administrator 


 # add user security permissions

#####!!!!!! nog te zoeken hoe je authenticated users toevoegt

