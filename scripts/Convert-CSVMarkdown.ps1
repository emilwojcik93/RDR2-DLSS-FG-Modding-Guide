<#
.SYNOPSIS
    This script converts between CSV and Markdown formats for a list of hyperlinks with titles and paragraphs/sections.
    The script includes a verbose flag for detailed logging and a default file argument for the source file.

.DESCRIPTION
    The script reads a CSV or Markdown file, extracts the relevant data, and generates a file in the opposite format with the same filename but with a different extension.
    If the output file already exists, it will be overwritten, and a log message will be printed.

.PARAMETER File
    The source file from which to extract data. This parameter is required.

.PARAMETER VerboseLogging
    Enables verbose logging and prints detailed output to the console.

.EXAMPLE
    PS> .\Convert-CSVMarkdown.ps1 -File "setup.md" -VerboseLogging
    Extracts hyperlinks from the specified markdown file and generates a CSV file with the extracted data, printing detailed logs.

.EXAMPLE
    PS> .\Convert-CSVMarkdown.ps1 -File "mods - setup_urls.csv" -VerboseLogging
    Extracts data from the specified CSV file and generates a Markdown file with the extracted data, printing detailed logs.

#>

param (
    [Parameter(Mandatory=$true)]
    [string]$File,

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

# Check if the source file exists
if (-not (Test-Path -Path $File)) {
    Write-Host "The specified file '$File' does not exist."
    exit 1
}

# Determine the direction of conversion based on the file extension
$extension = [System.IO.Path]::GetExtension($File).ToLower()
$outputFile = ""

if ($extension -eq ".md") {
    # Convert Markdown to CSV
    Write-VerboseLog "Converting Markdown to CSV..."

    # Read the content of the markdown file
    $content = Get-Content -Path $File

    # Extract TITLE, URL, and PARAGRAPH from the markdown file
    $links = @()
    $currentParagraph = ""
    foreach ($line in $content) {
        if ($line -match "^### (.+)$") {
            $currentParagraph = $matches[1]
        } elseif ($line -match "\[(.*?)\]\((.*?)\)") {
            $title = $matches[1]
            $url = $matches[2]
            $links += [PSCustomObject]@{ TITLE = $title; URL = $url; PARAGRAPH = $currentParagraph }
        }
    }

    # Generate the output CSV filename
    $outputFile = [System.IO.Path]::ChangeExtension($File, ".csv").Replace(".csv", "_urls.csv")

    # Check if the output file already exists
    if (Test-Path -Path $outputFile) {
        Write-VerboseLog "The file '$outputFile' already exists and will be overwritten."
    }

    # Write the extracted links to the CSV file
    $links | Export-Csv -Path $outputFile -NoTypeInformation

    # Print completion message
    Write-Host "CSV file generated: $outputFile"

} elseif ($extension -eq ".csv") {
    # Convert CSV to Markdown
    Write-VerboseLog "Converting CSV to Markdown..."

    # Read the content of the CSV file
    $csvContent = Import-Csv -Path $File

    # Generate the output Markdown filename
    $outputFile = [System.IO.Path]::ChangeExtension($File, ".md").Replace(".md", "_urls.md")

    # Check if the output file already exists
    if (Test-Path -Path $outputFile) {
        Write-VerboseLog "The file '$outputFile' already exists and will be overwritten."
    }

    # Write the extracted links to the Markdown file
    $markdownContent = @()
    $markdownContent += "| No | Hyperlink | Check |"
    $markdownContent += "|----|------------|-------|"
    $count = 1
    foreach ($row in $csvContent) {
        $check = if ($row.Step -match '\d') { ":heavy_check_mark:" } else { "" }
        $markdownContent += "| $count | [$($row.TITLE)]($($row.URL)) | $check |"
        $count++
    }
    $markdownContent | Out-File -FilePath $outputFile -Encoding utf8

    # Print completion message
    Write-Host "Markdown file generated: $outputFile"

} else {
    Write-Host "Unsupported file extension '$extension'. Only .md and .csv are supported."
    exit 1
}