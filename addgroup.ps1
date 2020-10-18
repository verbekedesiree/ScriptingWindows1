Import-Module activedirectory

$FileCSV = "C:\users\Administrator\Desktop\scripting\groups.csv"
#param([parameter(Mandatory=$true)] [String]$FileCSV)
$grouplist=Import-CSV $FileCSV -Delimiter ";"
ForEach($group in $grouplist) {
try {  

        New-ADGroup -Path $group.Path`
        -Name $group.Name `
        -DisplayName $group.DisplayName `
        -Description $group.Description `
        -GroupCategory $group.GroupCategory `
        -GroupScope $group.GroupScope 
        
        "$($group.name) 's made" | Out-File "c:\loggroep.txt" -Append
}

catch{
    $error[0].Exception |out-file "c:\loggroep.txt" -Append
}
}