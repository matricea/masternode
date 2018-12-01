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

echo -e ${YELLOW}"Welcome to the Christmas coin Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install Christmas coin Masternode? type y/n followed by [ENTER]:"${NC}
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
echo "Creating 4 Christmas coin system users with no-login access:"
sudo adduser --system --home /home/chmc chmc
sudo adduser --system --home /home/chmc2 chmc2
sudo adduser --system --home /home/chmc3 chmc3
sudo adduser --system --home /home/chmc4 chmc4
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
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
sudo mkdir /root/chmc
cd /root/chmc
wget https://github.com/Christmas-Coin/ChristmasCoin-Core/releases/download/2.1.0/christmascoin-2.1.0-i686-pc-linux.zip
sudo unzip christmascoin-2.1.0-i686-pc-linux.zip
sudo mv /root/chmc/christmascoind /root/chmc/christmascoin-tx /root/chmc/christmascoin-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/christmascoin*
sudo mkdir /home/chmc/.chmc
sudo touch /home/chmc/.chmc/christmascoin.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/chmc/.chmc/christmascoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/chmc/.chmc/christmascoin.conf
echo "rpcallowip=127.0.0.1" >> /home/chmc/.chmc/christmascoin.conf
echo "server=1" >> /home/chmc/.chmc/christmascoin.conf
echo "daemon=1" >> /home/chmc/.chmc/christmascoin.conf
echo "maxconnections=250" >> /home/chmc/.chmc/christmascoin.conf
echo "masternode=1" >> /home/chmc/.chmc/christmascoin.conf
echo "rpcport=23799" >> /home/chmc/.chmc/christmascoin.conf
echo "listen=0" >> /home/chmc/.chmc/christmascoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):23798" >> /home/chmc/.chmc/christmascoin.conf
echo "masternodeprivkey=$privkey" >> /home/chmc/.chmc/christmascoin.conf
echo "addnode=91.223.147.171" >> /home/chmc/.chmc/christmascoin.conf
echo "addnode=80.211.240.4" >> /home/chmc/.chmc/christmascoin.conf
echo "addnode=195.181.223.240" >> /home/chmc/.chmc/christmascoin.conf
echo "addnode=80.211.46.133" >> /home/chmc/.chmc/christmascoin.conf
echo "addnode=45.32.135.15" >> /home/chmc/.chmc/christmascoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/chmc2/.chmc/
sudo touch /home/chmc2/.chmc/christmascoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/chmc2/.chmc/christmascoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/chmc2/.chmc/christmascoin.conf
echo "rpcallowip=127.0.0.1" >> /home/chmc2/.chmc/christmascoin.conf
echo "server=1" >> /home/chmc2/.chmc/christmascoin.conf
echo "daemon=1" >> /home/chmc2/.chmc/christmascoin.conf
echo "maxconnections=250" >> /home/chmc2/.chmc/christmascoin.conf
echo "masternode=1" >> /home/chmc2/.chmc/christmascoin.conf
echo "rpcport=23800" >> /home/chmc2/.chmc/christmascoin.conf
echo "listen=0" >> /home/chmc2/.chmc/christmascoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):23798" >> /home/chmc2/.chmc/christmascoin.conf
echo "masternodeprivkey=$privkey2" >> /home/chmc2/.chmc/christmascoin.conf
echo "addnode=91.223.147.171" >> /home/chmc2/.chmc/christmascoin.conf
echo "addnode=80.211.240.4" >> /home/chmc2/.chmc/christmascoin.conf
echo "addnode=195.181.223.240" >> /home/chmc2/.chmc/christmascoin.conf
echo "addnode=80.211.46.133" >> /home/chmc2/.chmc/christmascoin.conf
echo "addnode=45.32.135.15" >> /home/chmc2/.chmc/christmascoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for third node${NC}"
sudo mkdir /home/chmc3/.chmc/
sudo touch /home/chmc3/.chmc/christmascoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/chmc3/.chmc/christmascoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/chmc3/.chmc/christmascoin.conf
echo "rpcallowip=127.0.0.1" >> /home/chmc3/.chmc/christmascoin.conf
echo "server=1" >> /home/chmc3/.chmc/christmascoin.conf
echo "daemon=1" >> /home/chmc3/.chmc/christmascoin.conf
echo "maxconnections=250" >> /home/chmc3/.chmc/christmascoin.conf
echo "masternode=1" >> /home/chmc3/.chmc/christmascoin.conf
echo "rpcport=23801" >> /home/chmc3/.chmc/christmascoin.conf
echo "listen=0" >> /home/chmc3/.chmc/christmascoin.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:23798" >> /home/chmc3/.chmc/christmascoin.conf
echo "masternodeprivkey=$privkey3" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=91.223.147.171" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=80.211.240.4" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=195.181.223.240" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=80.211.46.133" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=45.32.135.15" >> /home/chmc3/.chmc/christmascoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for 4th node${NC}"
sudo mkdir /home/chmc4/.chmc/
sudo touch /home/chmc4/.chmc/christmascoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/chmc4/.chmc/christmascoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/chmc4/.chmc/christmascoin.conf
echo "rpcallowip=127.0.0.1" >> /home/chmc4/.chmc/christmascoin.conf
echo "server=1" >> /home/chmc4/.chmc/christmascoin.conf
echo "daemon=1" >> /home/chmc4/.chmc/christmascoin.conf
echo "maxconnections=250" >> /home/chmc4/.chmc/christmascoin.conf
echo "masternode=1" >> /home/chmc4/.chmc/christmascoin.conf
echo "rpcport=23802" >> /home/chmc4/.chmc/christmascoin.conf
echo "listen=0" >> /home/chmc4/.chmc/christmascoin.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:23798" >> /home/chmc4/.chmc/christmascoin.conf
echo "masternodeprivkey=$privkey4" >> /home/chmc4/.chmc/christmascoin.conf
echo "addnode=91.223.147.171" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=80.211.240.4" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=195.181.223.240" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=80.211.46.133" >> /home/chmc3/.chmc/christmascoin.conf
echo "addnode=45.32.135.15" >> /home/chmc3/.chmc/christmascoin.conf
sleep 5
fi
echo "Syncing first node, please wait...";
christmascoind -datadir=/home/chmc/.chmc/ -daemon
sleep 10
until christmascoin-cli -datadir=/home/chmc/.chmc/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. You 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
christmascoind -datadir=/home/chmc2/.chmc/ -daemon
sleep 10
until christmascoin-cli -datadir=/home/chmc2/.chmc/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. You second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
christmascoind -datadir=/home/chmc3/.chmc/ -daemon
sleep 10
until christmascoin-cli -datadir=/home/chmc3/.chmc/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. You third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
christmascoind -datadir=/home/chmc4/.chmc/ -daemon
sleep 10
until christmascoin-cli -datadir=/home/chmc4/.chmc/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. You fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your Christmas coin Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this tutorial helped in some way, feel free to donate for our work:"
echo "Christmas coin address: "
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
