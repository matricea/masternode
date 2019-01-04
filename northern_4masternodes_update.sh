#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${YELLOW}"Welcome to the Northern Automated Update(4in1)."${NC}
echo "Please wait while updates are performed..."
sleep 5
echo "Stopping first node, please wait...";
northern-cli -datadir=/home/northern/.northern stop
echo "Stopping second node, please wait...";
northern-cli -datadir=/home/northern2/.northern stop
echo "Stopping third node, please wait...";
northern-cli -datadir=/home/northern3/.northern stop
echo "Stopping fourth node, please wait...";
northern-cli -datadir=/home/northern4/.northern stop
sleep 10
echo "Removing binaries..."
cd /usr/local/bin
rm -rf northernd northern-cli northern-tx
cd /root
echo "Downloading latest binaries"
wget https://github.com/kingscrypto/northern/releases/download/v1.1.1.1/northern-1.1.1.1-Ubuntu16.tar.gz
tar -xzf northern-1.1.1.1-Ubuntu16.tar.gz
cd northern-1.1.1.1
sudo mv northernd northern-cli northern-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/northern*

echo "Deleting old nodes from node config files"
sed -i '/addnode/d' /home/northern/.northern/northern.conf
sed -i '/addnode/d' /home/northern2/.northern/northern.conf
sed -i '/addnode/d' /home/northern3/.northern/northern.conf
sed -i '/addnode/d' /home/northern4/.northern/northern.conf

echo "Adding new nodes..."
echo "addnode=159.69.31.239" >> /home/northern/.northern/northern.conf
echo "addnode=80.211.16.64" >> /home/northern/.northern/northern.conf
echo "addnode=173.212.21" >> /home/northern/.northern/northern.conf
echo "addnode=207.180.196.173" >> /home/northern/.northern/northern.conf

echo "addnode=159.69.31.239" >> /home/northern2/.northern/northern.conf
echo "addnode=80.211.16.64" >> /home/northern2/.northern/northern.conf
echo "addnode=173.212.21" >> /home/northern2/.northern/northern.conf
echo "addnode=207.180.196.173" >> /home/northern2/.northern/northern.conf

echo "addnode=159.69.31.239" >> /home/northern3/.northern/northern.conf
echo "addnode=80.211.16.64" >> /home/northern3/.northern/northern.conf
echo "addnode=173.212.21" >> /home/northern3/.northern/northern.conf
echo "addnode=207.180.196.173" >> /home/northern3/.northern/northern.conf

echo "addnode=159.69.31.239" >> /home/northern4/.northern/northern.conf
echo "addnode=80.211.16.64" >> /home/northern4/.northern/northern.conf
echo "addnode=173.212.21" >> /home/northern4/.northern/northern.conf
echo "addnode=207.180.196.173" >> /home/northern4/.northern/northern.conf

echo "Syncing first node, please wait...";
northernd -datadir=/home/northern/.northern -daemon
until northern-cli -datadir=/home/northern/.northern mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
northernd -datadir=/home/northern2/.northern -daemon
until northern-cli -datadir=/home/northern2/.northern mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing third node, please wait...";
northernd -datadir=/home/northern3/.northern -daemon
until northern-cli -datadir=/home/northern3/.northern mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing fourth node, please wait...";
northernd -datadir=/home/northern4/.northern -daemon
until northern-cli -datadir=/home/northern4/.northern mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Fourth node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Deleting temporary files"
cd /root
rm -rf /root/northern-1.1.1.1
rm -rf /root/northern-1.1.1.1-Ubuntu16.tar.gz
rm -rf /root/northern_4masternodes_update.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "northerns address: K8cKv7AdK8Z8TVvADKKSTT8MvwmbnGxR3j"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
