$inifile="c:\jade\system.ini"

$IniFunctions = @"
using System;
using System.Text;
using System.Runtime.InteropServices;

public class IniLibrary
{
    [DllImport("kernel32.dll")] 
    public static extern bool WritePrivateProfileString(
        string lpAppName, 
        string lpKeyName, 
        string lpString, 
        string lpFileName); 
}
"@

Add-Type -TypeDefinition $IniFunctions -PassThru | Out-Null
$Ini = New-Object IniLibrary

# WORKAROUND
# getaddrinfo used internally by the JADE RAP to resolve hostnames stopped working
# in current versions of windows/servercore:ltsc2019 (it no longer resolves with domain suffix)
# We use The powershell Resolve-DnsName cmdlet to do the lookup and patch the returned 
# IP address into the JadeClient.ServerNodeSpecifications INI setting
$dns_a = Resolve-DnsName fin-rap -type A
$sns = "TcpIp,$($dns_a.IPAddress),9901"
$Ini::WritePrivateProfileString("JadeClient", "ServerNodeSpecifications", $sns, $iniFile) | Out-Null
