REM TESTS CONNECTIVITY TO GIVEN NAMES AND IP ADDRESSES OF SITES, WRITTEN
REM IN A TXT FILE CALLED "SITES.TXT"
REM EACH LINE IN SITES IS IN THE FOLLOWING FORMAT:
REM NAME - TYPE_OF_LINK (FIBRE FOR EXAMPLE): IP_ADDRESS
REM EXAMPLE:
REM SITE1   - DSL: 192.168.1.1
REM SITE2   - MICROWAVE: 192.168.1.2
REM SITE3   - DSL: 192.168.1.3
REM SITE3   - FIBRE: 192.168.1.4
REM
REM THE OUTPUT IS IN THE FILE "PING RESULTS.TXT"

@echo off
Title Ping Test to Sites by xxxxxxxxxxxx
set "URLs=sites.txt"
set "LogFile=PingResults.txt"

If exist %LogFile% Del %LogFile%
(
	echo **************************************************************
	echo      PingTest Executed on %Date% at Time %Time%
	echo **************************************************************
	echo(
) > %LogFile%

setlocal enableextensions enabledelayedexpansion

for /f "tokens=1,2 delims=:" %%a in (%URLs%) do (
	set new=true
	set isDSL=true

	set site=%%a
	set ip=%%b

	REM check if it is a new site (for prettiness of output)
	if "!site:~0,1!"==" " set new=false

	REM check if it is a DSL link
	if "x!site:DSL=!"=="x!site!" set isDSL=false

	REM PING ONE TIME IF NOT DSL
	if "x!isDSL!"=="xfalse" ping -n 1 !ip! | find "TTL">nul

	REM PING TWO TIMES IF IT IS A DSL LINK
	if "x!isDSL!"=="xtrue" ping -n 2 !ip! | find "TTL">nul

	if not errorlevel 1 set state=Up
	if errorlevel 1 set state=Down
	set "msg=!site! (IP: !ip!): !state!"

	if "!new!"=="true" (
		echo -------------------------------------------------------------------
		echo !msg!
		echo -------------------------------------------------------------------   >> %LogFile%
		echo !msg! >> %LogFile%
	) else (
		echo !msg!
		echo !msg! >> %LogFile%
	)
)

EndLocal
start "" %LogFile%
pause>nul & exit
