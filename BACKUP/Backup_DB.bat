@echo off

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)

net use * /d /y
net use /persistent:yes
net use \\IP_ADDRESS_OF_NAS\Database /u:USER PASSWORD

mkdir \\IP_ADDRESS_OF_NAS\Database\%mydate%

set source="\\DATABASE_SERVER\DESTINATION_TO_BACKUPS"
set dest="\\IP_ADDRESS_OF_NAS\Database\%mydate%"
set logfile="\\IP_ADDRESS_OF_NAS\Database\%mydate%\log.txt"

robocopy %source%  %dest% /s /copy:DT /mt:32 /np /tee /r:10 /fft /xj /eta /XA:SH /log:%logfile% /zb

net use /persistent:no
net use \\IP_ADDRESS_OF_NAS\Database /d /y
