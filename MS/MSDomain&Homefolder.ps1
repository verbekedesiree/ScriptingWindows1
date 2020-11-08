#MS in domain stoppen
Invoke-Command -ComputerName Win14-MS -ScriptBlock {Add-Computer -DomainName intranet.mijnschool.be } -Credential Administrator 

#home folder maken

Invoke-Command -ComputerName Win14-MS -ScriptBlock { New-Item -Name "home" -Path 'C:\home' -ItemType Directory} -Credential Administrator 

#iedereen full controle
Invoke-Command -ComputerName Win14-MS -ScriptBlock {
icacls "C:\home" /grant Everyone:F /T
New-SmbShare  -Path 'C:\home' -FullAccess Everyone
} -Credential Administrator




#disable inheritance
Invoke-Command -ComputerName Win14-MS -ScriptBlock{
$folder='C:\home'
$acl = Get-ACL -Path $folder
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path $folder -AclObject $acl

 } -Credential Administrator 


 # remove user security permissions
Invoke-Command -ComputerName Win14-MS -ScriptBlock{
    $acl = Get-ACl "C:\home"
    $accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "Read",,, "Allow")
    $acl.RemoveAccessRuleAll($accessrule)
    Set-ACl -Path "C:\home" -AclObject $acl
 } -Credential Administrator


 ##user toevoegen

Invoke-Command -ComputerName Win14-MS -ScriptBlock{
    $folder='C:\home'
    $acl = Get-ACl $folder
    $accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated users", "FullControl", "allow")
    $acl.SetAccessRule($accessrule)
    $acl | Set-Acl $folder
 } -Credential Administrator

