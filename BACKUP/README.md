# BACKUP SCRIPTS
This folder contains multiple backup scripts which backup shared folders and database files to a Network Attached Storage (NAS).
The scripts use the utility "Robocopy" and can be automated using Windows' Task Scheduler tool.

Some Remarks:
* For SHARED FOLDERS, It does an incremental backup:
    * Keeping any files that were deleted from the source
    * Modifying any files that were modified
    * Creating any new files that were created

* For DATABASE FILES, it does a full backup:
    * First, it creates a folder whose name is the date of the execution of the script.
    * Then it copies database files (.bak files) from the specified source to the destination.
    * NOTE: Folders have their names in the format: DD-MM-YYYY

* The script called "preserve.bat" does the space saving automatically:
    * It assumes that the Databases backup is run on a daily basis using a task scheduler.
    * To save space, the script can be run on the FIRST of every month. It does the following:
        * If the date of the execution is the FIRST day of the month, it deletes all the folders containing full backups of databases that happened on the PREVIOUS month, except for days [1, 8, 15, 22, 28] of the previous month.
        * In other words, it keeps 5 backups of the previous month.
