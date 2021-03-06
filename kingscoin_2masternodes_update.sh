#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to the Kingscoin Automated Update(2in1)."${NC}
echo "Please wait while updates are performed..."
sleep 5
echo "Stopping first node, please wait...";
kingscoin-cli -datadir=/home/kingscoin/.kingscoin stop
echo "Stopping second node, please wait...";
kingscoin-cli -datadir=/home/kingscoin2/.kingscoin stop
sleep 10
echo "Removing binaries..."
cd /usr/local/bin
rm -rf kingscoind kingscoin-cli kingscoin-tx
cd /root
echo "Downloading latest binaries"
wget https://github.com/kingscrypto/KGS/releases/download/v3.1.1/kgs-3.1.1.1-Ubuntu16.tar.gz
tar -xzf kgs-3.1.1.1-Ubuntu16.tar.gz
cd kgs-3.1.1.1-Ubuntu16
sudo mv kgsd kgs-qt kgs-cli kgs-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/kgs*

echo "Deleting old nodes from node config files..."
sed -i '/addnode/d' /home/kingscoin/.kingscoin/kingscoin.conf
sed -i '/addnode/d' /home/kingscoin2/.kingscoin/kingscoin.conf

echo "Changing old ports with new ones..."
sed -i '/externalip/d' /home/kingscoin/.kingscoin/kingscoin.conf
sed -i '/externalip/d' /home/kingscoin2/.kingscoin/kingscoin.conf
sed -i '/rpcport/d' /home/kingscoin/.kingscoin/kingscoin.conf
sed -i '/rpcport/d' /home/kingscoin2/.kingscoin/kingscoin.conf

echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "rpcport=17701" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "rpcport=17702" >> /home/kingscoin2/.kingscoin/kingscoin.conf


echo "Syncing first node, please wait...";
kgsd -datadir=/home/kingscoin/.kingscoin -resync
until kgs-cli -datadir=/home/kingscoin/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
kgsd -datadir=/home/kingscoin2/.kingscoin -resync
until kgs-cli -datadir=/home/kingscoin2/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Deleting temporary files"
cd /root
rm -rf /root/kgs-3.1.1.1-Ubuntu16
rm -rf /root/kgs-3.1.1.1-Ubuntu16.tar.gz
rm -rf /root/kingscoin_2masternodes_update.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "KingsCoins address: K8cKv7AdK8Z8TVvADKKSTT8MvwmbnGxR3j"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
