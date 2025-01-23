# Scopes of variables
# $runningCount -> Local variable
# $Local:runningCount -> Local variable
# $Script:runningCount -> Script level variable
# $Global:runningCount -> Global variable

# Initialize script level variables
$script:runningCount = 0
$script:NotRunningCount = 0

# Function to check the number of processes running by using Script level variable
function Check-ProcessStatus-variable {
    param(
        # process name variable to check the process status
        [Parameter(Mandatory = $true)]
        [string]$ParameterName
    )

    # Check if the process is running
    $ProcessStatus = Get-Process -Name $ParameterName -ErrorAction SilentlyContinue
    if ($ProcessStatus) {
        # Add 'script:' scope to the variable for script level variable
        $script:runningCount++
        return $true
    }
    else {
        $script:NotRunningCount++
        return $false
    }
}

# List of processes to check
$processesToCheck = @(
    @{ Name = "notepad"; DisplayName = "Notepad" },
    @{ Name = "explorer"; DisplayName = "Explorer" },
    @{ Name = "Taskmgr"; DisplayName = "Task Manager" },
    @{ Name = "SearchApp"; DisplayName = "Search Functionality" },
    @{ Name = "SecurityHealthSystray"; DisplayName = "Windows Security" }
)

# Check each process
foreach ($process in $processesToCheck) {
    if (Check-ProcessStatus-variable -ParameterName $process.Name) { 
        Write-Host "$($process.DisplayName) is running"
    }
    else {
        Write-Host "$($process.DisplayName) is not running" 
    }
}

Write-Host "------------------------------------"
Write-Host "Total processes checked: $($script:runningCount + $script:NotRunningCount)"
Write-Host "$script:runningCount processes are running"
Write-Host "$script:NotRunningCount processes are not running"