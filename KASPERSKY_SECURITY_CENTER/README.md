# KASPERSKY SECURITY CENTER SCRIPTS
This folder contains scripts that automates upgrade of KASPERSKY ENDPOINT SECURITY (KES) from
    version 10 to version 11 to computers across an active directory.

The upgrade requires the following FOR EACH computer:
    1. Removal of the old KES and KES Network Agent (version 10)
    1. Installaton of the new KES and KES Network Agent (version 11)

Each of the folders contain two scripts:
    1. A batch script (.bat) file which removes (or installs) KES and KES Network Agent on a single computer
      SILENTLY via a shared folder containing the necessary installation files of KES and its Network Agent.
    1. A Powershell script (.ps1) file which:
        1. Fetches Computers from the active directory
        1. For every Computer, it uses the Batch script to remove (or install) KES and KES Network Agent.
        1. It runs the Batch script on every computer remotely with the help of the PSEXEC tool.

NOTE:
    1. This indeed can be done with Kaspersky Security Center (version 11) automatically via tasks.
     However, I found this approach more convenient since KSC fails sometime to do the upgrade.
    1. The scripts should be run from the domain controller since they fetch computers that are joined.
