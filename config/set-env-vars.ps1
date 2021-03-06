$configDirectory = $PSScriptRoot
$config = $configDirectory + "\config.ps1"
# source configuration
. ($config)

# set environment variables used in compose yaml
$env:Registry = $registry
$env:RepoPrefix = $repoPrefix
$env:Tag = $jadeVersion + "-x64-U"
$env:DatabasePath = $jadeDatabaseDirectory
$env:JournalPath = $jadeJournalRootDirectory
$env:ImagesPath = $jadeImagesDirectory
$env:IISLogPath = $jadeIISLogsDirectory
$env:DumpsPath = $jadeDumpsDirectory
$env:LogPath = $jadeLogDirectory
$env:RapListenPort = 9901
$env:AppServerListenPort = 443
