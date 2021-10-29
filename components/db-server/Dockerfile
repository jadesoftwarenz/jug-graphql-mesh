# escape=`
ARG JADE_VERSION=20.0.02
ARG JADE_CONFIG=U
FROM registry.jadeworld.io/jade/database-server:$JADE_VERSION-x64-$JADE_CONFIG

COPY system.ini newdb.zip c:/jade/
COPY dataFiles c:/jade/dataFiles
COPY schema c:/jade/schema
COPY startup c:/jade/bin/

VOLUME c:/jade/system

# Expose the database server port
EXPOSE 9901

# define the entrypoint process
ENTRYPOINT powershell -command c:\jade\bin\startup.ps1; `
c:/jade/bin/jadrapb.exe ini=c:/jade/system.ini, path=c:/jade/system `
jadeLog.UseLogServer=true, jadeLog.LogServer=Console `
persistentdb.journalrootdirectory=c:/jade/journals, jadelog.logfile=db_server, `
jadelog.logdirectory=c:/jade/logs 
