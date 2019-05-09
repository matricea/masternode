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

echo -e ${YELLOW}"Welcome to the Panam 1.0.0 Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install Panam 1.0.0 Masternode? type y/n followed by [ENTER]:"${NC}
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
ufw allow 45788/tcp
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
wget https://github.com/panamcoin/Panam/releases/download/1.0.0/panam-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf panam-1.0.0-x86_64-linux-gnu.tar.gz
#cd panam-1.0.0-x86_64-linux-gnu
sudo mv panamd panam-cli panam-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/panam*
cd /root
sudo mkdir /home/panam
sudo mkdir /home/panam/.panam
sudo touch /home/panam/.panam/panam.conf
echo -e "${GREEN}Configuring Wallet for first node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/panam/.panam/panam.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/panam/.panam/panam.conf
echo "rpcallowip=127.0.0.1" >> /home/panam/.panam/panam.conf
echo "server=1" >> /home/panam/.panam/panam.conf
echo "daemon=1" >> /home/panam/.panam/panam.conf
echo "maxconnections=250" >> /home/panam/.panam/panam.conf
echo "masternode=1" >> /home/panam/.panam/panam.conf
echo "rpcport=45789" >> /home/panam/.panam/panam.conf
echo "port=457899" >> /home/panam/.panam/panam.conf
echo "listen=1" >> /home/panam/.panam/panam.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):45788" >> /home/panam/.panam/panam.conf
echo "masternodeprivkey=$privkey" >> /home/panam/.panam/panam.conf
echo "addnode=[2a00:1028:83a0:4ac2:4936:b996:cb1c:8b85]" >> /home/panam/.panam/panam.conf
echo "addnode=104.156.230.104" >> /home/panam/.panam/panam.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for second node${NC}"
sudo mkdir /home/panam2
sudo mkdir /home/panam2/.panam
sudo touch /home/panam2/.panam/panam.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/panam2/.panam/panam.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/panam2/.panam/panam.conf
echo "rpcallowip=127.0.0.1" >> /home/panam2/.panam/panam.conf
echo "server=1" >> /home/panam2/.panam/panam.conf
echo "daemon=1" >> /home/panam2/.panam/panam.conf
echo "maxconnections=250" >> /home/panam2/.panam/panam.conf
echo "masternode=1" >> /home/panam2/.panam/panam.conf
echo "rpcport=45790" >> /home/panam2/.panam/panam.conf
echo "port=457900" >> /home/panam2/.panam/panam.conf
echo "listen=1" >> /home/panam2/.panam/panam.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):45788" >> /home/panam2/.panam/panam.conf
echo "masternodeprivkey=$privkey2" >> /home/panam2/.panam/panam.conf
echo "addnode=[2a00:1028:83a0:4ac2:4936:b996:cb1c:8b85]" >> /home/panam2/.panam/panam.conf
echo "addnode=104.156.230.104" >> /home/panam2/.panam/panam.conf
sleep 5
sudo mkdir /home/panam3
sudo mkdir /home/panam3/.panam
sudo touch /home/panam3/.panam/panam.conf
echo -e "${GREEN}Configuring Wallet for third node${NC}"
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/panam3/.panam/panam.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/panam3/.panam/panam.conf
echo "rpcallowip=127.0.0.1" >> /home/panam3/.panam/panam.conf
echo "server=1" >> /home/panam3/.panam/panam.conf
echo "daemon=1" >> /home/panam3/.panam/panam.conf
echo "maxconnections=250" >> /home/panam3/.panam/panam.conf
echo "masternode=1" >> /home/panam3/.panam/panam.conf
echo "rpcport=45791" >> /home/panam3/.panam/panam.conf
echo "port=457911" >> /home/panam3/.panam/panam.conf
echo "listen=1" >> /home/panam3/.panam/panam.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):45788" >> /home/panam3/.panam/panam.conf
echo "masternodeprivkey=$privkey3" >> /home/panam3/.panam/panam.conf
echo "addnode=[2a00:1028:83a0:4ac2:4936:b996:cb1c:8b85]" >> /home/panam3/.panam/panam.conf
echo "addnode=104.156.230.104" >> /home/panam3/.panam/panam.conf
sleep 5
echo -e "${GREEN}Configuring Wallet for fourth node${NC}"
sudo mkdir /home/panam4
sudo mkdir /home/panam4/.panam
sudo touch /home/panam4/.panam/panam.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/panam4/.panam/panam.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/panam4/.panam/panam.conf
echo "rpcallowip=127.0.0.1" >> /home/panam4/.panam/panam.conf
echo "server=1" >> /home/panam4/.panam/panam.conf
echo "daemon=1" >> /home/panam4/.panam/panam.conf
echo "maxconnections=250" >> /home/panam4/.panam/panam.conf
echo "masternode=1" >> /home/panam4/.panam/panam.conf
echo "rpcport=45792" >> /home/panam4/.panam/panam.conf
echo "port=457922" >> /home/panam4/.panam/panam.conf
echo "listen=1" >> /home/panam4/.panam/panam.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):45788" >> /home/panam4/.panam/panam.conf
echo "masternodeprivkey=$privkey4" >> /home/panam4/.panam/panam.conf
echo "addnode=[2a00:1028:83a0:4ac2:4936:b996:cb1c:8b85]" >> /home/panam4/.panam/panam.conf
echo "addnode=104.156.230.104" >> /home/panam4/.panam/panam.conf
sleep 5
fi
echo "Syncing first node, please wait...";
panamd -datadir=/home/panam/.panam/ -daemon
sleep 10
until panam-cli -datadir=/home/panam/.panam/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
panamd -datadir=/home/panam2/.panam/ -daemon
sleep 10
until panam-cli -datadir=/home/panam2/.panam/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
panamd -datadir=/home/panam3/.panam/ -daemon
sleep 10
until panam-cli -datadir=/home/panam3/.panam/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
panamd -datadir=/home/panam4/.panam/ -daemon
sleep 10
until panam-cli -datadir=/home/panam4/.panam/ mnsync status | grep -m 1 '"IsBlockchainSynced": true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your Panam Masternodes are now installed and started. Please wait from 10-20 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "Deleting temporary files"
cd /root
#rm -rf /root/panam-1.0.0-x86_64-linux-gnu
rm -rf /root/panam-1.0.0-x86_64-linux-gnu.tar.gz
rm -rf /root/panam_4masternodes.sh
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "Panam address: PBgGuKGk3h3vayyYBWZj7SGLvD7nyL52of"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
