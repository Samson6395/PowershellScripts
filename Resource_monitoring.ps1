# get the system resource information 

$memory= [System.Math]::Round(((Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory/1MB),2)
$cpu = (Get-CimInstance Win32_Processor).LoadPercentage

# Display system information

Write-Host "Free physical memory: $memory `nCurrent CPU load % is $cpu"
