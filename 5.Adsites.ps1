$new_site_name="Kortrijk"
$subnet="192.168.100.0/24"

Get-ADReplicationSite "Default-First-Site-Name" | Rename-ADObject -NewName $new_site_name
Get-ADReplicationSite $new_site_name | Set-ADReplicationSite -Description $new_site_name
New-ADReplicationSubnet -Name $subnet -Site $new_site_name -Description $new_site_name -Location $new_site_name