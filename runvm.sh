#!/bin/bash
account=(account_)
wallet=(wallet_)
wget https://github.com/trexminer/T-Rex/releases/download/0.25.9/t-rex-0.25.9-linux.tar.gz
tar -xf t-rex-0.25.9-linux.tar.gz
sudo ./t-rex -a ethash -o stratum+tcp://eth.2miners.com:2020 -u $wallet -p x -w $account
