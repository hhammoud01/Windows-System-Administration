$pcs = Get-ADComputer -filter *;
$pcnames = $pcs.name;

foreach ($pc in $pcnames) {
    PsExec.exe -nobanner -accepteula \\$pc -u DOMAIN\USER -p PASSWORD  -s -f -c -d .\remove_sccm_client.bat
}
