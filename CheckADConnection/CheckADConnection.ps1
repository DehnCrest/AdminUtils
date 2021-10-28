$path = (Get-Item -Path "./").FullName
$servers = Get-Content "$path\servers.txt"
$Credentials = Get-Credential -Message 'Please enter an Administrator account'

foreach ($server in $servers) {
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "ServerName" -Value $server
    if ($server.Contains(".")) {
        $server = $server.Split(".")[0]
        
    }
    try {
        $res = Get-ADComputer -Identity $server -Credential $Credentials -ErrorAction Stop
        Write-Host $res -ForegroundColor Green
        $obj | Add-Member -MemberType NoteProperty -Name "ADStatus" -Value "Found in AD"
        $obj | Add-Member -MemberType NoteProperty -Name "FullInfo" -Value $res
    }
    catch {
        Write-Host "$server not found in AD" -ForegroundColor RED
        $obj | Add-Member -MemberType NoteProperty -Name "ADStatus" -Value "Not Found in AD"
        $obj | Add-Member -MemberType NoteProperty -Name "FullInfo" -Value "No Info Found in AD"
    }
    $obj | Export-Csv "$path\ADResults.csv" -Append -NoTypeInformation -Delimiter ","
}
