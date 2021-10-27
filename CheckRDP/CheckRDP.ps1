$path = (Get-Item -Path "./").FullName
$servers = Get-Content "$path/servers.txt"

foreach ($server in $servers) {
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "ServerName" -Value $server
    try {
        if((Test-NetConnection $server -CommonTCPPort RDP).TcpTestSucceeded) {
            $obj | Add-Member -MemberType NoteProperty -Name "RDPStatus" -Value "RDP is OK"
            Write-Host "$server : RDP is working" -ForegroundColor Green
            
        } else {
            $obj | Add-Member -MemberType NoteProperty -Name "RDPStatus" -Value "RDP is NOT OK"
            Write-Host "$server : RDP is not working" -ForegroundColor Red
        }

    } catch [System.UnauthorizedAccessException] {
        Write-Host "$server : Unauthorized Access Exception" -ForegroundColor Red
        $obj | Add-Member -MemberType NoteProperty -Name "RDPStatus" -Value "Error getting RDP status"
            
    }
    $obj | Export-Csv "$path\RDPResults.csv" -Append -NoTypeInformation -Delimiter ","
}
