# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019

LABEL Description="IIS" Vendor="Microsoft" Version="10"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY /bin/ c:/bin/
COPY /bin_jadehttp/ c:/bin_jadehttp/

RUN Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe" `
    -OutFile "C:\ServiceMonitor.exe"

RUN Install-WindowsFeature Web-Server; `
    Install-WindowsFeature Web-CGI; `
    Install-WindowsFeature Web-ISAPI-Ext; `
    Install-WindowsFeature Web-ISAPI-Filter; `
    Install-WindowsFeature Web-Http-Tracing; `
    Enable-WebRequestTracing -Name \"Default Web Site\"

COPY vc_redist.x64.exe /
RUN Start-Process 'vc_redist.x64.exe' '/install /passive /norestart' -Wait;  Remove-Item vc_redist.x64.exe

RUN $iisAppPoolName = \"JadeREST\"; `
$appPool = New-WebAppPool -Name $iisAppPoolName; `
$appPool.managedPipelineMode = \"Classic\"; `
$appPool |Set-Item

RUN New-WebApplication `
    -Name JadeRestSite  `
    -Site 'Default Web Site' `
    -PhysicalPath \"C:\bin\" `
    -ApplicationPool JadeREST 

RUN C:\Windows\system32\inetsrv\appcmd.exe unlock config -section:system.webServer/handlers; `
Set-WebHandler `
    -Name ISAPI-dll `
    -Verb 'GET,POST,PUT,DELETE' `
    -path "*.dll" `
    -ScriptProcessor "C:\bin\jadehttp.dll"

RUN Add-WebConfiguration -filter "system.webServer/security/isapiCgiRestriction" `
-value @{description='Jade-ISAPI';path='C:\bin\jadehttp.dll';allowed='True'}; `
Set-WebConfiguration "/system.webServer/handlers/@AccessPolicy" -value \"Read, Script, Execute\"

RUN New-Item -Path \"c:\Temp\" -ItemType directory; `
New-WebVirtualDirectory -Site 'Default Web Site' -Name images -PhysicalPath \"c:\Temp\"

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"] 
