# FAST CONNECTIVITY CHECKER
This batch script tests connectivity to multiple sites, each having its own name, type of the connection (for logging purposes) and an IP address.

The script reads the file "sites.txt" which contains the above information
and tests connectivity to every site one by one.
The output is logged to a file "PingResults.txt".

INPUT FORMAT: NAME  - TYPE OF LINKE: IPADDRESS
EXAMPLE INPUT:<br />
SITE1   - DSL: 10.0.0.1<br />
SITE1   - FIBRE: 10.0.0.2<br />
....
