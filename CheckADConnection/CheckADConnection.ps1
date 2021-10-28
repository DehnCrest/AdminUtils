$path = (Get-Item -Path "./").FullName
$servers = Get-Content "$path\servers.txt"
$RSATTools = Get-WindowsCapability -Name Rsat.Active* -Online
if ($RSATTools.State -eq 'NotPresent') {
    Write-Host "RSAT Tools not found, installing the package" -ForegroundColor Yellow
    Add-WindowsCapability -Name $RSATTools.Name -Online
}
else {
    Write-Host 'RSAT Tools is already installed, skipping installation' -ForegroundColor Yellow
}

$AdminSESA = Get-Credential -Message 'Please enter an ADM account'
foreach ($server in $servers) {
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "ServerName" -Value $server
    if ($server.Contains(".")) {
        $server = $server.Split(".")[0]
        
    }
    try {
        $res = Get-ADComputer -Identity $server -Credential $AdminSESA -ErrorAction Stop
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
