# SCCM Agent Hell
This folder contains a script that proved useful in an old Active Directory where SCCM 2008 was installed and removed incorrectly, which made all the computers send a number of requests per seconds asking about their SCCM server.
The huge amount of computers (~ 1000) cause a major network slowdown which was solved by this script.
The folder contains two scripts:
* A Batch script which removes SCCM agent on one computer
* A Powershell script which:
    1. Fetches all computers from active directory
    2. Uses psexec to run the Batch script remotely on every computer
