#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

echo -e ${RED}"Welcome to the Zoomba Automated Update(2in1)."${NC}
echo "Please wait while updates are performed..."
sleep 2
echo "Stopping first node, please wait...";
zoomba-cli stop
sleep 10
echo "Removing binaries..."
cd /usr/local/bin
rm -rf zoomba*
cd /root
echo "Downloading latest binaries"
wget https://github.com/zoombacoin/zoomba/releases/download/1.0.2/zoomba-1.0.2-ubuntu1604.zip
unzip zoomba-1.0.2-ubuntu1604.zip
sudo mv zoombad zoomba-cli zoomba-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/zoomba*

echo "Adding new nodes into the Zoomba config file"
echo "addnode=173.249.22.124" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=66.42.111.56" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=173.249.22.207" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=207.246.68.245" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=80.241.216.101" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=54.39.25.93" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=104.156.230.104" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=173.199.70.184" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /root/zoomba/.zoomba/zoomba.conf

echo "Syncing first node, please wait...";
zoombad -daemon
until zoomba-cli mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"The node is fully synced. Your masternode is running!"${NC}
sleep 5
sleep 5
echo "Deleting temporary files"
cd /root
rm -rf /root/zoomba-1.0.2-ubuntu1604.zip
rm -rf /root/zoomba_masternode_update.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "Zoomba address: ZfkuV8WefFSiL1urBGamqsZ9h5osWJaoKX"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
