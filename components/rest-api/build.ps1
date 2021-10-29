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
    $fullTag = "$repoPrefix/${imageName}:${jadeVersion}-${buildConfig}"

    $binaryRepoDirectory = "$rootPath\$repoSubdir"
    Copy-Item -Path "${configDirectory}\$iniFile"  -Destination .
    
    Write-FormattedOutput "* Building image: $fullTag" -ForegroundColor Blue
    docker image build `
        --build-arg JADE_VERSION=$jadeVersion `
        --build-arg JADE_CONFIG=$buildConfig `
        -t $fullTag .
    if ($LASTEXITCODE -ne 0) { Throw "Build $imageName image failed" }
    $env:IMAGE_TAG = $fullTag    

    Remove-Item $iniFile

    Write-FormattedOutput "$imageName build complete. Time elapsed: $($(Get-Date) - $startTime)" -ForegroundColor Green
}

catch {
    Write-Error $_ 
    exit 1
}

finally {
    $ErrorActionPreference = $prevErrorAction
}
