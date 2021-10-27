$path = (Get-Item -Path "./").FullName
$servers = Get-Content "$path\servers.txt"

foreach ($server in $servers) {
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "ServerName" -Value $server
    try {
        if(Test-Connection $server -Count 1 -Quiet) {            
            $obj | Add-Member -MemberType NoteProperty -Name "PingStatus" -Value "Ping is ON"
            Write-Host "$server : Ping is working" -ForegroundColor Green
            
        } else {

            $obj | Add-Member -MemberType NoteProperty -Name "PingStatus" -Value "Ping is OFF"
            Write-Host "$server : Ping is not working" -ForegroundColor Red
        }

    } catch [System.UnauthorizedAccessException] {
        Write-Host "$server : Unauthorized Access Exception" -ForegroundColor Red
        $obj | Add-Member -MemberType NoteProperty -Name "PingStatus" -Value "Error getting Ping status"
    }
    $obj | Export-Csv "$path\PingResults.csv" -Append -NoTypeInformation -Delimiter ","
}
