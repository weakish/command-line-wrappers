# .SYNOPSIS
#
# mcd <folder>
# .DESCRIPTION
#
# mkdir folder && cd folder
# .PARAMETER path
#
# Path to folder.
function mcd([string]$path)
{
    $directory = (New-Item -Path $path -ItemType directory).FullName
    Set-Location $directory
}