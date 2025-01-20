Write-Host "What system information you would like to see"
Write-Host "1.Operating system `n2. CPU `n3.Total Memory `n4.Current user"
$choice=Read-Host "Enter your choice (1-4)"
if($choice -as [int])
{
    Switch ($choice)
    {
     
     1  {
            #Retrive the Operating system related information and return
            $os=Get-CimInstance -ClassName Win32_OperatingSystem
            Write-Host "windows caption: $($os.Caption)"
            Write-Host "windows version: $($os.Version)"
            Write-Host "windows Name: $($os.Name)"
        }
     2  {
            #Retrive the CPU relared information and return
            $cpu= Get-CimInstance -ClassName Win32_Processor
            $numberOfCores=$cpu.NumberOfCores
            $cpuName=$cpu.Name
            $clockSpeed=$cpu.MaxClockSpeed
            Write-Host "CPU Name: $cpuName `n Number of cores: $numberOfCores`n clock speed: $clockSpeed"
        }
     3  {
            #Retrive information related to total memory
            $systemInfo = Get-CimInstance -ClassName Win32_ComputerSystem
            $computerName=$systemInfo.Name
            $userDomain=$systemInfo.Domain
           $totalMemory= [System.Math]::Round($systemInfo.TotalPhysicalMemory / 1GB,2)
           Write-Host "$computerName is part of Domain `"$userDomain`" with total memory of size $totalMemory GB"
        }
     4  {
            # Retrive the current user name and return
            Write-Host "Current loggged-in user is: $($env:USERNAME)"
        }
    default {
                Write-Output "Error: Invalid user input, pelase select option from 1 to 4 only." 
            } 
    }
}
else{
    Write-Warning "Error: Invalid User input. User input should be a number, ranging from 1 to 4."
}