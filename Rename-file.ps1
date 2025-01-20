$fileName="report.txt"
$fileInfo=Get-Item -Path ".\$fileName"
$datetimeToPrefix=$fileInfo.CreationTime.ToString("yyyy-MM-dd")
$newFileName="$($datetimeToPrefix)_$($fileInfo.BaseName)$($fileInfo.Extension)"
Rename-Item -Path $fileName -NewName $newFileName
Write-Host "File name changed from $fileName to $newFileName"