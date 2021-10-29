$rootPath = Split-Path(Split-Path $PSScriptRoot)
$utilityFunctions = "$rootPath\common\utility.ps1"
$configDirectory = "$rootPath\config"
$globalConfig = "$configDirectory\config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

$dbInitialised = $False;
if (!(Test-Path "$jadeDatabaseDirectory\_control.dat" -PathType leaf)) {
    Write-FormattedOutput "_control.dat not found in directory: $jadeDatabaseDirectory" -ForegroundColor Red
}
elseif (!(Test-Path "$jadeDatabaseDirectory\fcdefault.dat" -PathType leaf)) {
    Write-FormattedOutput "Demo schemas are not loaded in the $jadeDatabaseDirectory database" -ForegroundColor Red
}
else {
    $dbInitialised = $True;
}

if (!$dbInitialised) {
    Write-FormattedOutput "cd to infrastructure/boostrap and run deploy.ps1 to initialise the database" -ForegroundColor Yellow
    Exit 1
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
