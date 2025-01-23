# Create a 2-D array and store information related to files in a directory
# Each inner array should have file name, extension, size in bytes and last modified date
function Get-FileInfo {
    param (
        [array] $files
    )
    
    # Loop through the array and print the file info
    foreach ($file in $files) {
        Write-Host " File Name: $($file[0])"
        Write-Host " Extension: $($file[1])"
        Write-Host " Size: $($file[2]) bytes"
        Write-Host " Last Modified: $($file[3])`n"
    }
}

# Example static file info array
$staticFiles = @(
    @("logical-operations", "ps1", 12345, ((Get-Date).AddDays(-10))),
    @("Manager-processes", "ps1", 1235 , ((Get-Date).AddDays(-9))),
    @("2025-01-15_report", "txt", 2568, ((Get-Date).AddDays(-8))),
    @("Rename-file", "ps1", 564, ((Get-Date).AddDays(-6)))
)

Get-FileInfo -files $staticFiles

# Get all the files from a path
$files = Get-ChildItem -Path C:\Users\Trackmind\Desktop\ | Sort-Object -Property Length -Descending

# Create an array to store file info
$FilesInfoArray = @()

foreach ($file in $files) {
    # Create an array with file name, extension, size in bytes and last modified date
    $FileInfo = @(
        $file.Name, $file.Extension, $file.Length, $file.LastWriteTime
    )
    # Add newly created array into the array created above
    $FilesInfoArray += , $FileInfo
}

Get-FileInfo -files $FilesInfoArray