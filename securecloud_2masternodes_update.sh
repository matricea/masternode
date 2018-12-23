#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to the SecureCloud Automated Update."${NC}
echo "Please wait while updates are performed..."
sleep 10
cd ~
cd /usr/local/bin
echo "Stopping first node, please wait...";
securecloud-cli -datadir=/home/securecloud/.securecloud stop
echo "Stopping second node, please wait...";
securecloud-cli -datadir=/home/securecloud2/.securecloud stop
echo "Stopping third node, please wait...";
sleep 10
echo "Removing binaries..."
rm -rf securecloudd securecloud-cli securecloud-tx
echo "Downloading latest binaries"
wget https://github.com/securecloudnet/SecureCloud/releases/download/2.1.0/securecloud-2.1.0-x86_64-linux-gnu.tar.gz
tar -xzf securecloud-2.1.0-x86_64-linux-gnu.tar.gz
echo "Syncing first node, please wait...";
securecloudd -datadir=/home/securecloud/.securecloud -daemon
until securecloud-cli -datadir=/home/securecloud/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
securecloudd -datadir=/home/securecloud2/.securecloud -daemon
until securecloud-cli -datadir=/home/securecloud2/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
rm -rf securecloud-2.1.0-x86_64-linux-gnu.tar.gz
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo -e ${GREEN}"SecureCloudNet address: sUhHTix3QzMLFKKGiQ5U7s9MLJNopr3M6B"${NC}
echo -e ${GREEN}"LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"${NC}
echo -e ${GREEN}"The END. You can close now the SSH terminal session"${NC};
