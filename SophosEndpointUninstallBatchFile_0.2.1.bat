REM <#
REM .SYNOPSIS
REM 	Uninstalls Sophos Endpoint Protection from a Windows workstation or server
REM 
REM .DESCRIPTION
REM 	Adds the registry entries that enabling local machine policies would otherwise add.
REM 	Meant to be run interactively
REM 	
REM .LINK     
REM 	none
REM 
REM .PARAMETER
REM 	None. You cannot pipe objects to this script
REM 
REM .EXAMPLE 
REM 		.\SophosEndpointUninstallBatchFile_0.2.1.bat
REM 
REM .NOTES
REM 	Version    	      		: v0.2.1
REM 	Rights Required			: Workstation Administrator
REM 	Sched Task Req'd		: No
REM 	Author       			: Hal Noble - UpTime Sciences (haln@uptimesciences.com)
REM 	WebSite					: https://www.uptimesciences.com
REM 	Disclaimer   			: You running this script means you won't blame me if this breaks your stuff.  It shouldn't.
REM 	Limitations				: You will need Administrative rights on the device in order to boot to safe mode and log in
REM 	Known issues			: 
REM 	Updates					: 2018-01-03 - hn - Added registry entries to turn off tamper protection, these need to be tested
REM								  2018-01-03 - hn - Added removal of Safe Mode boot and also deletes the script when finished
REM								  2018-01-03 - hn - Changed to v0.2.1
REM								  2017-12-27 - hn - Initial version 0.1
REM #>

: Turn Off Tamper Protection
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos MCS Agent" /v Start /t REG_DWORD  /d 0x00000004 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SAVEnabled /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SEDEnabled /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" /v Enabled /t REG_DWORD /d 0x00000000 /f

:  Stop Critical Sophos Services
net stop "Sophos Anti-Virus"
net stop "Sophos AutoUpdate Service"
 
: These may be for server only and may not work/apply to Desktops:
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\components\MCS" /v Enable /t REG_DWORD /d 0x00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\components\SAU" /v Enable /t REG_DWORD /d 0x00000000 /f

: Run the general uninstaller
"C:\program files\Sophos\Sophos Endpoint Agent\uninstallcli.exe"

:Sophos AutoUpdate
MsiExec.exe /qn /X{7CD26A0C-9B59-4E84-B5EE-B386B2F7AA16} REBOOT=ReallySuppress
MsiExec.exe /qn /X{BCF53039-A7FC-4C79-A3E3-437AE28FD918} REBOOT=ReallySuppress
MsiExec.exe /qn /X{9D1B8594-5DD2-4CDC-A5BD-98E7E9D75520} REBOOT=ReallySuppress
MsiExec.exe /qn /X{AFBCA1B9-496C-4AE6-98AE-3EA1CFF65C54} REBOOT=ReallySuppress
MsiExec.exe /qn /X{E82DD0A8-0E5C-4D72-8DDE-41BB0FC06B3E} REBOOT=ReallySuppress
:Sophos Anti-Virus (Endpoint)
MsiExec.exe /qn /X{8123193C-9000-4EEB-B28A-E74E779759FA} REBOOT=ReallySuppress
MsiExec.exe /qn /X{36333618-1CE1-4EF2-8FFD-7F17394891CE} REBOOT=ReallySuppress
MsiExec.exe /qn /X{DFDA2077-95D0-4C5F-ACE7-41DA16639255} REBOOT=ReallySuppress
MsiExec.exe /qn /X{CA3CE456-B2D9-4812-8C69-17D6980432EF} REBOOT=ReallySuppress
MsiExec.exe /qn /X{3B998572-90A5-4D61-9022-00B288DD755D} REBOOT=ReallySuppress
:Sophos Anti-Virus (Server)
MsiExec.exe /qn /X{72E30858-FC95-4C87-A697-670081EBF065} REBOOT=ReallySuppress
:Sophos System Protection
MsiExec.exe /qn /X{934BEF80-B9D1-4A86-8B42-D8A6716A8D27} REBOOT=ReallySuppress
MsiExec.exe /qn /X{1093B57D-A613-47F3-90CF-0FD5C5DCFFE6} REBOOT=ReallySuppress
:Sophos Network Threat Protection
MsiExec.exe /qn /X{66967E5F-43E8-4402-87A4-04685EE5C2CB} REBOOT=ReallySuppress
:Sophos Health
MsiExec.exe /qn /X{A5CCEEF1-B6A7-4EB4-A826-267996A62A9E} REBOOT=ReallySuppress
MsiExec.exe /qn /X{D5BC54B8-1DA1-44F4-AE6F-86E05CDB0B44} REBOOT=ReallySuppress
MsiExec.exe /qn /X{E44AF5E6-7D11-4BDF-BEA8-AA7AE5FE6745} REBOOT=ReallySuppress
:SDU (1.x)
MsiExec.exe /qn /X{4627F5A1-E85A-4394-9DB3-875DF83AF6C2} REBOOT=ReallySuppress
:Heartbeat
MsiExec.exe /qn /X{DFFA9361-3625-4219-82C2-9EF011E433B1} REBOOT=ReallySuppress
:Sophos Management Communications System
MsiExec.exe /qn /X{A1DC5EF8-DD20-45E8-ABBD-F529A24D477B} REBOOT=ReallySuppress
MsiExec.exe /qn /X{1FFD3F20-5D24-4C9A-B9F6-A207A53CF179} REBOOT=ReallySuppress
MsiExec.exe /qn /X{D875F30C-B469-4998-9A08-FE145DD5DC1A} REBOOT=ReallySuppress
MsiExec.exe /qn /X{2C14E1A2-C4EB-466E-8374-81286D723D3A} REBOOT=ReallySuppress
:UI
MsiExec.exe /qn /X{D29542AE-287C-42E4-AB28-3858E13C1A3E} REBOOT=ReallySuppress
:SophosClean
"C:\Program Files\Sophos\Clean\uninstall.exe"
:SED
"C:\Program Files\Sophos\Endpoint Defense\uninstall.exe" /quiet
:HMPA (managed) 3.5.3.563
"C:\Program Files (x86)\HitmanPro.Alert\hmpalert.exe" /uninstall /quiet
:HMPA 1.0.0.699
"C:\Program Files (x86)\HitmanPro.Alert\uninstall.exe" /uninstall /quiet
:HMPA 3.7.14.265
"C:\Program Files\HitmanPro\HitmanPro.exe" /uninstall /quiet

: Remove boot into safemode and reboot to normal
bcdedit /deletevalue {current} safeboot
shutdown /r

: Delete this script 
(goto) 2>nul & del "%~f0"