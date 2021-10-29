$rootPath = Split-Path(Split-Path $PSScriptRoot)
$utilityFunctions = "$rootPath\common\utility.ps1"
$configDirectory = "$rootPath\config"
$globalConfig = "$configDirectory\config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

if (!(Test-Path $jadeBinDirectory)) {
    & ..\..\scripts\host-setup.ps1
}
else {
    Write-Warning "$jadeBinDirectory exists, binary installation skipped"
}

if ((Test-Path "$jadeDatabaseDirectory\fcdefault.dat" -PathType leaf)) {
    Write-Warning "$jadeDatabaseDirectory\fcdefault.dat exists, database initialisation skipped"
    Exit 1;
}

# set environment variables used in compose yaml
$env:Registry = $awsRegistry
$env:RepoPrefix = $repoPrefix
$env:DatabasePath = $jadeDatabaseDirectory
$env:JournalPath = $jadeJournalRootDirectory
$env:LogPath = $jadeLogDirectory
$env:RapListenPort = 9901
$env:AppServerListenPort = 443

docker-compose up -d
