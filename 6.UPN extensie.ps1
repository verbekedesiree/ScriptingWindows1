#aanmaken extra upn
$UPN_suffix="mijnschool.be"

Get-ADForest | Set-ADForest -UPNSuffixes @{add=$UPN_suffix}