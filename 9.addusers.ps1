Import-Module activedirectory

$FileCSV = "C:\users\Administrator\Desktop\ScriptingWindows1\useraccount.csv"
#param([parameter(Mandatory=$true)] [String]$FileCSV)
$listusers=Import-CSV $FileCSV -Delimiter ";"
$HomeServer = "Win14MS"
$HomeShare = "home"
$UPN = "intranet.mijnschool.be"
Foreach ($User in $listusers)
{ 
    $Name = $User.Name
    $SamAccountName = $User.SamAccountName
    $UserPrincipalName = $User.SamAccountName+"@"+$UPN_Suffix
    $DisplayName = $User.DisplayName
    $GivenName = $User.GivenName
    $SurName = $User.SurName
    $HomeDrive = $User.HomeDrive
    $HomeDirectory = "\\"+$HomeServer+"\"+$HomeShare+"\"+$User.Name
#    $ScriptPath = $User.ScriptPath
    $Path = $User.Path


    $AccountPassword = ConvertTo-SecureString $User.AccountPassword -AsPlainText -force


    try
    {
        Get-ADUser -identity $SamAccountName | Out-Null
        Write-Host $Name "already exits in" $Path "!"
    }
    catch
    {
        Write-Host "Making" $User.Name "in" $Path "..." 

 

        New-ADUser -Name $Name -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -DisplayName $DisplayName -GivenName $GivenName -Surname $SurName -HomeDrive $HomeDrive -HomeDirectory $HomeDirectory -Path $Path -AccountPassword $AccountPassword -Enabled:$true
#        New-ADUser -Name $Name -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName -DisplayName $DisplayName -GivenName $GivenName -Surname $SurName -Path $Path -AccountPassword $AccountPassword -Enabled:$true
        New-Item -Path $HomeDirectory -type directory -Force
        $acl = Get-Acl $HomeDirectory
        $acl.SetAccessRuleProtection($False, $False)
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($User.name,"Modify", "ContainerInherit, ObjectInherit", "None", "Allow")
        $acl.AddAccessRule($rule)
        Set-Acl $HomeDirectory $acl
    }
}