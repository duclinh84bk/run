#!/bin/bash
loginString=(loginString_)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login --service-principal --username ${loginString[0]} --password ${loginString[1]} --tenant ${loginString[2]};
while [ 1 ]
do
    az vm start --ids $(az vm list -g vps_group --query "[].id" -o tsv) --no-wait
    sleep 60
done
