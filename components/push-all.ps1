$rootPath = (Split-Path $PSScriptRoot)
$utilityFunctions = "$rootPath/common/utility.ps1"
$globalConfig = "$rootPath/config/config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

Push-Location $PSScriptRoot
$startTime = Get-Date
$registry = $awsRegistry 

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/p5o1m4j3

Write-FormattedOutput "Pushing component images to: $registry" -ForegroundColor Blue
$dockerfiles = Get-ChildItem -Filter Dockerfile -recurse 
Write-FormattedOutput "* found $($dockerfiles.Length) component images"

try {
    $dockerfiles | ForEach-Object {
        Push-Location $_.DirectoryName
        $imageName = $(Get-Location).ToString().Split('\')[-1]
        if ($imageName -eq "iis") {
            $tag = "$iisTag"
        } else {
            $tag = "${jadeVersion}-$buildConfig"
        }

        $imageTag = "$repoPrefix/${imageName}:$tag"
        $registryTag = "$registry/$imageTag"

        Write-FormattedOutput "** pushing $registryTag" -ForegroundColor Blue
        docker image tag $imageTag $registryTag
            & docker image push $registryTag  
        # remove local tags
        docker rmi $imageTag
        docker rmi $registryTag
        Write-FormattedOutput "$registryTag pushed" -ForegroundColor Green
        Pop-Location
    }
}
finally {
    Pop-Location
}

Pop-Location

Write-FormattedOutput "Push all component images complete. Time elapsed: $($(Get-Date) - $startTime)" -ForegroundColor Green
exit 0
