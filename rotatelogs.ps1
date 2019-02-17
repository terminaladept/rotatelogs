# Compress files in log folder older than 7 days
$logPath="C:\temp"
$daysback="-7"
$currentDate=Get-Date
$currentMonth=$currentDate.Month
$lastMonth=($currentDate.date.AddMonths(-1).Month)
$currentYear=$currentDate.Year
$lastYear=($currentDate.date.AddYears(-1).Year)
$compressDate=$currentDate.addDays($Daysback)
$logfiles=(Get-ChildItem $logpath | Where-Object {$_.LastWriteTime -lt $compressDate} )

ForEach ($logfile in $logfiles) {
    
    $fileLastWriteMonth=$logfile.LastWriteTime.Month
    write-host $fileLastWriteMonth
    write-host $logpath\$currentYear\"$currentMonth".zip
    # File written this month
    if ($fileLastWriteMonth -eq $currentMonth) 
    {
        Compress-Archive -Path $logfile.FullName -Update -DestinationPath $logpath\$currentYear\"$currentMonth".zip
        Write-host "Compressed $logfile, deleting now"
        Remove-Item $logfile.FullName
    }
    # File written last month (except when last month is December)
    elseif (($fileLastWriteMonth -eq $lastMonth) -and ( $lastMonth -ne "12"))
    {
        Compress-Archive -Path $logfile.FullName -Update -DestinationPath $logpath\$currentYear\"$lastMonth".zip
        Write-host "Compressed $logfile, deleting now"
        Remove-Item $logfile.FullName
    }
    # File written last month (when last is December)
    elseif (($fileLastWriteMonth -eq $lastMonth) -and ( $lastMonth -eq "12"))
    {
        Compress-Archive -Path $logfile.FullName -Update -DestinationPath $logpath\$lastYear\"$lastMonth".zip
        Write-host "Compressed $logfile, deleting now"
        Remove-Item $logfile.FullName
    }
    else { Write-host "Something went wrong! Date Mismatch processing $logfile`nSkipping $logfile" }
}
