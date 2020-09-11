# NETWORK OPTIMIZATION
This folder contains several network optimization tricks that reduced the overhead in the network that might slow it down, especially when scaled up to a thousand PC in a single domain:
* Disable Net Bios, the legacy Windows protocol for name services: For no reason wireshark kept on capturing NTBT packets from Computers. Although it is currently unused by Windows.
* Disable IPv6: It prevented IPv6 broadcasts which also caused some trouble.
* Disable Auto Proxy: For the same reasons that it is not needed and introduces some overhead.

The scripts are Powershell scripts, to be executed on the entire Active Directory forest using PSEXEC, or alternatively create a group policy object which will execute them at the startup of systems.
