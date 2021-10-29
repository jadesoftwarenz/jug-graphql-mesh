param(         
      [string] $config = 'Unicode' 
)
Import-Module BitsTransfer

$rootPath = Split-Path $PSScriptRoot
$utilityFunctions = "$rootPath\common\utility.ps1"
$configDirectory = "$rootPath\config"
$globalConfig = "$configDirectory\config.ps1"

# source global configuration and utility functions
. ($globalConfig)
. ($utilityFunctions)

$binaryRepoDirectory = "$rootPath\binaryRepo"
$binArchive = "JADE-$jadeVersion-x64-$config-binaries.zip"
$dbArchive = "JADE-$jadeVersion-$config-db.zip"
$localBinArchive = "$binaryRepoDirectory\$binArchive"
$localDbArchive = "$binaryRepoDirectory\$dbArchive"
$baseDownloadUrl = "https://secure.jadeworld.com/JADETech/latest/20.0.02-U"

if (!(Test-Path $binaryRepoDirectory)) {
      New-Item -ItemType Directory -Force -Path $binaryRepoDirectory
}

function DownloadFile { 
      param (
            [string]$source, 
            [string]$dest
      )
      try {
            Write-Output "downloading $dest ..."
            Start-BitsTransfer -Source $source -Destination $binaryRepoDirectory\$dest -ErrorAction Stop
            Write-FormattedOutput "$dest downloaded." -ForegroundColor blue
      }
      catch {
            Write-FormattedOutput $error -ForegroundColor red
            Write-FormattedOutput "$dest download failed." -ForegroundColor red
            Exit 1 
      }
}

$startTime = Get-Date 
Write-FormattedOutput "Installing an client binaries on container host: $hostName." -ForegroundColor Yellow

$error.clear()
if (!(Test-Path $localBinArchive -PathType leaf)) {
      DownloadFile -source "$baseDownloadUrl/$binArchive" -dest $binArchive
}

# obtain empty db for db server container build
if (!(Test-Path $localDbArchive -PathType leaf)) {
      DownloadFile -source "$baseDownloadUrl/$dbArchive" -dest $dbArchive
}

try {
      if (!(Test-Path $jadeRootDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeRootDirectory
      }
      if (!(Test-Path $jadeBinDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeBinDirectory
      }
      if (!(Test-Path $jadeDatabaseDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeDatabaseDirectory
      }
      if (!(Test-Path $jadeLogDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeLogDirectory
      }
      if (!(Test-Path $jadeJournalRootDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeJournalRootDirectory
      }
      if (!(Test-Path $jadeImagesDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeImagesDirectory
      }
      if (!(Test-Path $jadeDumpsDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeDumpsDirectory
      }
      if (!(Test-Path $jadeIISLogsDirectory)) {
            New-Item -ItemType Directory -Force -Path $jadeIISLogsDirectory
      }

      Expand-Archive $localBinArchive -DestinationPath $jadeBinDirectory -Force
      Write-Output "Client binaries installed in directory: $jadeBinDirectory"

      Copy-Item -Path "${configDirectory}/$iniFile"  -Destination $jadeRootDirectory

      Copy-Item -Path $dependencySourceDir/*.zip $binaryRepoDirectory 
  
      Write-FormattedOutput "Initialization of host environment complete. Time elapsed: $($(Get-Date) - $startTime)" -ForegroundColor Yellow
}
catch {
      Write-Error $_ -ErrorAction Continue
      exit 1 
}
