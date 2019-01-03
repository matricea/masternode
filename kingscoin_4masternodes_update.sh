#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to the Kingscoin Automated Update."${NC}
echo "Please wait while updates are performed..."
sleep 5
cd ~
cd /usr/local/bin
echo "Stopping first node, please wait...";
kingscoin-cli -datadir=/home/kingscoin/.kingscoin stop
echo "Stopping second node, please wait...";
kingscoin-cli -datadir=/home/kingscoin2/.kingscoin stop
echo "Stopping third node, please wait...";
kingscoin-cli -datadir=/home/kingscoin3/.kingscoin stop
echo "Stopping fourth node, please wait...";
kingscoin-cli -datadir=/home/kingscoin4/.kingscoin stop
sleep 10
echo "Removing binaries..."
rm -rf kingscoind kingscoin-cli kingscoin-tx
cd /root
echo "Downloading latest binaries"
wget https://github.com/kingscrypto/KINGSCOIN/releases/download/v1.1.1.1/kingscoin-1.1.1.1-Ubuntu16.tar.gz
tar -xzf kingscoin-1.1.1.1-Ubuntu16.tar.gz
cd kingscoin-1.1.1.1
sudo mv kingscoind kingscoin-cli kingscoin-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/kingscoin*
echo "Syncing first node, please wait...";
kingscoind -datadir=/home/kingscoin/.kingscoin -daemon
until kingscoin-cli -datadir=/home/kingscoin/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
kingscoind -datadir=/home/kingscoin2/.kingscoin -daemon
until kingscoin-cli -datadir=/home/kingscoin2/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing third node, please wait...";
kingscoind -datadir=/home/kingscoin3/.kingscoin -daemon
until kingscoin-cli -datadir=/home/kingscoin3/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing fourth node, please wait...";
kingscoind -datadir=/home/kingscoin4/.kingscoin -daemon
until kingscoin-cli -datadir=/home/kingscoin4/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Fourth node is fully synced. Your masternode is running!"${NC}
sleep 5
rm -rf /root/kingscoin-1.1.1.1
rm -rf /root/kingscoin-1.1.1.1-Ubuntu16.tar.gz
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "KingsCoins address: K8cKv7AdK8Z8TVvADKKSTT8MvwmbnGxR3j"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
