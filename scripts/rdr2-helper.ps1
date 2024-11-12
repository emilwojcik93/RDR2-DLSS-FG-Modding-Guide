<#
.SYNOPSIS
    This script checks for the installation of Red Dead Redemption 2 on different PC platforms (Steam, Rockstar Games Launcher, Epic Games Store).
    If the game is not found in the default paths, it searches for the game directory on the C drive.
    If the game is still not found, it searches for the RDR2.exe file on all available drives.
    If the game is still not found, it displays an error message and stops the script.

.DESCRIPTION
    This script automates the process of locating the installation directory of Red Dead Redemption 2 on your PC. It checks the default installation paths for Steam, Rockstar Games Launcher, and Epic Games Store. If the game is not found in these locations, it searches the C drive for directories matching "Red Dead Redemption 2" and containing the "RDR2.exe" file. If the game is still not found, it searches all available drives for the "RDR2.exe" file. The script supports verbose logging and can copy the game directory path to the clipboard.

.PARAMETER Verbose
    Enables verbose logging and prints output to the console.

.PARAMETER FindLocation
    Finds the installation location of the game, copies the game root directory to the clipboard, and waits for enter before closing the terminal window.

.EXAMPLE
    PS> .\rdr2-helper.ps1 -Verbose
    Checks for the installation of Red Dead Redemption 2 and prints verbose logging to the console.

.EXAMPLE
    PS> .\rdr2-helper.ps1 -FindLocation
    Finds the installation location of the game, copies the game root directory to the clipboard, and waits for enter before closing the terminal window.

.LINK
    https://www.nexusmods.com/reddeadredemption2
    https://www.rdr2mods.com/downloads/rdr2/
    https://www.pcgamingwiki.com/wiki/Red_Dead_Redemption_2
    https://www.reddit.com/r/PCRedDead/comments/yn4jhz/rdr2_overall_recommended_graphical_settings/
    https://www.youtube.com/watch?v=Hyzp4zRivis
#>

param (
    [switch]$Verbose,
    [switch]$FindLocation
)

# Define possible installation paths for Red Dead Redemption 2
$steamPath = "C:\Program Files (x86)\Steam\steamapps\common\Red Dead Redemption 2"
$rockstarPath = "C:\Program Files\Rockstar Games\Red Dead Redemption 2"
$epicPath = "C:\Program Files\Epic Games\RedDeadRedemption2"

# Function to log verbose messages
function Write-VerboseLog {
    param (
        [string]$message
    )
    if ($Verbose) {
        Write-Host "[VERBOSE] $message"
    }
}

# Check which path exists and set it as the gamePath
Write-VerboseLog "Checking default installation paths..."
if (Test-Path $steamPath) {
    $gamePath = $steamPath
} elseif (Test-Path $rockstarPath) {
    $gamePath = $rockstarPath
} elseif (Test-Path $epicPath) {
    $gamePath = $epicPath
} else {
    Write-Host "Default paths not found in all known, default locations. Searching C drive for directories matching 'Red Dead Redemption 2'..."
    # Search for directories matching 'Red Dead Redemption 2' on the C drive
    $gamePath = Get-ChildItem -Path "C:\" -Recurse -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "*Red Dead Redemption 2*" } | ForEach-Object {
        if (Test-Path -Path (Join-Path -Path $_.FullName -ChildPath "RDR2.exe")) {
            $_.FullName
        }
    } | Select-Object -First 1

    if (-not $gamePath) {
        Write-Host "No matching directories found on C drive. Searching for 'RDR2.exe' on all drives..."
        # Search for the RDR2.exe file on all available drives
        $drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Root
        foreach ($drive in $drives) {
            Write-VerboseLog "Searching for 'RDR2.exe' on drive $drive..."
            $gamePath = Get-ChildItem -Path "$drive" -Recurse -File -Filter "RDR2.exe" -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty DirectoryName
            if ($gamePath) {
                break
            }
        }

        if (-not $gamePath) {
            Write-Host "Red Dead Redemption 2 installation not found."
            exit
        }
    }
}

Write-Host "Red Dead Redemption 2 found at: $gamePath"
Write-VerboseLog "Game path set to: $gamePath"

if ($FindLocation) {
    Write-VerboseLog "Copying game path to clipboard..."
    Set-Clipboard -Value $gamePath
    Write-Host "Game path copied to clipboard. Press Enter to close."
    Read-Host
    exit
}

# Identify ScriptHook log file
$scriptHookLog = Get-ChildItem -Path $gamePath -Filter *.log -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "ScriptHook.*\.log" } | Select-Object -ExpandProperty FullName

# Identify LML mod path
$lmlPath = Get-ChildItem -Path $gamePath -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq "lml" } | Select-Object -ExpandProperty FullName

# Function to list relative paths of install.xml files in lml path
function Get-LmlMods {
    if (Test-Path $lmlPath) {
        Write-VerboseLog "Listing install.xml files in LML path..."
        # List install.xml files
        $installXmlFiles = Get-ChildItem -Path $lmlPath -Recurse -Filter install.xml -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($gamePath.Length + 1) }

        if (-not $installXmlFiles) {
            $installXmlFiles = @("No install.xml files found.")
        }

        # List contents of replace directory
        $replacePath = Join-Path -Path $lmlPath -ChildPath "replace"
        if (Test-Path $replacePath) {
            Write-VerboseLog "Listing files in replace subdirectory..."
            $replaceFiles = Get-ChildItem -Path $replacePath -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($gamePath.Length + 1) }
            if (-not $replaceFiles) {
                $replaceFiles = @("Replace subdirectory is empty.")
            }
        } else {
            $replaceFiles = @("No replace subdirectory found.")
        }

        # List contents of stream directory
        $streamPath = Join-Path -Path $lmlPath -ChildPath "stream"
        if (Test-Path $streamPath) {
            Write-VerboseLog "Listing files in stream subdirectory..."
            $streamFiles = Get-ChildItem -Path $streamPath -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($gamePath.Length + 1) }
            if (-not $streamFiles) {
                $streamFiles = @("Stream subdirectory is empty.")
            }
        } else {
            $streamFiles = @("No stream subdirectory found.")
        }

        # Combine results
        $results = @()
        $results += "Install XML Files:"
        $results += $installXmlFiles
        $results += "`nReplace Subdirectory Files:"
        $results += $replaceFiles
        $results += "`nStream Subdirectory Files:"
        $results += $streamFiles

        $results
    } else {
        Write-Output "No LML mods found."
    }
}

# Function to list custom DLLs with details
function Get-CustomDlls {
    Write-VerboseLog "Listing custom DLLs..."
    $dlls = Get-ChildItem -Path $gamePath -Filter *.dll -ErrorAction SilentlyContinue
    if ($dlls) {
        $dlls | ForEach-Object {
            $details = $_ | Select-Object Name, LastWriteTime
            $versionInfo = (Get-ItemProperty -Path $_.FullName -ErrorAction SilentlyContinue).VersionInfo
            $customDetails = [PSCustomObject]@{
                FileDescription = $versionInfo.FileDescription
                ProductName = $versionInfo.ProductName
                FileName = $_.FullName
            }
            $details | Add-Member -MemberType NoteProperty -Name VersionInfo -Value $customDetails
            $details
        }
    } else {
        Write-Output "No custom DLLs found."
    }
}

# Function to parse ScriptHook log for loaded ASI mods
function Get-ScriptHookMods {
    Write-VerboseLog "Parsing ScriptHook log for ASI mods..."
    if (Test-Path $scriptHookLog) {
        $asiMods = Select-String -Path $scriptHookLog -Pattern "\.asi" -ErrorAction SilentlyContinue | ForEach-Object { $_.Line }
        if ($asiMods) {
            $asiMods | ForEach-Object {
                if ($_ -match "Starting audiotest thread for (.+\.asi)") {
                    $modPath = $matches[1]
                    $relativePath = $modPath.Substring($gamePath.Length + 1)
                    $relativePath
                }
            }
        } else {
            Write-Output "No ASI mods found in ScriptHook log."
        }
    } else {
        Write-Output "ScriptHook log not found."
    }
}

# Function to list INI files
function Get-IniFiles {
    Write-VerboseLog "Listing INI files..."
    $iniFiles = Get-ChildItem -Path $gamePath -Filter *.ini -ErrorAction SilentlyContinue
    if ($iniFiles) {
        $iniFiles | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($gamePath.Length + 1) }
    } else {
        Write-Output "No INI files found."
    }
}

# Function to list log files
function Get-LogFiles {
    Write-VerboseLog "Listing log files..."
    $logFiles = Get-ChildItem -Path $gamePath -Filter *.log -ErrorAction SilentlyContinue
    if ($logFiles) {
        $logFiles | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($gamePath.Length + 1) }
    } else {
        Write-Output "No log files found."
    }
}

# Get all mods and files
$lmlMods = Get-LmlMods
$customDlls = Get-CustomDlls
$scriptHookMods = Get-ScriptHookMods
$iniFiles = Get-IniFiles
$logFiles = Get-LogFiles

# Prepare output
$output = @()
$output += "Date: $(Get-Date)"
$output += "Game Installation Path:"
$output += $gamePath

$output += "`nLML Mods:"
$output += "These are mods installed via the Lenny's Mod Loader (LML) and are located in the 'lml' directory."
$output += $lmlMods

$output += "`nCustom DLLs:"
$output += "These are custom DLL libraries that might be mods or related to mods."
$customDlls | ForEach-Object {
    $output += $_.Name
    $output += "  LastWriteTime: $($_.LastWriteTime)"
    $output += "  VersionInfo:"
    $versionInfo = $_.VersionInfo
    $versionInfo.PSObject.Properties | ForEach-Object {
        if ($_.Value -ne $false -and $_.Value -ne $null -and $_.Value -ne "") {
            $output += "    $($_.Name): $($_.Value)"
        }
    }
}

$output += "`nScriptHook Mods:"
$output += "These are ASI mods loaded by ScriptHook."
$output += $scriptHookMods

$output += "`nINI Files:"
$output += "These are configuration files usually associated with mods."
$output += $iniFiles

$output += "`nLog Files:"
$output += "These are log files that might contain useful information about the game and mods."
$output += $logFiles

# Write output to log file in the same directory as the script
$logFilePath = "$PSScriptRoot\RDR2-Mods-Scan.log"
$output | Out-File -FilePath $logFilePath

# Display output only if Verbose flag is provided
if ($Verbose) {
    $output
}

# Print info about output log path
Write-Host "Output log written to: $logFilePath"