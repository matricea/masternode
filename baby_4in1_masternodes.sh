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

echo -e ${YELLOW}"Welcome to the Baby Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install Baby Masternode? type y/n followed by [ENTER]:"${NC}
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
echo "Creating 4 Baby system users with no-login access:"
sudo adduser --system --home /home/baby baby
sudo adduser --system --home /home/baby2 baby2
sudo adduser --system --home /home/baby3 baby3
sudo adduser --system --home /home/baby4 baby4
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
#sudo apt-get -y install libdb4.8++-dev
sudo apt-get -y install libdb++-dev
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
sudo mkdir /root/baby
cd /root/baby
wget https://github.com/babychain/BABY/releases/download/3.0.99/BABYCHAIN-Linuxdaemon-64bit.zip
sudo unzip BABYCHAIN-Linuxdaemon-64bit.zip
cd BABYCHAIN-Linuxdaemon-64bit
sudo mv babyd baby-cli baby-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/baby*
sudo mkdir /home/baby/.baby
sudo touch /home/baby/.baby/baby.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/baby/.baby/baby.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/baby/.baby/baby.conf
echo "rpcallowip=127.0.0.1" >> /home/baby/.baby/baby.conf
echo "server=1" >> /home/baby/.baby/baby.conf
echo "daemon=1" >> /home/baby/.baby/baby.conf
echo "maxconnections=250" >> /home/baby/.baby/baby.conf
echo "masternode=1" >> /home/baby/.baby/baby.conf
echo "rpcport=55443" >> /home/baby/.baby/baby.conf
echo "listen=0" >> /home/baby/.baby/baby.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):55442" >> /home/baby/.baby/baby.conf
echo "masternodeprivkey=$privkey" >> /home/baby/.baby/baby.conf
echo "addnode=38.103.14.250" >> /home/baby/.baby/baby.conf
echo "addnode=95.168.199.10" >> /home/baby/.baby/baby.conf
echo "addnode=80.211.150.131" >> /home/baby/.baby/baby.conf
echo "addnode=91.227.50.22" >> /home/baby/.baby/baby.conf
echo "addnode=118.189.177.112" >> /home/baby/.baby/baby.conf
echo "addnode=45.63.18.116" >> /home/baby/.baby/baby.conf
echo "addnode=119.29.145.194" >> /home/baby/.baby/baby.conf
echo "addnode=212.33.250.118" >> /home/baby/.baby/baby.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/baby2/.baby
sudo touch /home/baby2/.baby/baby.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/baby2/.baby/baby.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/baby2/.baby/baby.conf
echo "rpcallowip=127.0.0.1" >> /home/baby2/.baby/baby.conf
echo "server=1" >> /home/baby2/.baby/baby.conf
echo "daemon=1" >> /home/baby2/.baby/baby.conf
echo "maxconnections=250" >> /home/baby2/.baby/baby.conf
echo "masternode=1" >> /home/baby2/.baby/baby.conf
echo "rpcport=55444" >> /home/baby2/.baby/baby.conf
echo "listen=0" >> /home/baby2/.baby/baby.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):55442" >> /home/baby2/.baby/baby.conf
echo "masternodeprivkey=$privkey2" >> /home/baby2/.baby/baby.conf
echo "addnode=38.103.14.250" >> /home/baby2/.baby/baby.conf
echo "addnode=95.168.199.10" >> /home/baby2/.baby/baby.conf
echo "addnode=80.211.150.131" >> /home/baby2/.baby/baby.conf
echo "addnode=91.227.50.22" >> /home/baby2/.baby/baby.conf
echo "addnode=118.189.177.112" >> /home/baby2/.baby/baby.conf
echo "addnode=45.63.18.116" >> /home/baby2/.baby/baby.conf
echo "addnode=119.29.145.194" >> /home/baby2/.baby/baby.conf
echo "addnode=212.33.250.118" >> /home/baby2/.baby/baby.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for third node${NC}"
sudo mkdir /home/baby3/.baby
sudo touch /home/baby3/.baby/baby.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/baby3/.baby/baby.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/baby3/.baby/baby.conf
echo "rpcallowip=127.0.0.1" >> /home/baby3/.baby/baby.conf
echo "server=1" >> /home/baby3/.baby/baby.conf
echo "daemon=1" >> /home/baby3/.baby/baby.conf
echo "maxconnections=250" >> /home/baby3/.baby/baby.conf
echo "masternode=1" >> /home/baby3/.baby/baby.conf
echo "rpcport=55445" >> /home/baby3/.baby/baby.conf
echo "listen=0" >> /home/baby3/.baby/baby.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:55442" >> /home/baby3/.baby/baby.conf
echo "masternodeprivkey=$privkey3" >> /home/baby3/.baby/baby.conf
echo "addnode=38.103.14.250" >> /home/baby3/.baby/baby.conf
echo "addnode=95.168.199.10" >> /home/baby3/.baby/baby.conf
echo "addnode=80.211.150.131" >> /home/baby3/.baby/baby.conf
echo "addnode=91.227.50.22" >> /home/baby3/.baby/baby.conf
echo "addnode=118.189.177.112" >> /home/baby3/.baby/baby.conf
echo "addnode=45.63.18.116" >> /home/baby3/.baby/baby.conf
echo "addnode=119.29.145.194" >> /home/baby3/.baby/baby.conf
echo "addnode=212.33.250.118" >> /home/baby3/.baby/baby.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for 4th node${NC}"
sudo mkdir /home/baby4/.baby
sudo touch /home/baby4/.baby/baby.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/baby4/.baby/baby.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/baby4/.baby/baby.conf
echo "rpcallowip=127.0.0.1" >> /home/baby4/.baby/baby.conf
echo "server=1" >> /home/baby4/.baby/baby.conf
echo "daemon=1" >> /home/baby4/.baby/baby.conf
echo "maxconnections=250" >> /home/baby4/.baby/baby.conf
echo "masternode=1" >> /home/baby4/.baby/baby.conf
echo "rpcport=55446" >> /home/baby4/.baby/baby.conf
echo "listen=0" >> /home/baby4/.baby/baby.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:55442" >> /home/baby4/.baby/baby.conf
echo "masternodeprivkey=$privkey4" >> /home/baby4/.baby/baby.conf
echo "addnode=38.103.14.250" >> /home/baby4/.baby/baby.conf
echo "addnode=95.168.199.10" >> /home/baby4/.baby/baby.conf
echo "addnode=80.211.150.131" >> /home/baby4/.baby/baby.conf
echo "addnode=91.227.50.22" >> /home/baby4/.baby/baby.conf
echo "addnode=118.189.177.112" >> /home/baby4/.baby/baby.conf
echo "addnode=45.63.18.116" >> /home/baby4/.baby/baby.conf
echo "addnode=119.29.145.194" >> /home/baby4/.baby/baby.conf
echo "addnode=212.33.250.118" >> /home/baby4/.baby/baby.conf
sleep 5
fi
echo "Syncing first node, please wait...";
babyd -datadir=/home/baby/.baby -daemon
sleep 10
until baby-cli -datadir=/home/baby/.baby mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
babyd -datadir=/home/baby2/.baby -daemon
sleep 10
until baby-cli -datadir=/home/baby2/.baby mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
babyd -datadir=/home/baby3/.baby -daemon
sleep 10
until baby-cli -datadir=/home/baby3/.baby mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
babyd -datadir=/home/baby4/.baby -daemon
sleep 10
until baby-cli -datadir=/home/baby4/.baby mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your Baby Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "Baby address: BBGZmMf6J9NLU8XvVt2czipoRn9a7VVVai"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
