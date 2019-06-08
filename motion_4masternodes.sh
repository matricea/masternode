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

echo -e ${YELLOW}"Welcome to the Motion Automated Install, Durring this Process Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Are you sure you want to install Motion Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${NC}
read privkey2
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for third node:"${NC}
read privkey3
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for the forth node:"${NC}
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
sudo apt-get -y install libqrencode-dev bsdmainutils
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
echo "Installing Fail2ban and Ufw(Firewall)"
sudo apt-get -y install fail2ban ufw
service fail2ban restart
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 7979/tcp
yes | ufw enable
sudo apt install git
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
wget https://github.com/motioncrypto/motion/releases/download/v0.1.2/motion-v0.1.2-lin-64bits.zip
unzip motion-v0.1.2-lin-64bits.zip
sudo mv motiond motion-cli motion-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/motion*
sudo mkdir /home/motion
cd /home/motion/
sudo mkdir /home/motion/.motion
sudo touch /home/motion/.motion/motion.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/motion/.motion/motion.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/motion/.motion/motion.conf
echo "rpcallowip=127.0.0.1" >> /home/motion/.motion/motion.conf
echo "server=1" >> /home/motion/.motion/motion.conf
echo "daemon=1" >> /home/motion/.motion/motion.conf
echo "maxconnections=250" >> /home/motion/.motion/motion.conf
echo "masternode=1" >> /home/motion/.motion/motion.conf
echo "rpcport=7980" >> /home/motion/.motion/motion.conf
echo "port=79800" >> /home/motion/.motion/motion.conf
echo "listen=1" >> /home/motion/.motion/motion.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):7979" >> /home/motion/.motion/motion.conf
echo "masternodeprivkey=$privkey" >> /home/motion/.motion/motion.conf
echo "addnode=173.249.22.124" >> /home/motion/.motion/motion.conf
echo "addnode=66.42.111.56" >> /home/motion/.motion/motion.conf
echo "addnode=173.249.22.207" >> /home/motion/.motion/motion.conf
echo "addnode=207.246.68.245" >> /home/motion/.motion/motion.conf
echo "addnode=80.241.216.101" >> /home/motion/.motion/motion.conf
echo "addnode=54.39.25.93" >> /home/motion/.motion/motion.conf
echo "addnode=104.156.230.104" >> /home/motion/.motion/motion.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /home/motion/.motion/motion.conf
echo "addnode=173.199.70.184" >> /home/motion/.motion/motion.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /home/motion/.motion/motion.conf
echo "addnode=51.68.44.169" >> /home/motion/.motion/motion.conf
echo "addnode=80.211.184.163" >> /home/motion/.motion/motion.conf
echo "addnode=1209.97.147.101" >> /home/motion/.motion/motion.conf
sudo mkdir /home/motion2
cd /home/motion2
sudo mkdir /home/motion2/.motion
sudo touch /home/motion2/.motion/motion.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/motion2/.motion/motion.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/motion2/.motion/motion.conf
echo "rpcallowip=127.0.0.1" >> /home/motion2/.motion/motion.conf
echo "server=1" >> /home/motion2/.motion/motion.conf
echo "daemon=1" >> /home/motion2/.motion/motion.conf
echo "maxconnections=250" >> /home/motion2/.motion/motion.conf
echo "masternode=1" >> /home/motion2/.motion/motion.conf
echo "rpcport=7981" >> /home/motion2/.motion/motion.conf
echo "port=79811" >> /home/motion2/.motion/motion.conf
echo "listen=1" >> /home/motion2/.motion/motion.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):7979" >> /home/motion2/.motion/motion.conf
echo "masternodeprivkey=$privkey" >> /home/motion2/.motion/motion.conf
echo "addnode=173.249.22.124" >> /home/motion2/.motion/motion.conf
echo "addnode=66.42.111.56" >> /home/motion2/.motion/motion.conf
echo "addnode=173.249.22.207" >> /home/motion2/.motion/motion.conf
echo "addnode=207.246.68.245" >> /home/motion2/.motion/motion.conf
echo "addnode=80.241.216.101" >> /home/motion2/.motion/motion.conf
echo "addnode=54.39.25.93" >> /home/motion2/.motion/motion.conf
echo "addnode=104.156.230.104" >> /home/motion2/.motion/motion.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /home/motion2/.motion/motion.conf
echo "addnode=173.199.70.184" >> /home/motion2/.motion/motion.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /home/motion2/.motion/motion.conf
echo "addnode=51.68.44.169" >> /home/motion2/.motion/motion.conf
echo "addnode=80.211.184.163" >> /home/motion2/.motion/motion.conf
echo "addnode=1209.97.147.101" >> /home/motion2/.motion/motion.conf
sudo mkdir /home/motion3
cd /home/motion3
sudo mkdir /home/motion3/.motion
sudo touch /home/motion3/.motion/motion.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/motion3/.motion/motion.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/motion3/.motion/motion.conf
echo "rpcallowip=127.0.0.1" >> /home/motion3/.motion/motion.conf
echo "server=1" >> /home/motion3/.motion/motion.conf
echo "daemon=1" >> /home/motion3/.motion/motion.conf
echo "maxconnections=250" >> /home/motion3/.motion/motion.conf
echo "masternode=1" >> /home/motion3/.motion/motion.conf
echo "rpcport=7982" >> /home/motion3/.motion/motion.conf
echo "port=79822" >> /home/motion3/.motion/motion.conf
echo "listen=1" >> /home/motion3/.motion/motion.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):7979" >> /home/motion3/.motion/motion.conf
echo "masternodeprivkey=$privkey" >> /home/motion3/.motion/motion.conf
echo "addnode=173.249.22.124" >> /home/motion3/.motion/motion.conf
echo "addnode=66.42.111.56" >> /home/motion3/.motion/motion.conf
echo "addnode=173.249.22.207" >> /home/motion3/.motion/motion.conf
echo "addnode=207.246.68.245" >> /home/motion3/.motion/motion.conf
echo "addnode=80.241.216.101" >> /home/motion3/.motion/motion.conf
echo "addnode=54.39.25.93" >> /home/motion3/.motion/motion.conf
echo "addnode=104.156.230.104" >> /home/motion3/.motion/motion.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /home/motion3/.motion/motion.conf
echo "addnode=173.199.70.184" >> /home/motion3/.motion/motion.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /home/motion3/.motion/motion.conf
echo "addnode=51.68.44.169" >> /home/motion3/.motion/motion.conf
echo "addnode=80.211.184.163" >> /home/motion3/.motion/motion.conf
echo "addnode=1209.97.147.101" >> /home/motion3/.motion/motion.conf
sudo mkdir /home/motion4
cd /home/motion4
sudo mkdir /home/motion4/.motion
sudo touch /home/motion4/.motion/motion.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/motion4/.motion/motion.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/motion4/.motion/motion.conf
echo "rpcallowip=127.0.0.1" >> /home/motion4/.motion/motion.conf
echo "server=1" >> /home/motion4/.motion/motion.conf
echo "daemon=1" >> /home/motion4/.motion/motion.conf
echo "maxconnections=250" >> /home/motion4/.motion/motion.conf
echo "masternode=1" >> /home/motion4/.motion/motion.conf
echo "rpcport=7983" >> /home/motion4/.motion/motion.conf
echo "port=79833" >> /home/motion4/.motion/motion.conf
echo "listen=1" >> /home/motion4/.motion/motion.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):7979" >> /home/motion4/.motion/motion.conf
echo "masternodeprivkey=$privkey" >> /home/motion4/.motion/motion.conf
echo "addnode=173.249.22.124" >> /home/motion4/.motion/motion.conf
echo "addnode=66.42.111.56" >> /home/motion4/.motion/motion.conf
echo "addnode=173.249.22.207" >> /home/motion4/.motion/motion.conf
echo "addnode=207.246.68.245" >> /home/motion4/.motion/motion.conf
echo "addnode=80.241.216.101" >> /home/motion4/.motion/motion.conf
echo "addnode=54.39.25.93" >> /home/motion4/.motion/motion.conf
echo "addnode=104.156.230.104" >> /home/motion4/.motion/motion.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /home/motion4/.motion/motion.conf
echo "addnode=173.199.70.184" >> /home/motion4/.motion/motion.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /home/motion4/.motion/motion.conf
echo "addnode=51.68.44.169" >> /home/motion4/.motion/motion.conf
echo "addnode=80.211.184.163" >> /home/motion4/.motion/motion.conf
echo "addnode=1209.97.147.101" >> /home/motion4/.motion/motion.conf

echo "Syncing first node, please wait...";
motiond -datadir=/home/motion/.motion -daemon
until motion-cli -datadir=/home/motion/.motion mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"First node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing second node, please wait...";
motiond -datadir=/home/motion2/.motion -resync
until motion-cli -datadir=/home/motion2/.motion mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
echo "Syncing third node, please wait...";
motiond -datadir=/home/motion3/.motion
until motion-cli -datadir=/home/motion3/.motion mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo "Syncing forth node, please wait...";
motiond -datadir=/home/motion4/.motion
until motion-cli -datadir=/home/motion4/.motion mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"Second node is fully synced. Your masternode is running!"${NC}
sleep 5
echo -e ${GREEN}"Congrats! Your Masternodes are now installed and has started. Please wait 15-20 minutes in order to give the masternode enough time to sync, then start the node from your Windows wallet."${NC}
rm -rf /root/motion-1.0.2-ubuntu1604.zip
rm -rf /root/motion_4masternodes.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "Motion address: ZfkuV8WefFSiL1urBGamqsZ9h5osWJaoKX"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
fi
