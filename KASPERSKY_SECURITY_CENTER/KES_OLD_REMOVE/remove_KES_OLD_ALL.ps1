﻿# THIS SCRIPT REMOVES AN OLD VERSION (10) OF KASPERSKY SECURITY CENTER
# AND KASPERSKY NETWORK AGENT FROM COMPUTERS IN AN ACTIVE DIRECTORY
# IT USES PSEXEC TOOLS TO EXECUTE COMMANDS REMOTELY AND THE TOOL "REMOVE_KES_OLD.bat" TO EXECUTE
# ON EACH PC.

$pcs = Get-ADComputer -filter *;
$pcnames = $pcs.name;

foreach ($pc in $pcnames) {
    PsExec.exe -nobanner -accepteula \\$pc -u DOMAIN\ADMIN_USER -p ADMIN_PASSWORD  -s -f -c -d remove_KES_OLD.bat
}
