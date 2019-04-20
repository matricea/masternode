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

echo -e ${YELLOW}"Welcome to the SecureCloud-2.5.1 Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install SecureCloud Masternode? type y/n followed by [ENTER]:"${NC}
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
echo "Creating 4 SecureCloud system users with no-login access:"
sudo adduser --system --home /home/securecloud securecloud
sudo adduser --system --home /home/securecloud2 securecloud2
sudo adduser --system --home /home/securecloud3 securecloud3
sudo adduser --system --home /home/securecloud4 securecloud4
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
sudo mkdir /root/scn
cd /root/scn
echo "Downloading latest binaries"
wget https://github.com/securecloudnet/SecureCloud/releases/download/v2.5.1/SecureCloud-linux.tar.gz
tar -xzf SecureCloud-linux.tar.gz
sudo mv /root/scn/securecloudd /root/scn/securecloud-cli /root/scn/securecloud-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/securecloud*
rm -rf /root/scn
sudo mkdir /home/securecloud/.securecloud
sudo touch /home/securecloud/.securecloud/securecloud.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/securecloud/.securecloud/securecloud.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/securecloud/.securecloud/securecloud.conf
echo "rpcallowip=127.0.0.1" >> /home/securecloud/.securecloud/securecloud.conf
echo "server=1" >> /home/securecloud/.securecloud/securecloud.conf
echo "daemon=1" >> /home/securecloud/.securecloud/securecloud.conf
echo "maxconnections=250" >> /home/securecloud/.securecloud/securecloud.conf
echo "masternode=1" >> /home/securecloud/.securecloud/securecloud.conf
echo "rpcport=9191" >> /home/securecloud/.securecloud/securecloud.conf
echo "listen=0" >> /home/securecloud/.securecloud/securecloud.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):9191" >> /home/securecloud/.securecloud/securecloud.conf
echo "masternodeprivkey=$privkey" >> /home/securecloud/.securecloud/securecloud.conf
echo "addnode=93.103.247.155" >> /home/securecloud/.securecloud/securecloud.conf
echo "addnode=80.211.19.145" >> /home/securecloud/.securecloud/securecloud.conf
echo "addnode=209.250.252.123" >> /home/securecloud/.securecloud/securecloud.conf
echo "addnode=128.199.164.15" >> /home/securecloud/.securecloud/securecloud.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/securecloud2/.securecloud
sudo touch /home/securecloud2/.securecloud/securecloud.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/securecloud2/.securecloud/securecloud.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/securecloud2/.securecloud/securecloud.conf
echo "rpcallowip=127.0.0.1" >> /home/securecloud2/.securecloud/securecloud.conf
echo "server=1" >> /home/securecloud2/.securecloud/securecloud.conf
echo "daemon=1" >> /home/securecloud2/.securecloud/securecloud.conf
echo "maxconnections=250" >> /home/securecloud2/.securecloud/securecloud.conf
echo "masternode=1" >> /home/securecloud2/.securecloud/securecloud.conf
echo "rpcport=9192" >> /home/securecloud2/.securecloud/securecloud.conf
echo "listen=0" >> /home/securecloud2/.securecloud/securecloud.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):9191" >> /home/securecloud2/.securecloud/securecloud.conf
echo "masternodeprivkey=$privkey2" >> /home/securecloud2/.securecloud/securecloud.conf
echo "addnode=93.103.247.155" >> /home/securecloud2/.securecloud/securecloud.conf
echo "addnode=80.211.19.145" >> /home/securecloud2/.securecloud/securecloud.conf
echo "addnode=209.250.252.123" >> /home/securecloud2/.securecloud/securecloud.conf
echo "addnode=128.199.164.15" >> /home/securecloud2/.securecloud/securecloud.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for third node${NC}"
sudo mkdir /home/securecloud3/.securecloud
sudo touch /home/securecloud3/.securecloud/securecloud.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/securecloud3/.securecloud/securecloud.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/securecloud3/.securecloud/securecloud.conf
echo "rpcallowip=127.0.0.1" >> /home/securecloud3/.securecloud/securecloud.conf
echo "server=1" >> /home/securecloud3/.securecloud/securecloud.conf
echo "daemon=1" >> /home/securecloud3/.securecloud/securecloud.conf
echo "maxconnections=250" >> /home/securecloud3/.securecloud/securecloud.conf
echo "masternode=1" >> /home/securecloud3/.securecloud/securecloud.conf
echo "rpcport=9193" >> /home/securecloud3/.securecloud/securecloud.conf
echo "listen=0" >> /home/securecloud3/.securecloud/securecloud.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:9191" >> /home/securecloud3/.securecloud/securecloud.conf
echo "masternodeprivkey=$privkey3" >> /home/securecloud3/.securecloud/securecloud.conf
echo "addnode=93.103.247.155" >> /home/securecloud3/.securecloud/securecloud.conf
echo "addnode=80.211.19.145" >> /home/securecloud3/.securecloud/securecloud.conf
echo "addnode=209.250.252.123" >> /home/securecloud3/.securecloud/securecloud.conf
echo "addnode=128.199.164.15" >> /home/securecloud3/.securecloud/securecloud.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for 4th node${NC}"
sudo mkdir /home/securecloud4/.securecloud
sudo touch /home/securecloud4/.securecloud/securecloud.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/securecloud4/.securecloud/securecloud.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/securecloud4/.securecloud/securecloud.conf
echo "rpcallowip=127.0.0.1" >> /home/securecloud4/.securecloud/securecloud.conf
echo "server=1" >> /home/securecloud4/.securecloud/securecloud.conf
echo "daemon=1" >> /home/securecloud4/.securecloud/securecloud.conf
echo "maxconnections=250" >> /home/securecloud4/.securecloud/securecloud.conf
echo "masternode=1" >> /home/securecloud4/.securecloud/securecloud.conf
echo "rpcport=9194" >> /home/securecloud4/.securecloud/securecloud.conf
echo "listen=0" >> /home/securecloud4/.securecloud/securecloud.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:9191" >> /home/securecloud4/.securecloud/securecloud.conf
echo "masternodeprivkey=$privkey4" >> /home/securecloud4/.securecloud/securecloud.conf
echo "addnode=93.103.247.155" >> /home/securecloud4/.securecloud/securecloud.conf
echo "addnode=80.211.19.145" >> /home/securecloud4/.securecloud/securecloud.conf
echo "addnode=209.250.252.123" >> /home/securecloud4/.securecloud/securecloud.conf
echo "addnode=128.199.164.15" >> /home/securecloud4/.securecloud/securecloud.conf
sleep 5
fi
echo "Syncing first node, please wait...";
securecloudd -datadir=/home/securecloud/.securecloud -daemon
sleep 10
until securecloud-cli -datadir=/home/securecloud/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
securecloudd -datadir=/home/securecloud2/.securecloud -daemon
sleep 10
until securecloud-cli -datadir=/home/securecloud2/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
securecloudd -datadir=/home/securecloud3/.securecloud -daemon
sleep 10
until securecloud-cli -datadir=/home/securecloud3/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
securecloudd -datadir=/home/securecloud4/.securecloud -daemon
sleep 10
until securecloud-cli -datadir=/home/securecloud4/.securecloud mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
rm -rf /root/securecloud_4masternodes.sh
echo -e ${GREEN}"Congrats! Your SecureCloud Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "SecureCloudNet address: sUhHTix3QzMLFKKGiQ5U7s9MLJNopr3M6B"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
