<#
.SYNOPSIS
    Packages up a particular version of Node.js
    that has previously been restored.
.PARAMETER Version
    The version of Node.js to build a package for.
#>
Param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

$LayoutRoot = "$PSScriptRoot\obj\layout\$Version"
$LayoutRootSymbols = "$PSScriptRoot\obj\layoutsymbols\$Version"

$targetDir = "$PSScriptRoot\bin"
if (!(Test-Path $targetDir)) { $null = mkdir $targetDir }

$Properties = "src=$PSScriptRoot\src;common=$PSScriptRoot\obj\$Version"

.\nuget.exe pack $PSScriptRoot\src\Node.js.redist.nuspec -BasePath $LayoutRoot -OutputDirectory $targetDir -Version $Version -NoDefaultExcludes -Properties $Properties
.\nuget.exe pack $PSScriptRoot\src\Node.js.redist.symbols.nuspec -BasePath $LayoutRootSymbols -OutputDirectory $targetDir -Version $Version -NoDefaultExcludes -Properties $Properties
