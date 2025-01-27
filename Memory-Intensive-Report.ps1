# Parameter for Search functionality
param( [string]$SearchProcess)

# Initialize array list variable
$MemoryIntensiveProcesses = [System.Collections.ArrayList]::new()

$AllProcesses = Get-Process

# Add the processes that consume morethan 100 MB memory into array list

foreach ($process in $AllProcesses) {
    if ($process.WorkingSet / 1MB -gt 100) {
        [void] $MemoryIntensiveProcesses.Add($process)
    }
}

# Add search functionality and display the result

if ($SearchProcess) {
    Write-Host "Searching for $SearchProcess process"
    $found = $false
    $result = $MemoryIntensiveProcesses | Where-Object { $_.Name -eq $SearchProcess }
    if ($result) {
        $result | ForEach-Object {
            Write-Host "$SearchProcess is using $([System.Math]::Round(($_.WorkingSet / 1MB), 2)) MB of memory"
        }
        $found = $true
        exit
    }
    elseif (-not $found) {
        Write-Host "$SearchProcess is not using intensive memory or not in the intensive processes list"
        exit
    }
}


$sortedIntensiveProcessed = $MemoryIntensiveProcesses | Sort-Object -Property WorkingSet, Name -Descending

# Loop through the memory hungry processes and retutn the process name with memory utitlized in MB
foreach ($IntensiveProcess in $sortedIntensiveProcessed) {
    $memoryUsageInMB = [System.Math]::Round($IntensiveProcess.WorkingSet / 1MB, 2)
    Write-Host "$($IntensiveProcess.Name) is utilized $memoryUsageInMB MB"
}

# Calculate and diaply the total memory utilized by all the processes in array list

$totalMemory = [System.Math]::Round(($MemoryIntensiveProcesses | Measure-Object -Property WorkingSet -Sum).Sum / 1GB, 2)
Write-Host "Total memory consumed by all the Intensive processes is: $totalMemory in GB"