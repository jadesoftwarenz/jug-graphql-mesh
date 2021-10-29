# escape=`
FROM registry.jadeworld.io/jade/non-gui-client:20.0.02-x64-U

COPY /system.ini c:/jade/
COPY startup.ps1 c:/jade/bin/

HEALTHCHECK --interval=20s --timeout=10s `
    CMD powershell -command `   
        try { `
            $response = Test-NetConnection -computername 127.0.0.1 -port 6208; `
            if ($response.TcpTestSucceeded) { `
                exit 0; `
            } `
            else { `
                exit 1; `
            }; `
        } `
        catch { `
            exit 1; `
        }

# define the entrypoint process
ENTRYPOINT powershell -command c:\jade\bin\startup.ps1; `
c:/jade/bin/jadclient.exe `
ini=c:/jade/system.ini, path=c:/jade/system, `
jadeLog.UseLogServer=true, jadeLog.LogServer=Console `
jadelog.logfile=fin_rest_service, jadelog.logdirectory=c:/jade/logs server=remoteServer `
schema=FCRestSchema app=FinRestApp server=remoteServer
