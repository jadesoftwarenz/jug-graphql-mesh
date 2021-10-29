
$GreenTick = @{
    Object = [Char]8730
    ForegroundColor = 'Green'
    NoNewLine = $true
}

function Confirm-Docker-IsRunning
{
    $engineServiceName = "docker"
    $dockerRunning = $false
    $service = Get-Service $engineServiceName -ErrorAction 0 -ErrorVariable gsError
    if ($?) {
        if ($service.Status -eq "Running") {
            Write-FormattedOutput "Docker Engine is Running" -ForegroundColor Yellow
            $dockerRunning = $true
        }
        else {
            Write-FormattedOutput "Docker Engine Service is $service.Status" -ForegroundColor Red
        }
    } else {
        Write-FormattedOutput "Docker engine is not running: '$gserror'" -ForegroundColor Red
    }

    if (!$dockerRunning) {
        Write-Output "Start the Docker engine before running this script"
        Pop-Location
        Exit 1
    }
}

function Write-FormattedOutput
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)][Object] $Object,
         [Parameter(Mandatory=$False)][ConsoleColor] $BackgroundColor,
         [Parameter(Mandatory=$False)][ConsoleColor] $ForegroundColor
    )    

    # save the current color
    $bc = $host.UI.RawUI.BackgroundColor
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    if($BackgroundColor -ne $null)
    { 
       $host.UI.RawUI.BackgroundColor = $BackgroundColor
    }

    if($ForegroundColor -ne $null)
    {
        $host.UI.RawUI.ForegroundColor = $ForegroundColor
    }

    Write-Output $Object
  
    # restore the original color
    $host.UI.RawUI.BackgroundColor = $bc
    $host.UI.RawUI.ForegroundColor = $fc
}
function CheckDockerLog { 
    param (
        [string] $containerName,
        [string] $searchPattern
    )
    $found = $false
    for ($i = 0; $i -lt 10; $i++) {
        $line = 'docker logs $containerName | Select-String $searchPattern'
        if ($null -ne $line) {
            $found = $true
            break;
        }
        Start-Sleep -Seconds 1
    }
    return $found
}
