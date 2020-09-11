REM REMOVE SCCM CLIENT
if exist C:\windows\system32\ccmsetup\ccmsetup.exe (
	C:\windows\system32\ccmsetup\ccmsetup.exe /uninstall
	Rd /s /q C:\windows\system32\ccmsetup
)

if exist C:\windows\ccmsetup\ccmsetup.exe (
	C:\windows\ccmsetup\ccmsetup.exe /uninstall
	Rd /s /q C:\windows\ccmsetup
)

