    # Read the date from user

    $date = Read-Host "Enter the date:"

    #validate whether user input is a string or not.=
    if($date -as [String])
    {
        Write-Host "Provided input $date is a string"
        #Check if the user input is of type 'yyyy-MM-dd'
        if($date -like "????-??-??")
        {
            Write-Host "Provided date is in the correct format."
        }  
        else
        {
            Write-Host "That's an incorrect format, we need date should be in yyyy-MM-dd format"
        }
    }
    else{
    Write-Host "Provided date is not in string format"
      
    }