# Read the all the child items in a directory to find the number of total files and total file sizes based on extensions array.
# Initialize script level variables
$totalFiles = 0
$totalSize = 0

function FindFilesCountAndSizeBasedOnExtension {
    param (
        # Parameter help description
        [Parameter()]
        [string[]] $extensions = @(".txt", ".csv", ".png", ".jpg", ".sql"),
        [Parameter()]
        [string] $searchPath = "c:"
    )

    foreach ($extension in $extensions) {
        $files = Get-ChildItem -Path $searchPath -Recurse -Filter "*$extension"
    
        $totalFiles += $files.Count
        $size = ($files | Measure-Object -Property Length -Sum).Sum / 1MB
        $totalSize += $size

        Write-Host "Total number of files with $extension is $($files.Count) and size : $($size.ToString("N2")) MB"
    }

    Write-Host "Total number of files $totalFiles and size : $($totalSize.ToString("N2")) MB"
}

$filePath = Read-Host "Enter the path to check the files"

$fileExtensions = Get-ChildItem -Path $filePath -Recurse | Select-Object -ExpandProperty Extension -Unique

FindFilesCountAndSizeBasedOnExtension -extensions $fileExtensions -searchPath $filePath