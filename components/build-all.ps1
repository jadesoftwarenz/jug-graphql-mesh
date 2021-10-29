$rootPath = (Split-Path $PSScriptRoot)
$utilityFunctions = "$rootPath\common\utility.ps1"
$globalConfig = "$rootPath\config\config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

function RemoveStoppedContainers { 
    $stopped = $(docker container ls -q -f 'status=exited')
    if ($null -ne $stopped) {
        docker container rm $stopped
    }
}

Push-Location $PSScriptRoot

# Check that docker engine is running before proceeding
Confirm-Docker-IsRunning

$startTime = Get-Date
$dockerfiles = Get-ChildItem -Filter Dockerfile -recurse 
Write-Output "* Building $($dockerfiles.Length) Dockerfiles"

try {
    $dockerfiles | ForEach-Object {
        Write-Host $_.DirectoryName
        Push-Location $_.DirectoryName
        ./build.ps1  
        Pop-Location
    }
}
catch
{
    Write-Error $_
    exit 1
}
finally {
    Pop-Location
    # remove any stopped containers left behind from failed builds
    RemoveStoppedContainers
}

Pop-Location

# cleanup
# remove stopped containers to unblock image prune 
RemoveStoppedContainers
# remove dangling images
docker image prune -f 
Write-FormattedOutput "Build all component images complete, elapsed time: $($(Get-Date) - $startTime)" -ForegroundColor Green
