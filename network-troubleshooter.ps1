
#Display options
Write-Host "1. Check Internet connection `n 2. View IP Configuration `n 3. View username"

#Read the user input and store in variable
$choice = Read-Host "Select an option to troubleshoot (1-3)"

# Write switch case to handle the output
switch($choice)
{
"1" {
# Check internet connection
$connectionStatus = Test-Connection -ComputerName "trackmid.com" -Count 1 -Quiet
if($connectionStatus -eq $true)
    {
        Write-Host "Internet is woring properly"
    }
    else
        {
         Write-Host "Unable to connect internet."
        }
        
}
"2" {
        # View IP Configuration
        $ipConfiguration=Get-NetIPConfiguration
       $ipAddress= $ipConfiguration.IPv4Address.IPAddress
       $defaultgateway=$ipConfiguration.IPv4DefaultGateway.NextHop
       Write-Host "IP Address: $ipAddress"
       Write-Host "Default gateway: $defaultgateway"
    }
"3" {
        #View user name
         Write-Host "username: $env:USERNAME"
    }
default {
            # Error: Request to re-run the script and ask user to select appropriate input
            Write-Host "Error: Invalid usre input. Please rerun the script and select appropriate option"
        }
}