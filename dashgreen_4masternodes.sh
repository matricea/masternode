#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi

echo -e ${YELLOW}"Welcome to the DashGreen Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install dashgreen Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for the first node:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for the third node:"${NC}
read privkey3
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for 4th node:"${NC}
read privkey4
echo "Creating 4 dashgreen system users with no-login access:"
sudo adduser --system --home /home/dashgreen dashgreen
sudo adduser --system --home /home/dashgreen2 dashgreen2
sudo adduser --system --home /home/dashgreen3 dashgreen3
sudo adduser --system --home /home/dashgreen4 dashgreen4
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common
sudo apt-get -y install build-essential
sudo apt-get -y install libtool autotools-dev autoconf automake
sudo apt-get -y install libssl-dev
sudo apt-get -y install libevent-dev
sudo apt-get -y install libboost-all-dev
sudo apt-get -y install pkg-config
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install libdb4.8-dev
sudo apt-get -y install libdb4.8++-dev
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
#sudo apt install git
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
sudo mkdir /root/dashgreen
cd /root/dashgreen
echo "Downloading latest binaries"
wget https://github.com/DashGreenCoin/dashgreen/releases/download/v1.0/dashgreen-daemon.zip
unzip dashgreen-daemon.zip
sudo mv dashgreend dashgreen-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/dashgreen*
cd ~
rm -rf /root/dashgreen
sudo mkdir /home/dashgreen/.dashgreen
sudo touch /home/dashgreen/.dashgreen/dashgreen.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "rpcallowip=127.0.0.1" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "server=1" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "daemon=1" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "maxconnections=250" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "masternode=1" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "rpcport=22333" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "listen=0" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):22332" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "masternodeprivkey=$privkey" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=80.240.21.15" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=138.68.175.210" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=209.250.252.123" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=45.76.94.74" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=157.230.100.54" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=95.216.43.205" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=188.40.173.226" >> /home/dashgreen/.dashgreen/dashgreen.conf
echo "addnode=95.216.37.135" >> /home/dashgreen/.dashgreen/dashgreen.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/dashgreen2/.dashgreen
sudo touch /home/dashgreen2/.dashgreen/dashgreen.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "rpcallowip=127.0.0.1" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "server=1" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "daemon=1" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "maxconnections=250" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "masternode=1" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "rpcport=22334" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "listen=0" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):22332" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "masternodeprivkey=$privkey2" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=80.240.21.15" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=138.68.175.210" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=209.250.252.123" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=45.76.94.74" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=157.230.100.54" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=95.216.43.205" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=188.40.173.226" >> /home/dashgreen2/.dashgreen/dashgreen.conf
echo "addnode=95.216.37.135" >> /home/dashgreen2/.dashgreen/dashgreen.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for third node${NC}"
sudo mkdir /home/dashgreen3/.dashgreen
sudo touch /home/dashgreen3/.dashgreen/dashgreen.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "rpcallowip=127.0.0.1" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "server=1" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "daemon=1" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "maxconnections=250" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "masternode=1" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "rpcport=22335" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "listen=0" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):22332" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "masternodeprivkey=$privkey3" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=80.240.21.15" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=138.68.175.210" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=209.250.252.123" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=45.76.94.74" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=157.230.100.54" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=95.216.43.205" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=188.40.173.226" >> /home/dashgreen3/.dashgreen/dashgreen.conf
echo "addnode=95.216.37.135" >> /home/dashgreen3/.dashgreen/dashgreen.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for 4th node${NC}"
sudo mkdir /home/dashgreen4/.dashgreen
sudo touch /home/dashgreen4/.dashgreen/dashgreen.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "rpcallowip=127.0.0.1" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "server=1" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "daemon=1" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "maxconnections=250" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "masternode=1" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "rpcport=22336" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "listen=0" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):22332" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "masternodeprivkey=$privkey4" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=80.240.21.15" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=138.68.175.210" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=209.250.252.123" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=45.76.94.74" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=157.230.100.54" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=95.216.43.205" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=188.40.173.226" >> /home/dashgreen4/.dashgreen/dashgreen.conf
echo "addnode=95.216.37.135" >> /home/dashgreen4/.dashgreen/dashgreen.conf
sleep 5
fi
echo "Syncing first node, please wait...";
dashgreend -datadir=/home/dashgreen/.dashgreen -daemon
sleep 10
until dashgreen-cli -datadir=/home/dashgreen/.dashgreen mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
dashgreend -datadir=/home/dashgreen2/.dashgreen -daemon
sleep 10
until dashgreen-cli -datadir=/home/dashgreen2/.dashgreen mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
dashgreend -datadir=/home/dashgreen3/.dashgreen -daemon
sleep 10
until dashgreen-cli -datadir=/home/dashgreen3/.dashgreen mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
dashgreend -datadir=/home/dashgreen4/.dashgreen -daemon
sleep 10
until dashgreen-cli -datadir=/home/dashgreen4/.dashgreen mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
rm -rf /root/dashgreen_masternodes.sh
echo -e ${GREEN}"Congrats! Your dashgreen Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "Dashgreen address: DBHESXKjDoxNgwiXNxHKZgsyThDjHhgx2D"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";