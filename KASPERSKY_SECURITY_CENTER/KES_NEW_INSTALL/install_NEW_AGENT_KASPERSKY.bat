REM INSTALLS NETWORK AGENT AND KASPERSKY ENDPOINT SECURITY
REM ON A MACHINE FROM A REMOTE INSTALLATION SHARED FOLDER

REM PUSH NETWORK LOCATION OF KASPERSKY
net use \\"SHARED_FOLDER" /user:"DOMAIN\ADMIN" PASSWORD
pushd \\"SHARED_FOLDER"\Kaspersky

REM INSTALL NEW KASPERSKY NETWORK AGENT
msiexec.exe /i "agent_11\exec\Kaspersky Network Agent.msi" /qn SERVERADDRESS="SERVER_ADDRESS" DONT_USE_ANSWER_FILE=1 PRIVACYPOLICY=1 EULA=1

REM INSTALL NEW KASPERSKY ENDPOINT SECURITY
KES_11\setup.exe setup.exe /pEULA=1 /pPRIVACYPOLICY=1 /pKSN=0 /s

REM POP THE PUSHED DIRECTORY
popd

REM REMOVE CONNECTION
net use \\"SHARED_FOLDER" /d
