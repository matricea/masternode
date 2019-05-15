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
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
wget https://github.com/zoombacoin/zoomba/releases/download/1.0.2/zoomba-1.0.2-ubuntu1604.zip
unzip zoomba-1.0.2-ubuntu1604.zip
sudo mv zoombad zoomba-cli zoomba-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/zoomba*
sudo mkdir /root/zoomba
cd /root/zoomba
sudo mkdir /root/zoomba/.zoomba
sudo touch /root/zoomba/.zoomba/zoomba.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /root/zoomba/.zoomba/zoomba.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /root/zoomba/.zoomba/zoomba.conf
echo "rpcallowip=127.0.0.1" >> /root/zoomba/.zoomba/zoomba.conf
echo "server=1" >> /root/zoomba/.zoomba/zoomba.conf
echo "daemon=1" >> /root/zoomba/.zoomba/zoomba.conf
echo "maxconnections=250" >> /root/zoomba/.zoomba/zoomba.conf
echo "masternode=1" >> /root/zoomba/.zoomba/zoomba.conf
echo "rpcport=5531" >> /root/zoomba/.zoomba/zoomba.conf
echo "port=55311" >> /root/zoomba/.zoomba/zoomba.conf
echo "listen=1" >> /root/zoomba/.zoomba/zoomba.conf
echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):5530" >> /root/zoomba/.zoomba/zoomba.conf
echo "masternodeprivkey=$privkey" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=173.249.22.124" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=66.42.111.56" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=173.249.22.207" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=207.246.68.245" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=80.241.216.101" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=54.39.25.93" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=104.156.230.104" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=[2001:19f0:ac01:1a83:5400:02ff:fe06:8a44]" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=173.199.70.184" >> /root/zoomba/.zoomba/zoomba.conf
echo "addnode=[2001:19f0:6801:1f35:5400:02ff:fe07:9e71]" >> /root/zoomba/.zoomba/zoomba.conf

echo "Syncing the node, please wait...";
zoombad -daemon
until zoomba-cli mnsync status | grep -m 1 '"IsBlockchainSynced" : true,'; do sleep 1 ; done > /dev/null 2>&1
echo -e ${GREEN}"The node is fully synced. Your masternode is running!"${NC}
sleep 5
echo -e ${GREEN}"Congrats! Your Masternode are now installed and has started. Please wait 15-20 minutes in order to give the masternode enough time to sync, then start the node from your Windows wallet."${NC}
rm -rf /root/zoomba-1.0.2-ubuntu1604.zip
rm -rf /root/zoomba_masternode.sh
cd ~
echo -e ${GREEN}"If you think that this script helped in some way, feel free to donate for our work:"${NC}
echo "Zoomba address: ZfkuV8WefFSiL1urBGamqsZ9h5osWJaoKX"
echo "LTC address: LbF8hSejc8oc4L81CrzdYengYBpr6xNczn"
echo "The END. You can close now the SSH terminal session";
fi
