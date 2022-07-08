#!/bin/bash
loginString=(loginString_)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
if [ "${#loginString[@]}" -gt 3 ]; then
    az login --service-principal --username ${loginString[0]} --password ${loginString[1]} --tenant ${loginString[2]};
elif [ "${#loginString[@]}" -gt 1 ]; then
    az login -u ${loginString[0]} -p ${loginString[1]};
fi
while [ 1 ]
do
    az vm start --ids $(az vm list -g vps_group --query "[].id" -o tsv) --no-wait
    sleep 60
done
