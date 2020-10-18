$subnet="192.168.100.0/24"

Add-DnsServerPrimaryZone
-ComputerName $env:COMPUTERNAME
-NetworkID $subnet
-ReplicationScope "Forest"

Register-DnsClient