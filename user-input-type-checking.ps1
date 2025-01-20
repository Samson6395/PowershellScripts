function userInput-validation
{
param(
[string]$data,
[int]$inputType
)

    if($PSBoundParameters.ContainsKey('data'))
    { 
        Write-Host "User input is: $($PSBoundParameters.Values)" 
    }
    $status=$true
    # Use switch statement to validate the user input
    Switch ($inputType)
    {
        1 {
            # Validate Email
            if ($data -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') {
                $status= $false
            }
         }
       2 {
             # Validate Mobile number
            if($data -notmatch ("^\d{10}$"))
            {
                $status= $false
            }
         }
      3 {
             # Validate Full Name
            if([string]::IsNullOrWhiteSpace($data) -and $data.Length -gt 2)
            {
                $status= $false
            }
        }
      4 {
             # Validate Password
            if($data.Length -lt 8)
            {
               $status= $false
            }
        }
      5 {
             # Validate Address
            if($data.Length -lt 20 -or $data.Length -gt 50)
            {
                $status= $false
            }
        }
    }
    
    return $status

}


function main
{
param([array]$userInputs)

$continue=$false

    Write-Host "Options are:"
    for($i=0;$i -lt $userInputs.Length;$i++)
    {
        Write-Host "$($i+1). $($userInputs[$i])"
    }

    $inputType=Read-Host "Select an option from the above input type options (1-5)"

        if($inputType -match "^\d$" -and $inputType -ge 1 -and $inputType -le 5)
        {
          do{  
                Write-Host "Selected input is valid"
                $userValue=Read-Host "Enter $($userInputs[($inputType-1)])"

                # Call UserInput-Validation method to check if the user input value is in valid format or not
               $status= userInput-validation -inputType $inputType -data $userValue

               if($status -eq $true) {
                    Write-Host -MessageData "$userValue is Valid $($userInputs[($inputType-1)])!" -ForegroundColor Green
               }
               else {
                    Write-Host "$userValue is not a valid $($userInputs[($inputType-1)])!" -ForegroundColor Red
               }

               $consent=Read-Host "Do you want to continue(Yes/No)? Bydefault 'No' will be considered"
        
            if($consent -eq "Yes")
                {$continue=$true}
             else {$continue=$false}
        }
        while($continue)
    }
    else        {
           Write-Host "Invaid user input" -ForegroundColor Red   
        }
}

main -userInputs @("Email","Mobile number","FullName","Password","Address")