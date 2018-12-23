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

echo -e ${YELLOW}"Welcome to the Zoomba Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install Zoomba Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE


if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for third node:"${NC}
read privkey3
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for fourth node:"${NC}
read privkey4
echo "Creating 4 Zoomba system users with no-login access:"
sudo adduser --system --home /home/zoomba zoomba
sudo adduser --system --home /home/zoomba2 zoomba2
sudo adduser --system --home /home/zoomba3 zoomba3
sudo adduser --system --home /home/zoomba4 zoomba4
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
sudo apt-get -y install libqrencode-dev bsdmainutils
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 5530/tcp
yes | ufw enable
sudo apt install git
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
sudo git clone https://github.com/zoombacoin/zoomba
sudo chmod -R 755 ~/zoomba
cd zoomba
sudo ./autogen.sh
sudo ./configure --disable-tests --disable-gui-tests
sudo make
sudo make install
cd /home/zoomba/
sudo mkdir /home/zoomba/.zoomba
sudo touch /home/zoomba/.zoomba/zoomba.conf
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5530\nbind=$(hostname  -I | cut -f1 -d' ')\ndaemon=1\nserver=1\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey\nexternalIP=$(hostname  -I | cut -f1 -d' '):5530\naddnode=217.69.4.225\naddnode=45.63.97.39\naddnode=136.0.9.13\naddnode=140.82.23.12\naddnode=80.211.184.163\naddnode=196.52.39.2\naddnode=173.239.219.13\naddnode=27.189.70.231\naddnode=201.69.111.172\naddnode=178.137.160.217\naddnode=94.194.188.35\naddnode=136.0.9.13\naddnode=24.159.113.249\naddnode=190.101.28.249\naddnode=173.239.210.39\naddnode=136.0.9.5\naddnode=149.28.236.13" >> /home/zoomba/.zoomba/zoomba.conf
cd /home/zoomba2
sudo mkdir /home/zoomba2/.zoomba
sudo touch /home/zoomba2/.zoomba/zoomba.conf
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5534\nbind=$(hostname  -I | cut -f1 -d' ')\ndaemon=1\nserver=1\nport=5533\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey2\nexternalIP=$(hostname  -I | cut -f1 -d' '):5530\naddnode=217.69.4.225\naddnode=45.63.97.39\naddnode=136.0.9.13\naddnode=140.82.23.12\naddnode=80.211.184.163\naddnode=196.52.39.2\naddnode=173.239.219.13\naddnode=27.189.70.231\naddnode=201.69.111.172\naddnode=178.137.160.217\naddnode=94.194.188.35\naddnode=136.0.9.13\naddnode=24.159.113.249\naddnode=190.101.28.249\naddnode=173.239.210.39\naddnode=136.0.9.5\naddnode=149.28.236.13" >> /home/zoomba2/.zoomba/zoomba.conf
cd /home/zoomba3
sudo mkdir /home/zoomba3/.zoomba
sudo touch /home/zoomba3/.zoomba/zoomba.conf
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5536\nbind=[$(hostname  -I | cut -f2 -d ' ')]\ndaemon=1\nserver=1\nport=5535\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey3\nexternalIP=[$(hostname  -I | cut -f2 -d' ')]:5530\naddnode=217.69.4.225\naddnode=45.63.97.39\naddnode=136.0.9.13\naddnode=140.82.23.12\naddnode=80.211.184.163\naddnode=196.52.39.2\naddnode=173.239.219.13\naddnode=27.189.70.231\naddnode=201.69.111.172\naddnode=178.137.160.217\naddnode=94.194.188.35\naddnode=136.0.9.13\naddnode=24.159.113.249\naddnode=190.101.28.249\naddnode=173.239.210.39\naddnode=136.0.9.5\naddnode=149.28.236.13" >> /home/zoomba3/.zoomba/zoomba.conf
cd /home/zoomba4
sudo mkdir /home/zoomba4/.zoomba
sudo touch /home/zoomba4/.zoomba/zoomba.conf
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\nrpcport=5538\nbind=[$(hostname  -I | cut -f2 -d' ')]\ndaemon=1\nserver=1\nport=5537\nlisten=0\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey4\nexternalIP=[$(hostname  -I | cut -f2 -d' ')]:5530\naddnode=217.69.4.225\naddnode=45.63.97.39\naddnode=136.0.9.13\naddnode=140.82.23.12\naddnode=80.211.184.163\naddnode=196.52.39.2\naddnode=173.239.219.13\naddnode=27.189.70.231\naddnode=201.69.111.172\naddnode=178.137.160.217\naddnode=94.194.188.35\naddnode=136.0.9.13\naddnode=24.159.113.249\naddnode=190.101.28.249\naddnode=173.239.210.39\naddnode=136.0.9.5\naddnode=149.28.236.13" >> /home/zoomba4/.zoomba/zoomba.conf
sleep 5
echo "Syncing first node, please wait...";
zoombad -datadir=/home/zoomba/.zoomba -daemon
sleep 10
until zoomba-cli -datadir=/home/zoomba/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your 1st masternode is running!"${NC}
sleep 10
echo "Syncing second node, please wait...";
zoombad -datadir=/home/zoomba2/.zoomba -daemon
sleep 10
until zoomba-cli -datadir=/home/zoomba2/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your second masternode is running!"${NC}
sleep 10
echo "Syncing third node, please wait...";
zoombad -datadir=/home/zoomba3/.zoomba -daemon
sleep 10
until zoomba-cli -datadir=/home/zoomba3/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Third node is fully synced. Your third masternode is running!"${NC}
sleep 10
echo "Syncing fourth node, please wait...";
zoombad -datadir=/home/zoomba4/.zoomba -daemon
sleep 10
until zoomba-cli -datadir=/home/zoomba4/.zoomba mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Last node is fully synced. Your fourth masternode is running!"${NC}
echo ""
echo -e ${GREEN}"Congrats! Your Zoomba coin Masternodes are now installed and started. Please wait from 20-30 minutes in order to give the masternode enough time to sync, then start the node from your wallet, Debug console option"${NC}
echo "If you think that this script helped in some way, feel free to donate for our work:"
echo "Zoomba coin address: Zh41h9gnCRxDvWaAF1RJonFZNMRDxyTinT"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
fi
