<#
.SYNOPSIS
    This script creates subdirectories in a target directory based on a list of directory names provided in a separate file.
    The script includes verbose logging and prints each action for parsing, changing values, creating directories, and handling errors.

.DESCRIPTION
    The script reads a list of directory names from a specified file, removes unsupported characters for directory naming,
    and creates subdirectories with a prefix number in the target directory passed as an argument.

.PARAMETER Directory
    The target directory where subdirectories will be created. This parameter is required.

.PARAMETER ListFile
    The file containing the list of directory names. This parameter is required.

.PARAMETER Path
    The base path where the target directory will be created. This parameter is optional.

.PARAMETER VerboseLogging
    Enables verbose logging and prints detailed output to the console.

.EXAMPLE
    PS> .\Create-Subdirs.ps1 -Path "./mods" -Directory "User Interface" -ListFile "dirs.txt" -VerboseLogging
    Reads the list of directory names from "dirs.txt" and creates subdirectories in the "User Interface" directory inside the "./mods" path, printing detailed logs.
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$Directory,

    [Parameter(Mandatory=$true)]
    [string]$ListFile,

    [string]$Path,

    [switch]$VerboseLogging
)

# Function to log verbose messages
function Write-VerboseLog {
    param (
        [string]$message
    )
    if ($VerboseLogging) {
        Write-Host "[VERBOSE] $message"
    }
}

# Check if the list file exists
if (-not (Test-Path -Path $ListFile)) {
    Write-Host "The specified list file '$ListFile' does not exist."
    exit 1
}

# Determine the full target directory path
if ($Path) {
    $fullDirectoryPath = Join-Path -Path $Path -ChildPath $Directory
} else {
    $fullDirectoryPath = $Directory
}

# Read the content of the list file
$dirNames = Get-Content -Path $ListFile

# Create the target directory if it does not exist
if (-not (Test-Path -Path $fullDirectoryPath)) {
    Write-VerboseLog "Creating target directory: $fullDirectoryPath"
    New-Item -Path $fullDirectoryPath -ItemType Directory
}

# Function to remove unsupported characters for directory naming
function Remove-UnsupportedCharacters {
    param (
        [string]$name
    )
    $name -replace '[<>:"/\\|?*]', ''
}

# Create subdirectories
$count = 1
foreach ($dirName in $dirNames) {
    Write-VerboseLog "Processing directory name: $dirName"
    $cleanDirName = Remove-UnsupportedCharacters -name $dirName
    Write-VerboseLog "Cleaned directory name: $cleanDirName"
    $subDirName = "$count - $cleanDirName"
    $subDirPath = Join-Path -Path $fullDirectoryPath -ChildPath $subDirName

    try {
        Write-VerboseLog "Creating subdirectory: $subDirPath"
        New-Item -Path $subDirPath -ItemType Directory
        Write-Host "Created subdirectory: $subDirPath"
    } catch {
        Write-Host "Error creating subdirectory: $subDirPath"
        Write-Host $_.Exception.Message
    }

    $count++
}