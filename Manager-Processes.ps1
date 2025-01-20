    function Manage-Process {
        param (
            [string]$processName,
            [ValidateSet("start", "stop", "none")]
            [string]$action
        )

        $process = Get-Process -Name $processName -ErrorAction SilentlyContinue

        if ($process) {
            Write-Output "Process '$processName' is running."
            if ($action -eq "stop") {
                Stop-Process -Name $processName -Force
                Write-Output "Process '$processName' has been stopped."
            }
        } else {
            Write-Output "Process '$processName' is not running."
            if ($action -eq "start") {
                Start-Process -FilePath $processName
                Write-Output "Process '$processName' has been started."
            }
        }

        if ($action -eq "none") {
            Write-Output "No action taken on the process '$processName'."
        }
    }
    
    Manage-Process "notepad" -action "stop"