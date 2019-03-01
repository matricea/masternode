#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to the Kingscoin Automated Update(4in1)."${NC}
echo "Please wait while updates are performed..."
sleep 5
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
cd /usr/local/bin
rm -rf kingscoind kingscoin-cli kingscoin-tx
cd /root
echo "Downloading latest binaries"
wget https://github.com/kingscrypto/KINGSCOIN/releases/download/v1.1.1.2/kingscoin-1.1.1.2-Ubuntu16.tar.gz
tar -xzf kingscoin-1.1.1.2-Ubuntu16.tar.gz
cd kingscoin-1.1.1.2-Ubuntu16
sudo mv kingscoind kingscoin-cli kingscoin-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/kingscoin*

echo "Deleting old nodes from masternodes ip's from the config files"
sed -i '/addnode/d' /home/kingscoin/.kingscoin/kingscoin.conf
sed -i '/addnode/d' /home/kingscoin2/.kingscoin/kingscoin.conf
sed -i '/addnode/d' /home/kingscoin3/.kingscoin/kingscoin.conf
sed -i '/addnode/d' /home/kingscoin4/.kingscoin/kingscoin.conf

echo "Adding new nodes..."
echo "connect=159.69.178.130" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "connect=95.216.174.44" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "connect=159.69.31.239" >> /home/kingscoin/.kingscoin/kingscoin.conf

echo "connect=159.69.178.130" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "connect=95.216.174.44" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "connect=159.69.31.239" >> /home/kingscoin2/.kingscoin/kingscoin.conf

echo "connect=159.69.178.130" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "connect=95.216.174.44" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "connect=159.69.31.239" >> /home/kingscoin3/.kingscoin/kingscoin.conf

echo "connect=159.69.178.130" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "connect=95.216.174.44" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "connect=159.69.31.239" >> /home/kingscoin4/.kingscoin/kingscoin.conf

echo "Syncing first node, please wait...";
kingscoind -datadir=/home/kingscoin/.kingscoin -resync
until kingscoin-cli -datadir=/home/kingscoin/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
sleep 5
echo "Syncing second node, please wait...";
kingscoind -datadir=/home/kingscoin2/.kingscoin -resync
until kingscoin-cli -datadir=/home/kingscoin2/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
sleep 5
echo "Syncing third node, please wait...";
kingscoind -datadir=/home/kingscoin3/.kingscoin -resync
until kingscoin-cli -datadir=/home/kingscoin3/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
sleep 5
echo "Syncing fourth node, please wait...";
kingscoind -datadir=/home/kingscoin4/.kingscoin -resync
until kingscoin-cli -datadir=/home/kingscoin4/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
sleep 5
echo "Stopping first node, please wait...";
kingscoin-cli -datadir=/home/kingscoin/.kingscoin stop
echo "Stopping second node, please wait...";
kingscoin-cli -datadir=/home/kingscoin2/.kingscoin stop
echo "Stopping third node, please wait...";
kingscoin-cli -datadir=/home/kingscoin3/.kingscoin stop
echo "Stopping fourth node, please wait...";
kingscoin-cli -datadir=/home/kingscoin4/.kingscoin stop
sleep 5
echo "Deleting old nodes from nodes ip's from the config files"
sed -i '/connect/d' /home/kingscoin/.kingscoin/kingscoin.conf
sed -i '/connect/d' /home/kingscoin2/.kingscoin/kingscoin.conf
sed -i '/connect/d' /home/kingscoin3/.kingscoin/kingscoin.conf
sed -i '/connect/d' /home/kingscoin4/.kingscoin/kingscoin.conf
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
echo "Deleting temporary files"
cd /root
rm -rf /root/kingscoin-1.1.1.2-Ubuntu16
rm -rf /root/kingscoin-1.1.1.2-Ubuntu16.tar.gz
rm -rf /root/kingscoin_4masternodes_update.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "KingsCoins address: K8cKv7AdK8Z8TVvADKKSTT8MvwmbnGxR3j"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
