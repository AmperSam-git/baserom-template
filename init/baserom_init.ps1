Clear-Host

# Directory Definitions
$WorkingDir = Get-Location
$ToolsDir = "$WorkingDir\tools"
$DocsDir = "$WorkingDir\docs"
$InitDir = "$WorkingDir\init"

# Dot includes
. $InitDir\tool_defines.ps1

# Hide git-related files
$filePatterns = @("*.gitkeep", "*.gitignore")
$filesToHide = Get-ChildItem -Path $WorkingDir -Recurse -Include $filePatterns
foreach ($file in $filesToHide) {$file.Attributes += [System.IO.FileAttributes]::Hidden}

# Function to remove junk files
function Remove-Junk($Directory, $JunkFiles) {
    # Iterate through list of "junk"
    foreach ($item in $JunkFiles) {
        # Get path of item
        $itemPath = Join-Path -Path $Directory -ChildPath $item
        if (Test-Path -Path $itemPath) {
            # Check if file or directory and delete accordingly
            if (Test-Path -Path $itemPath -PathType Leaf) {
                Remove-Item -Path $itemPath -Force
            } else {
                Remove-Item -Path $itemPath -Recurse -Force
            }
        }
    }
}

# Function to move documentation files
function Move-Docs($ToolName, $DocFiles, $Directory) {

    if (-not (Test-Path -Path "$DocsDir\$ToolName" -PathType Container)) {
        New-Item -Path "$DocsDir\$ToolName" -ItemType Directory -Force | Out-Null
    }

    if ($DocFiles -ne $null -and $DocFiles.Count -gt 0) {
        foreach ($file in $DocFiles) {
            $sourcePath = Join-Path -Path $Directory -ChildPath $file
            $destinationPath = Join-Path -Path $DocsDir -ChildPath $ToolName
            if (Test-Path -Path $sourcePath) {
                if (Test-Path -Path $sourcePath -PathType Container) {
                    # Move directories recursively
                    Copy-Item -Path $sourcePath -Destination $destinationPath -Force -Recurse
                    Remove-Item -Path $sourcePath -Recurse -Force
                } else {
                    # Move files
                    Move-Item -Path $sourcePath -Destination $destinationPath -Force
                }
            }
        }
    }
}

# Function to create .is_setup check file
function CheckFile-Create($Directory) {
    # Create is_setup checkfile
    New-Item -Path "$Directory.is_setup" -ItemType File | Out-Null
    # Make it a hidden file
    Set-ItemProperty -Path "$Directory.is_setup" -Name Attributes -Value ([System.IO.FileAttributes]::Hidden) | Out-Null
}

# Function to Download tool
function Download-Tool($Name, $Url) {
    Write-Host "$Name is not set up. `nDownloading..."
    Invoke-WebRequest -Uri $Url -OutFile "$env:temp\$Name.zip"
}

# Generic function to set up a tool
function SetupTool($ToolName, $DownloadUrl, $DestinationDir, $JunkFiles, $DocFiles, $ListFile) {
    if (Test-Path "$DestinationDir.is_setup" -PathType Leaf) {
        Write-Host "-- $ToolName already is set up in: $DestinationDir"
    } else {
        try {
            # Download Tool
            Download-Tool $ToolName $DownloadUrl
            # Expand Archive
            Expand-Archive -Path "$env:temp\$ToolName.zip" -DestinationPath $DestinationDir -Force
            # Move Readme files
            Move-Docs $ToolName $DocFiles $DestinationDir
            # Clean up junk files
            Remove-Junk $DestinationDir $JunkFiles
            # Copy pre-existing list file (if it exists)
            if ($ListFile -ne "") {
                Copy-Item -Path "$InitDir\lists\$ListFile" -Destination "$DestinationDir\list.txt" -Force
            }
            # Create is_setup checkfile
            CheckFile-Create $DestinationDir
            # Done
            Write-Host "Done. `n"
        } catch {
            Write-Host "An error occurred setting up $ToolName."
        }
    }

    # Lunar Magic
    if ($ToolName -eq "Lunar Magic") {
        # copy usertoolbar files to Lunar Magic directory
        Copy-Item -Path "$InitDir\usertoolbar\usertoolbar.txt" -Destination $LunarMagic_Dir -Force
        Copy-Item -Path "$InitDir\usertoolbar\usertoolbar_icons.bmp" -Destination $LunarMagic_Dir -Force
        Copy-Item -Path "$InitDir\usertoolbar\usertoolbar_wrapper.bat" -Destination $LunarMagic_Dir -Force
        # make a relative link to Lunar Magic in the root directory
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut("$WorkingDir\Lunar Magic.lnk")
        $shortcut.TargetPath = "$LunarMagic_Dir\Lunar Magic.exe"
        $shortcut.Save()
    }
}

# Specific function to set AddMusicK
function SetupAMK($ToolName, $DownloadUrl, $DestinationDir, $JunkFiles, $DocFiles) {
    if (Test-Path "$DestinationDir.is_setup" -PathType Leaf) {
        Write-Host "-- $ToolName already is set up in: $DestinationDir"
    } else {
        try {
            # Download Tool
            Download-Tool $ToolName $DownloadUrl
            # If AddMusicK destination doesn't exist, create it
            if (-not (Test-Path -Path $DestinationDir -PathType Container)) {
                New-Item -Path $DestinationDir -ItemType Directory
            }
            # AddMusicK specific actions because zip is subfolder >:(
            Expand-Archive -Path $env:temp\$ToolName.zip -DestinationPath $env:temp\ -Force
            Copy-Item "$env:temp\AddmusicK_*\*" -Destination $DestinationDir -Recurse -Force
            # Move Readme files
            Move-Docs $ToolName $DocFiles $DestinationDir
            # Clean up junk files
            Remove-Junk $DestinationDir $JunkFiles
            # Create is_setup checkfile
            CheckFile-Create $DestinationDir
            # Done
            Write-Host "Done. `n"
        } catch {
            Write-Host "An error occurred setting up $ToolName."
        }
    }
}


# Start the main menu loop
$UserChoice = $null
while ($UserChoice -ne "4") {
    Write-Host "Welcome! To set up your project's folder, run both of the following steps:`n"
    Write-Host " 1. Download and set up commonly used tools"
    Write-Host " 0. Exit`n"

    $UserChoice = Read-Host "Enter the number of your choice"

    if ($UserChoice -notin ("0", "1")) {
        Write-Host "`n'$UserChoice' is not a valid option, please try again.`n"
        continue
    }

    switch ($UserChoice) {

        # Download and Setup all Baserom Tools
        "1" {
            Clear-Host
            Write-Host "Checking state of tools...`n"
            # FunctionName | Tool Name | Download link | Destination Directory | Junk files | Documentation | List filename
            SetupAMK  "AddMusicK" $AddMusicK_Download $AddMusicK_Dir $AddMusicK_Junk $AddMusicK_Docs ""
            SetupTool "Asar" $Asar_Download $Asar_Dir $Asar_Junk $Asar_Docs "list_asar.txt"
            SetupTool "Flips" $Flips_Download $Flips_Dir $Flips_Junk $Flips_Docs ""
            SetupTool "GPS" $GPS_Download $GPS_Dir $GPS_Junk $GPS_Docs "list_gps.txt"
            SetupTool "PIXI" $PIXI_Download $PIXI_Dir $PIXI_Junk $PIXI_Docs "list_pixi.txt"
            SetupTool "Lunar Magic" $LunarMagic_Download $LunarMagic_Dir $LunarMagic_Junk $LunarMagic_Docs ""
            SetupTool "UberASMTool" $UberASMTool_Download $UberASMTool_Dir $UberASMTool_Junk $UberASMTool_Docs "list_uberasm.txt"
            Write-Host "`nTool setup complete."
        }


        # Exit
        "0" {
            Clear-Host
            Write-Host "Have a nice day ^_^"
            exit 0
        }
    }
}