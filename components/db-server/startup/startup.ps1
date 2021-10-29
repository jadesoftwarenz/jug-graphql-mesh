$rootDirectory = "c:\jade"
$binDirectory = $rootDirectory + "\bin"
$logDirectory = $rootDirectory + "\logs"
$databaseDirectory = $rootDirectory + "\system"
$journalRootDirectory = $rootDirectory + "\journals"
$inifile="c:\jade\system.ini"

# Default Free Licence key
$regName="JADE Container World"
$regKey="C7B23D8ACEBEB2B0A6B2B0B39085B2B2"
function ApplyLicence { 
    param (
          [string]$name, 
          [string]$key
    )
    $arguments = "path=$databaseDirectory ini=$inifile " +
    "jadelog.logdirectory=$jadelogDirectory jadelog.logfile=jadregb name='$name' key='$key'"
    $proc = (Start-Process -FilePath $binDirectory\jadregb.exe -ArgumentList $arguments -PassThru -Wait -NoNewWindow)
    if ($proc.ExitCode -ne 0)
    {
          $result = $proc.ExitCode
          Write-Error "Licence operation failed, error code=$result"
          Exit 1 
    }
}

function LoadSchema { 
    param ([string]$mulFile)
    
    Push-Location "c:\jade\schema"
    & $binDirectory\jadclient.exe path=$databaseDirectory ini=$iniFile `
    persistentdb.journalrootdirectory=$journalRootDirectory `
    jadeLog.UseLogServer=true, jadeLog.LogServer=Console `
    jadelog.logdirectory=$logDirectory jadelog.logfile="schemaload" `
    schema=RootSchema app=JadeSchemaLoader server=localServer `
    startAppParameters schemaFile=$mulFile `
    loadStyle=onlyStructuralVersioning endAppParameters 
    Pop-Location
}

# Check to see if we have a database in place, if not create a default to initialise
if (-not (Test-Path "$databaseDirectory\_control.dat" -PathType leaf))
{
      Expand-Archive c:\jade\newdb.zip -DestinationPath c:\jade\system -Force
      ApplyLicence -name $regName -key $regKey

      Write-Output "Empty database installed."
}

if (-not (Test-Path "$databaseDirectory\fcdefault.dat" -PathType leaf)) {
    try {
        Write-Output "$databaseDirectory\fcdefault.dat not resident"
        Write-Output "Loading FC Demo Schemas..."
        LoadSchema -mulFile "c:\jade\schema\FCDemo.mul"
        Write-Output "FC schemas loaded."
    }
    catch {
        Write-Error "FC schema load failed!"
    }
}    

if (-not (Test-Path "$databaseDirectory\fcdata.dat" -PathType leaf)) {
    try {
        Write-Output "$databaseDirectory\fcdata.dat not resident"
        Write-Output "Loading FC data..."
        $exe = "$binDirectory\jadclient.exe"
        $arguments = "path=$databaseDirectory ini=$iniFile " +
        "jadelog.logdirectory=$logDirectory jadelog.logfile=dataload " +
        "persistentdb.journalrootdirectory=$journalRootDirectory " +
        "schema= FCModelSchema app=DataLoader " +
        "server=localServer startAppParameters c:/jade/dataFiles"
        $p = start-process -FilePath $exe -ArgumentList $arguments -PassThru
        $p.WaitForExit()
        Write-Output "FC data load finished."
    }
    catch {
        Write-Error "FC data load failed!"
    }
}    

Write-Output "RAP ready to start."
