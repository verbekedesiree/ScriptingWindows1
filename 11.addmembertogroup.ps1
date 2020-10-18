Import-Module ActiveDirectory
$FileCSV = "C:\users\Administrator\Desktop\scripting\GroupMembers.csv"
#param([parameter(Mandatory=$true)] [String]$FileCSV)
$grouplist=Import-CSV $FileCSV -Delimiter ";"
ForEach($groupmember in $grouplist) {
try {  

        Add-ADGroupMember $groupmember.Identity `
        -Members $groupmember.Member        
        
        "$($groupmember.Member) is now in identity $($group.identity)" | Out-File "c:\logmembers.txt" -Append
}

catch{
    $error[0].Exception |out-file "c:\logmembers.txt" -Append
}
}