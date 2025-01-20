$dayOfWeek=(Get-Date).AddDays(2).DayOfWeek
$currentHour=(Get-Date).AddHours(-3).Hour

$isWeekDay = $dayOfWeek -ge 1 -and $dayOfWeek -le 5
$isBussinessHours = $currentHour -ge 9 -and $currentHour -lt 17

if($dayOfWeek -eq "Wednesday" -and ($currentHour -ge 14 -and $currentHour -le 15))
{
    Write-Host "Team meeting time" -BackgroundColor White -for DarkCyan
}
elseif( $isWeekDay -and $isBussinessHours)
{
    Write-Host "Bussiness hours" -ForegroundColor Green
}
else {
    Write-Host "Off Hours" -ForegroundColor Red
}