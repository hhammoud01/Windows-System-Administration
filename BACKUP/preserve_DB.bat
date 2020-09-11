@echo off
setlocal enabledelayedexpansion

net use * /d /y
net use /persistent:yes
net use \\IP_ADDRESS_OF_NAS\Database /u:USER PASSWORD

set dest="\\IP_ADDRESS_OF_NAS\Database"

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)

if "%mydate:~-2%"=="01" (
	for /f %%d in (
		'dir "%dest%\*" /t:c /a:d /o:-d /b'
	) do (
		set day=%%d
		set res=F
		if "!day:~-2!"=="01" set res=T
		if "!day:~-2!"=="08" set res=T
		if "!day:~-2!"=="15" set res=T
		if "!day:~-2!"=="22" set res=T
		if "!day:~-2!"=="28" set res=T

		if "!res!"=="F" (
			rd /s /q "%dest%\%%d"
		)
	)
)

net use /persistent:no
net use \\IP_ADDRESS_OF_NAS\Database /d /y
