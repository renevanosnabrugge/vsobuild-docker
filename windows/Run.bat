@echo off
SET url=%vso_url%
SET password=%vso_password%
SET username=%vso_username%
SET pool=%vso_agentpool%
SET agent=%vso_agentname%

echo URL [%url%]
echo Username [%username%]
echo Pool [%pool%]
echo Agent [%agent%]


.\agent\VsoAgent.exe /configure /serverUrl:%url% /name:%agent% /Poolname:%pool% /Login:%username%,%password%;AuthType=Basic /force /workfolder:"c:\agent\_work" /runningasservice:N /noprompt /force
