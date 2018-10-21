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

echo -e ${YELLOW}"Welcome to the H2O Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a H2O Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo "Creating 2 H2O system users with no-login access:"
sudo adduser --system --home /home/h2o h2o
sudo adduser --system --home /home/h2o2 h2o2
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
sudo apt install git 
cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 
echo "Getting H2O client";
sudo mkdir /root/h2o
git clone https://github.com/h2ocore/h2o h2o
cd /root/h2o
chmod +x autogen.sh
chmod +x share/genbuild.sh
./autogen.sh
./configure --disable-tests --disable-gui-tests
make
sudo make install
cd /home/h2o/
sudo mkdir /home/h2o/.h2ocore
sudo touch /home/h2o/.h2ocore/h2o.conf 
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/h2o/.h2ocore/h2o.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/h2o/.h2ocore/h2o.conf
echo "rpcallowip=127.0.0.1" >> /home/h2o/.h2ocore/h2o.conf
echo "server=1" >> /home/h2o/.h2ocore/h2o.conf
echo "daemon=1" >> /home/h2o/.h2ocore/h2o.conf
echo "maxconnections=250" >> /home/h2o/.h2ocore/h2o.conf
echo "masternode=1" >> /home/h2o/.h2ocore/h2o.conf
echo "rpcport=13356" >> /home/h2o/.h2ocore/h2o.conf
echo "listen=0" >> /home/h2o/.h2ocore/h2o.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):13355" >> /home/h2o/.h2ocore/h2o.conf
echo "masternodeprivkey=$privkey" >> /home/h2o/.h2ocore/h2o.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
cd /home/h2o2/
sudo mkdir /home/h2o2/.h2ocore
sudo touch /home/h2o2/.h2ocore/h2o.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/h2o2/.h2ocore/h2o.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/h2o2/.h2ocore/h2o.conf
echo "rpcallowip=127.0.0.1" >> /home/h2o2/.h2ocore/h2o.conf
echo "server=1" >> /home/h2o2/.h2ocore/h2o.conf
echo "daemon=1" >> /home/h2o2/.h2ocore/h2o.conf
echo "maxconnections=250" >> /home/h2o2/.h2ocore/h2o.conf
echo "masternode=1" >> /home/h2o2/.h2ocore/h2o.conf
echo "rpcport=13357" >> /home/h2o2/.h2ocore/h2o.conf
echo "listen=0" >> /home/h2o2/.h2ocore/h2o.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):13355" >> /home/h2o2/.h2ocore/h2o.conf
echo "masternodeprivkey=$privkey2" >> /home/h2o2/.h2ocore/h2o.conf
sleep 5 
fi
echo -e "${RED}Stopping Client${NC}"
sudo h2o-cli stop
echo "Syncing first node, please wait...";
h2od -datadir=/home/h2o/.h2ocore -daemon
sleep 10 
until h2o-cli -datadir=/home/h2o/.h2ocore mnsync status | grep -m 1 '"IsBlockchainSynced" : true'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. You 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
h2od -datadir=/home/h2o2/.h2ocore -daemon
sleep 10 
until h2o-cli -datadir=//home/h2o2/.h2ocore mnsync status | grep -m 1 '"IsBlockchainSynced" : true'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. You 1st masternode is running!"${NC}
echo""
echo -e ${GREEN}"Congrats! Your Masternodes are now installed and has started. Please wait 10-15 minutes in order to give the masternode enough time to sync, then start the node from your Windows wallet."${NC}
cd ~