$prevErrorAction = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

$rootPath = Split-Path (Split-Path $PSScriptRoot)
$utilityFunctions = "$rootPath\common\utility.ps1"
$configDirectory = "$rootPath\config"
$globalConfig = "$configDirectory\config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

$startTime = Get-Date

try {
    $imageName = $(Get-Location).ToString().Split('\')[-1]
    $fullTag = "$repoPrefix/${imageName}:$iisTag"

    # Copy files temporarily to script root for use in dockerfile
    Copy-Item "$configDirectory\bin" -Destination $PSScriptRoot -Recurse -Force
    Copy-Item "$configDirectory\bin_jadehttp" -Destination $PSScriptRoot -Recurse -Force
    Copy-Item "$jadeBinDirectory\VC_redist.x64.exe" -Destination $PSScriptRoot  
    Copy-Item "$jadeBinDirectory\jadehttp.dll" -Destination "$PSScriptRoot\bin\"
    
    Write-FormattedOutput "* Building image: $fullTag" -ForegroundColor Blue
    docker image build -t $fullTag .
    if ($LASTEXITCODE -ne 0) { Throw "Build $imageName image failed" }

    # Remove temporary files from script root.
    Remove-Item -Path $PSScriptRoot/bin -Recurse
    Remove-Item -Path $PSScriptRoot/bin_jadehttp -Recurse
    Remove-Item "VC_redist.x64.exe"

    Write-FormattedOutput "$imageName build complete. Time elapsed: $($(Get-Date) - $startTime)" -ForegroundColor Green
}

catch {
    Write-Error $_ 
    exit 1
}

finally {
    $ErrorActionPreference = $prevErrorAction
}
