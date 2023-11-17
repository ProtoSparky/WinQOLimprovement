@echo off
::echo Remember to run as administrator
::Uncommend this if you want backups of registry
::echo Backing up registry keys...
::reg export "HKEY_LOCAL_MACHINE" "%~dp0HKEY_LOCAL_MACHINE.reg" 
::reg export "HKEY_CURRENT_USER" "%~dp0HKEY_CURRENT_USER.reg"
::reg export "HKEY_CURRENT_CONFIG" "%~dp0HKEY_CURRENT_CONFIG.reg"
::reg export "HKEY_USERS" "%~dp0HKEY_USERS.reg"
::reg export "HKEY_CLASSES_ROOT" "%~dp0HKEY_CLASSES_ROOT.reg"


::echo Deleting registry keys...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
::echo Re-enabling features...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f
::echo Creating registry keys...
reg add "HKCU\SOFTWARE\Policies\Microsoft\MMC" /v RestrictToPermittedSnapins /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\MMC\{3D5D035E-7721-4B83-A645-6C07A3D403B7}" /v Restrict_Run /t REG_SZ /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\MMC\{58221C66-EA27-11CF-ADCF-00AA00A80033}" /v Restrict_Run /t REG_SZ /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\MMC\{58221C67-EA27-11CF-ADCF-00AA00A80033}" /v Restrict_Run /t REG_SZ /d 0 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\MMC\{5D6179C8-17EC-11D1-9AA9-00C04FD8FE93}" /v Restrict_Run /t REG_SZ /d 0 /f
::echo Deleting registry keys...
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /f
::echo deleted ActiveDesktop
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /f
::echo deleted Personalization
reg delete "SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection" /f
::echo deleted App and Browser protection
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /f
::echo deleted Windows Defender
reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MMC" /f
::echo deleted Microsoft\MMC
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /f
::echo deleted NC_ShowSharedAccessUI
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f
::echo deleted Explorer

::echo clear update cache
::net stop wuauserv
::net stop cryptSvc
::net stop bits
::net stop msiserver
::ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
::mkdir C:\Windows\SoftwareDistribution
::net start wuauserv
::net start cryptSvc
::net start bits
::net start msiserver
::rd /s /q C:\Windows\SoftwareDistribution.old
::pause