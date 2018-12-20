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
sudo adduser --system --home /home/kingscoin kingscoin
sudo adduser --system --home /home/kingscoin2 kingscoin2
sudo adduser --system --home /home/kingscoin3 kingscoin3
sudo adduser --system --home /home/kingscoin4 kingscoin4
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
ufw allow 1777/tcp
yes | ufw enable
#sudo apt install git
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
sudo mkdir /root//kingscoin
cd /root/kingscoin
wget https://github.com/kingscrypto/KINGSCOIN/releases/download/1.0.0/kingscoin-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzvf kingscoin-1.0.0-x86_64-linux-gnu.tar.gz
sudo mv /root/kingscoin/kingscoind /root/kingscoin/kingscoin-cli /root/kingscoin/kingscoin-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/kingscoin*
sudo mkdir /home/kingscoin/.kingscoin
sudo touch /home/kingscoin/.kingscoin/kingscoin.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "rpcallowip=127.0.0.1" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "server=1" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "daemon=1" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "maxconnections=250" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "masternode=1" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "rpcport=1778" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "listen=0" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):1777" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "masternodeprivkey=$privkey" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "addnode=80.211.174.239" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "addnode=80.211.45.25" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "addnode=80.211.40.41" >> /home/kingscoin/.kingscoin/kingscoin.conf
echo "addnode=185.43.210.213" >> /home/kingscoin/.kingscoin/kingscoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/kingscoin2/.kingscoin
sudo touch /home/kingscoin2/.kingscoin/kingscoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "rpcallowip=127.0.0.1" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "server=1" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "daemon=1" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "maxconnections=250" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "masternode=1" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "rpcport=1779" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "listen=0" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):1777" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "masternodeprivkey=$privkey2" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "addnode=80.211.174.239" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "addnode=80.211.45.25" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "addnode=80.211.40.41" >> /home/kingscoin2/.kingscoin/kingscoin.conf
echo "addnode=185.43.210.213" >> /home/kingscoin2/.kingscoin/kingscoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for third node${NC}"
sudo mkdir /home/kingscoin3/.kingscoin
sudo touch /home/kingscoin3/.kingscoin/kingscoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "rpcallowip=127.0.0.1" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "server=1" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "daemon=1" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "maxconnections=250" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "masternode=1" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "rpcport=1780" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "listen=0" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:1777" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "masternodeprivkey=$privkey3" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "addnode=80.211.174.239" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "addnode=80.211.45.25" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "addnode=80.211.40.41" >> /home/kingscoin3/.kingscoin/kingscoin.conf
echo "addnode=185.43.210.213" >> /home/kingscoin3/.kingscoin/kingscoin.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for 4th node${NC}"
sudo mkdir /home/kingscoin4/.kingscoin
sudo touch /home/kingscoin4/.kingscoin/kingscoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "rpcallowip=127.0.0.1" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "server=1" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "daemon=1" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "maxconnections=250" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "masternode=1" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "rpcport=1781" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "listen=0" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "externalip=[$(hostname  -I | cut -f2 -d' ')]:1777" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "masternodeprivkey=$privkey4" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "addnode=80.211.174.239" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "addnode=80.211.45.25" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "addnode=80.211.40.41" >> /home/kingscoin4/.kingscoin/kingscoin.conf
echo "addnode=185.43.210.213" >> /home/kingscoin4/.kingscoin/kingscoin.conf
sleep 5
fi
echo "Syncing first node, please wait...";
kingscoind -datadir=/home/kingscoin/.kingscoin -daemon
sleep 10
until kingscoin-cli -datadir=/home/kingscoin/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
kingscoind -datadir=/home/kingscoin2/.kingscoin -daemon
sleep 10
until kingscoin-cli -datadir=/home/kingscoin2/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
kingscoind -datadir=/home/kingscoin3/.kingscoin -daemon
sleep 10
until kingscoin-cli -datadir=/home/kingscoin3/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
kingscoind -datadir=/home/kingscoin4/.kingscoin -daemon
sleep 10
until kingscoin-cli -datadir=/home/kingscoin4/.kingscoin mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your KingsCoin Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this tutorial helped in some way, feel free to donate for our work:"
echo "KingsCoins address: K8cKv7AdK8Z8TVvADKKSTT8MvwmbnGxR3j"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
