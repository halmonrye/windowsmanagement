<#	 
.SYNOPSIS
	Disables installation of specific device classes that could be used to gain access to locked Windows machines

.DESCRIPTION
	Adds the registry entries that enabling local machine policies would otherwise add.
	Meant to be run interactively
	
.LINK     
	none

.PARAMETER
	None. You cannot pipe objects to this script

.EXAMPLE 
		.\DisableAutoInstallNetworkDrivers.ps1

.NOTES
	Version    	      		: v0.1
	Rights Required			: Workstation Administrator
	Sched Task Req'd		: No
	Author       			: Hal Noble - UpTime Sciences (haln@uptimesciences.com)
	WebSite					: https://www.uptimesciences.com
	Disclaimer   			: You running this script means you won't blame me if this breaks your stuff.  It shouldn't.
	Assumptions				: ExecutionPolicy of at least RemoteSigned.  Unrestricted (not recommended) also works.
	Limitations				: Only returns news about specified ports
	Known issues			: Adding network devices later on may require removing one or more of these registry entries, installing the device and then re-adding the registtry entries
	Additional Information	:
	IEEE 1284.4 Devices
		Class = Dot4
		ClassGuid = {48721b56-6795-11d2-b1a8-0080c72e74a2}
		This class includes devices that control the operation of multifunction IEEE 1284.4 peripheral devices.

	IEEE 1394 Devices That Support the 61883 Protocol
		Class = 61883
		ClassGuid = {7ebefbc0-3200-11d2-b4c2-00a0C9697d07}
		This class includes IEEE 1394 devices that support the IEC-61883 protocol device class.
		The 61883 component includes the 61883.sys protocol driver that transmits various audio and video data streams over the 1394 bus. These currently include standard/high/low quality DV, MPEG2, DSS, and Audio. These data #	streams are defined by the IEC-61883 specifications.

	IEEE 1394 Devices That Support the SBP2 Protocol
		Class = SBP2
		ClassGuid = {d48179be-ec20-11d1-b6b8-00c04fa372a7}
		This class includes IEEE 1394 devices that support the SBP2 protocol device class.
		IEEE 1394 Host Bus Controller
		Class = 1394
		ClassGuid = {6bdd1fc1-810f-11d0-bec7-08002be2092f}
		This class includes 1394 host controllers connected on a PCI bus, but not 1394 peripherals. Drivers for this class are system-supplied.	
		
	Network Adapter
		Class = Net
		ClassGuid = {4d36e972-e325-11ce-bfc1-08002be10318}
		This class includes NDIS miniport drivers excluding Fast-IR miniport drivers, NDIS intermediate drivers (of virtual adapters), and CoNDIS MCM miniport drivers.
		
	See:System-Defined Device Setup Classes Available to Vendors 
	https://msdn.microsoft.com/en-us/library/windows/hardware/ff553426	
	
	Updates:
		2017-12-01 - hn - Initial script creation
		2017-12-04 - hn - Additional work and added revoking of OneDrive and SharePoint tokens
#>
#	"Allow administrators to override device installation policy" = Disabled
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v AllowAdminInstall /t REG_DWORD /d 0 /f
	
#	"Prevent installation of drivers matching these device setup classes" = Enabled
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v DenyDeviceClassesRetroactive /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses" /v 1 /t REG_SZ /d "{48721b56-6795-11d2-b1a8-0080c72e74a2}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses" /v 2 /t REG_SZ /d "{7ebefbc0-3200-11d2-b4c2-00a0C9697d07}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses" /v 3 /t REG_SZ /d "{d48179be-ec20-11d1-b6b8-00c04fa372a7}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses" /v 4 /t REG_SZ /d "{4d36e972-e325-11ce-bfc1-08002be10318}" /f

#end

