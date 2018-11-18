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

echo -e ${YELLOW}"Welcome to the Concierge Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install a Concierge Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo "Creating 2 Concierge system users with no-login access:"
sudo adduser --system --home /home/concierge concierge
sudo adduser --system --home /home/concierge2 concierge2
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
sudo mkdir /root/concierge
cd /root/concierge
wget https://github.com/ConciergeCoin/Concierge/releases/download/V1.0.0.1/Concierge-linux.tar.gz
tar -xzvf Concierge-linux.tar.gz
sudo mv /root/concierge/concierged /root/concierge/concierge-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/concierge*
sudo mkdir /home/concierge/.concierge
sudo touch /home/concierge/.concierge/concierge.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/concierge/.concierge/concierge.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/concierge/.concierge/concierge.conf
echo "rpcallowip=127.0.0.1" >> /home/concierge/.concierge/concierge.conf
echo "server=1" >> /home/concierge/.concierge/concierge.conf
echo "daemon=1" >> /home/concierge/.concierge/concierge.conf
echo "maxconnections=250" >> /home/concierge/.concierge/concierge.conf
echo "masternode=1" >> /home/concierge/.concierge/concierge.conf
echo "rpcport=51471" >> /home/concierge/.concierge/concierge.conf
echo "listen=0" >> /home/concierge/.concierge/concierge.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):51470" >> /home/concierge/.concierge/concierge.conf
echo "masternodeprivkey=$privkey" >> /home/concierge/.concierge/concierge.conf
echo "addnode=93.103.247.155" >> /home/concierge/.concierge/concierge.conf
echo "addnode=80.211.19.145" >> /home/concierge/.concierge/concierge.conf
echo "addnode=209.250.252.123" >> /home/concierge/.concierge/concierge.conf
echo "addnode=128.199.164.15" >> /home/concierge/.concierge/concierge.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/concierge2/.concierge
sudo touch /home/concierge2/.concierge/concierge.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/concierge2/.concierge/concierge.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/concierge2/.concierge/concierge.conf
echo "rpcallowip=127.0.0.1" >> /home/concierge2/.concierge/concierge.conf
echo "server=1" >> /home/concierge2/.concierge/concierge.conf
echo "daemon=1" >> /home/concierge2/.concierge/concierge.conf
echo "maxconnections=250" >> /home/concierge2/.concierge/concierge.conf
echo "masternode=1" >> /home/concierge2/.concierge/concierge.conf
echo "rpcport=51472" >> /home/concierge2/.concierge/concierge.conf
echo "listen=0" >> /home/concierge2/.concierge/concierge.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):51470" >> /home/concierge2/.concierge/concierge.conf
echo "masternodeprivkey=$privkey2" >> /home/concierge2/.concierge/concierge.conf
echo "addnode=93.103.247.155" >> /home/concierge2/.concierge/concierge.conf
echo "addnode=80.211.19.145" >> /home/concierge2/.concierge/concierge.conf
echo "addnode=209.250.252.123" >> /home/concierge2/.concierge/concierge.conf
echo "addnode=128.199.164.15" >> /home/concierge2/.concierge/concierge.conf
sleep 5
fi
echo "Syncing first node, please wait...";
concierged -datadir=/home/concierge/.concierge -daemon
sleep 300
#until concierge-cli -datadir=/home/concierge/.concierge mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
#echo -e ${GREEN}"First node is fully synced. You 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
concierged -datadir=/home/concierge2/.concierge -daemon
sleep 300
#until concierge-cli -datadir=/home/concierge2/.concierge mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
#echo -e ${GREEN}"Second node is fully synced. You 1st masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your Concierge Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this script helped in some way, feel free to donate:"
echo "Concierge donations: CeHg3hMZokTCXS1HSq6yiadVRqkxNPCKt2"
echo "LTC donnations: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn";
