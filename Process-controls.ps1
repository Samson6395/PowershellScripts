
function Process-Controls {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$processName,
        [Parameter(Position = 1, Mandatory = $true, HelpMessage = 'Accepts only: Start, Stop, Restart, Information')]
        [ValidateSet('Start', 'Stop', 'Restart', 'Information')]
        [string]$action
    )

    
    switch ($action) {
        "Start" {
            #Check if the process is already running
            if (Get-Process -Name $processName -ErrorAction SilentlyContinue | Select-Object CpuStatus -First 1) {
                Write-Host "Process $processName is already running"
                return
            }

            Write-Host "Starting process $processName"
            #Start the process
            Start-Process $processName  -ErrorAction SilentlyContinue
           
            #Check if the process started successfully, If not, display an error message
            if ($null -ne (Get-Process -Name $processName)) {
                Write-Host "Process $processName started successfully"
            }
            else {
                Write-Host "Process $processName failed to start"
            }
        }
        "Stop" { 
            $processinfo = Get-Process -Name $processName
            if ($null -ne $processinfo) {
                Write-Host "Process $processName is running and now trying to stop"
                Stop-Process -Name $processName
                Start-Sleep -Seconds 2
                if ($null -eq (Get-Process $processName -ErrorAction SilentlyContinue)) {
                    Write-Host "Process $processName stopped successfully"
                }
                else {
                    Write-Host "Process $processName failed to stop"
                }
            }
            else {
                Write-Host "Process $processName is is already stopped."
            }
        }
        "Restart" { 
            $processStatus = Get-Process $processName | Select-Object status -First 1

            if ($processStatus -eq "Running") {
                Write-Host "Process $processName is running and now trying to restart"
                Stop-Process -Name $processName
                Start-Sleep -Seconds 2
                Write-Host "Process $processName stopped. Now trying to start the process"
                Start-Process $processName
                Start-Sleep -Seconds 2
                if (Get-Process -Name $processName) {
                    Write-Host "Process $processName started successfully"
                }
                else {
                    Write-Host "Process $processName failed to start"
                }
            }
            else {
                Write-Host "Process $processName is not running. Trying to start the process $processName"
            }


        }
        "Information" {
            $processinfo = Get-Process -Name $processName -ErrorAction SilentlyContinue
            if ($null -ne $processinfo) {
                Write-Host "Process $processName is running"

                Write-Host "Process Name: $($processinfo.Name)"
                Write-Host "Process Id: $($processinfo.Id)"
                Write-Host "Process CPU Usage: $($processinfo.Cpu)"
                Write-Host "Process Memory Usage: $($processinfo.Memory)"
                Write-Host "Process start time: $($processinfo.StartTime)"
            }
            else {
                Write-Host "Process $processName is not running"
            }
        }
        Default {
            Write-Host "Invalid action. Please use one of the following actions: Start, Stop, Restart, Information, Status"
        }
    }
    

}

$processName = Read-Host "Enter the process name: "
Write-Host "Actions allowed are: Start, Stop, Restart, Information"
$action = Read-Host "Enter the action from above: "

Process-Controls -processName $processName -action $action