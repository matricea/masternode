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

echo -e ${YELLOW}"Welcome to the KingsCoin Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install KingsCoin Masternode? type y/n followed by [ENTER]:"${NC}
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
echo "Creating 4 KingsCoin system users with no-login access:"
sudo adduser --system --home /home/kgs kgs
sudo adduser --system --home /home/kgs2 kgs2
sudo adduser --system --home /home/kgs3 kgs3
sudo adduser --system --home /home/kgs4 kgs4
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
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 17700/tcp
yes | ufw enable
#sudo apt install git
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd /root
wget https://github.com/kingscrypto/KGS/releases/download/v3.1.1/kgs-3.1.1.1-Ubuntu16.tar.gz
tar -xzf kgs-3.1.1.1-Ubuntu16.tar.gz
cd kgs-3.1.1.1-Ubuntu16
sudo mv kgsd kgs-qt kgs-cli kgs-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/kgs*
cd /root
sudo mkdir /home/kgs/.kgs
sudo touch /home/kgs/.kgs/kgs.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kgs/.kgs/kgs.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kgs/.kgs/kgs.conf
echo "rpcallowip=127.0.0.1" >> /home/kgs/.kgs/kgs.conf
echo "server=1" >> /home/kgs/.kgs/kgs.conf
echo "daemon=1" >> /home/kgs/.kgs/kgs.conf
echo "maxconnections=250" >> /home/kgs/.kgs/kgs.conf
echo "masternode=1" >> /home/kgs/.kgs/kgs.conf
echo "rpcport=17711" >> /home/kgs/.kgs/kgs.conf
echo "listen=0" >> /home/kgs/.kgs/kgs.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kgs/.kgs/kgs.conf
echo "masternodeprivkey=$privkey" >> /home/kgs/.kgs/kgs.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/kgs2/.kgs
sudo touch /home/kgs2/.kgs/kgs.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kgs2/.kgs/kgs.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kgs2/.kgs/kgs.conf
echo "rpcallowip=127.0.0.1" >> /home/kgs2/.kgs/kgs.conf
echo "server=1" >> /home/kgs2/.kgs/kgs.conf
echo "daemon=1" >> /home/kgs2/.kgs/kgs.conf
echo "maxconnections=250" >> /home/kgs2/.kgs/kgs.conf
echo "masternode=1" >> /home/kgs2/.kgs/kgs.conf
echo "rpcport=17712" >> /home/kgs2/.kgs/kgs.conf
echo "listen=0" >> /home/kgs2/.kgs/kgs.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kgs2/.kgs/kgs.conf
echo "masternodeprivkey=$privkey2" >> /home/kgs2/.kgs/kgs.conf
sleep 5
sudo mkdir /home/kgs3/.kgs
sudo touch /home/kgs3/.kgs/kgs.conf
echo -e "${GREEN}Configuring Wallet for third node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kgs3/.kgs/kgs.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kgs3/.kgs/kgs.conf
echo "rpcallowip=127.0.0.1" >> /home/kgs3/.kgs/kgs.conf
echo "server=1" >> /home/kgs3/.kgs/kgs.conf
echo "daemon=1" >> /home/kgs3/.kgs/kgs.conf
echo "maxconnections=250" >> /home/kgs3/.kgs/kgs.conf
echo "masternode=1" >> /home/kgs3/.kgs/kgs.conf
echo "rpcport=17713" >> /home/kgs3/.kgs/kgs.conf
echo "listen=0" >> /home/kgs3/.kgs/kgs.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kgs3/.kgs/kgs.conf
echo "masternodeprivkey=$privkey3" >> /home/kgs3/.kgs/kgs.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for fourth node${NC}"
sudo mkdir /home/kgs4/.kgs
sudo touch /home/kgs4/.kgs/kgs.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kgs4/.kgs/kgs.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kgs4/.kgs/kgs.conf
echo "rpcallowip=127.0.0.1" >> /home/kgs4/.kgs/kgs.conf
echo "server=1" >> /home/kgs4/.kgs/kgs.conf
echo "daemon=1" >> /home/kgs4/.kgs/kgs.conf
echo "maxconnections=250" >> /home/kgs4/.kgs/kgs.conf
echo "masternode=1" >> /home/kgs4/.kgs/kgs.conf
echo "rpcport=17714" >> /home/kgs4/.kgs/kgs.conf
echo "listen=0" >> /home/kgs4/.kgs/kgs.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):17700" >> /home/kgs4/.kgs/kgs.conf
echo "masternodeprivkey=$privkey4" >> /home/kgs4/.kgs/kgs.conf
sleep 5
fi
echo "Syncing first node, please wait...";
kgsd -datadir=/home/kgs/.kgs/ -daemon
sleep 10
until kgs-cli -datadir=/home/kgs/.kgs/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
kgsd -datadir=/home/kgs2/.kgs/ -daemon
sleep 10
until kgs-cli -datadir=/home/kgs2/.kgs/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
kgsd -datadir=/home/kgs3/.kgs/ -daemon
sleep 10
until kgs-cli -datadir=/home/kgs3/.kgs/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
kgsd -datadir=/home/kgs4/.kgs/ -daemon
sleep 10
until kgs-cli -datadir=/home/kgs4/.kgs/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your KingsCoin Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "Deleting temporary files"
cd /root
rm -rf /root/kgs-3.1.1.1-Ubuntu16
rm -rf /root/kgs-3.1.1.1-Ubuntu16.tar.gz
rm -rf /root/kingscoin_4masternodes.sh
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "KingsCoins address: KJignF72dMXKas2HcZwGtxibDPBC6j2vm5"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
