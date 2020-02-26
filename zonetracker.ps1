. ./config.ps1
$zoneArray = @()

$poeLogPath = "$poeInstallPath\logs"
$poeClientLog = "$poeLogPath\Client.txt"

$clientLogContent = Get-Content $poeClientLog
$zoneLines = $clientLogContent | Select-String "You have entered"

ForEach ($line in $zoneLines) {
    $date = $line.toString().split()[0]
    $hour = ($line.toString().split()[1]).split(":")[0]
    $zone = (($line.toString() -split "You have entered")[1]).trim().trim(".")
    
    $obj = New-Object PSObject -Property @{
        date=$date;
        hour=$hour;
        zone=$zone;
    }
    $zoneArray += $obj
}

$zoneArray | Group-Object -Property date, hour, zone | Sort-Object -Property Name | Select Count, Name