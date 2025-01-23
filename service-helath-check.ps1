# Initialize variables for counting number of running and stopped services
# $RunningServices = 0
# $StoppedServices = 0

$ServicesUp = @()
$ServicesDown = @()

# Function to print Service information
function Print-ServiceInfo {
    param (
        
        [Parameter(Mandatory=$true)]
        [array]$Items
    )

        foreach ($currentItem in $Items) {
            [PSCustomObject]@{
                 Name = $currentItem[0]
                 Status =$currentItem[1]
                 StartUpType =$currentItem[2]
             } | Write-Output 
         }     
}

foreach ($service in Get-Service -ErrorAction SilentlyContinue) {
    if ($service.Status -eq 'Running') {
        $script:ServicesUp += ,@($service.Name, $service.Status, $service.StartType )
        # $RunningServices++
    }
    else {
        $script:ServicesDown += , @($service.Name, $service.Status, $service.ServiceType )
        # $StoppedServices++
    }
    #Write-Host "Service $($service.Name)) ($($service.DisplayName)) is currently $($service.Status)"
}

Write-Host "Total services: $($ServicesUp.Count + $ServicesDown.Count)"
# print the count of running services
Write-Host "Running services: $($ServicesUp.Count)" -ForegroundColor Green
# print the list of running services
Print-ServiceInfo -Items $ServicesUp

# print the count of stopped services
Write-Host "Stopped services:  $($ServicesDown.Count)"  -ForegroundColor Red
# print the list of stopped services
Print-ServiceInfo -Items $ServicesDown