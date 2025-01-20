# Get system information for monitoring report

$computerName=$env:COMPUTERNAME

#get the Total and Free Memory /RAM from Operating system class
$os=Get-CimInstance Win32_OperatingSystem
$TotalMemory=$os.TotalVisibleMemorySize/1MB
$FreeMemory=$os.FreePhysicalMemory/1MB

# Calculate the memory used and perctage of memory used
$usedMemory=$TotalMemory-$FreeMemory
$usedMemoryPercentage = ($usedMemory/$TotalMemory)*100

# Get the processor related information
$processor=(Get-CimInstance Win32_Processor)

$cpu= $processor.LoadPercentage
$cores= $processor.NumberOfCores
$clockSpeed=$processor.MaxClockSpeed

# Get Total and free disk space from logical disk class
$cDrive = Get-CimInstance Win32_LogicalDisk | Where-Object DeviceID -EQ "C:"
$FreeSpace=$cDrive.FreeSpace
$totalSpace=$cDrive.Size
#Calculate the used space and used percentage
$usedSpace=$totalSpace-$FreeSpace
$usedSpacePercentage= ($usedSpace/$totalSpace)*100

$report = "`n`nSystem health report`n"
$report +="--------------------`n"
$report +="Generated On {0:yyyy-MM-dd HH:mm:ss}`n`n" -f (Get-Date)
$report += "----------- Memory Information  -----------"

$report += "Computer name      {0}`n" -f $env:COMPUTERNAME
$report += "Operating system   {0}`n" -f $os.Caption
$report += "Version            {0}`n" -f $os.Version
$report += "Total Memory       {0:N2} MB`n" -f $TotalMemory
$report += "Used memory        {0:N2} MB or {1:N2}%`n" -f $usedMemory,$usedMemoryPercentage
$report += "Free memory        {0:N2} MB`n`n" -f $FreeMemory

$report += "----------- Processor Information -----------"
$report += "`nName                 {0}" -f $processor.Name
$report += "`nStatus               {0}" -f $processor.CpuStatus.ToString()
$report += "`nLoad percentage      {0:N2}%" -f $cpu
$report += "`nTotal cores          {0}" -f $cores
$report += "`nCores used           {0}" -f $processor.NumberOfEnabledCore
$report += "`nMax Clock speed      {0}" -f $clockSpeed
$report += "`nCurrent Clock speed  {0}" -f $processor.CurrentClockSpeed


Write-Host $report