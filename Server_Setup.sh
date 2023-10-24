#!/bin/bash

version="1.1"
author="Aperture Science"
OS="Ubuntu"
OS_Version="22.04"

#colors
Red='\033[0;31m'   #'0;31' is Red's ANSI color code
Green='\033[0;32m'   #'0;32' is Green's ANSI color code
Yellow='\033[1;32m'   #'1;32' is Yellow's ANSI color code
Blue='\033[0;34m'   #'0;34' is Blue's ANSI color code
NOCOLOR='\033[0m' #No Color ANSI code

#check for root
clear
if [ "$(id -u)" != "0" ]; then
   echo -e "${Red}This script must be run as root ${NOCOLOR}" 1>&2
   exit 1
fi
#check if the script is already running
if [ -f /var/run/aperture.pid ]; then
   echo -e "${Red}Script already running ${NOCOLOR}" 1>&2
   exit 1
fi
#create pid file
touch /var/run/aperture.pid

#check if the operating system is Ubuntu
if [ -f /etc/lsb-release ]; then
   . /etc/lsb-release
   if [ "$DISTRIB_ID" != "$OS" ]; then
      echo -e "${Red}This script is desingt to run on" $OS "and you are not using it on" $OS "this may lead to errors ${NOCOLOR}" 1>&2
   fi
fi

#check if the ubuntu version older tan 22.04 and print a warning message
if [ -f /etc/lsb-release ]; then
   . /etc/lsb-release
   if [ "$DISTRIB_RELEASE" != "$OS_Version" ]; then
      echo -e "${Red}You are not using $OS $OS_Version this may lead to errors ${NOCOLOR}" 1>&2
      #ask the user if he wants to continue if not exit the script
      read -p "Do you want to continue? (y/n) " -r
      echo ""
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
         exit 1
      fi
   fi
fi

echo ""
echo ""
echo -e "${Red}.▄▄▄.......██▓███..▓█████..██▀███..▄▄▄█████▓.█....██..██▀███..▓█████......██████..▄████▄...██▓▓█████..███▄....█..▄████▄..▓█████. ${NOCOLOR}"
echo -e "${Red}▒████▄....▓██░..██▒▓█...▀.▓██.▒.██▒▓..██▒.▓▒.██..▓██▒▓██.▒.██▒▓█...▀....▒██....▒.▒██▀.▀█..▓██▒▓█...▀..██.▀█...█.▒██▀.▀█..▓█...▀. ${NOCOLOR}"
echo -e "${Red}▒██..▀█▄..▓██░.██▓▒▒███...▓██.░▄█.▒▒.▓██░.▒░▓██..▒██░▓██.░▄█.▒▒███......░.▓██▄...▒▓█....▄.▒██▒▒███...▓██..▀█.██▒▒▓█....▄.▒███... ${NOCOLOR}"
echo -e "${Red}░██▄▄▄▄██.▒██▄█▓▒.▒▒▓█..▄.▒██▀▀█▄..░.▓██▓.░.▓▓█..░██░▒██▀▀█▄..▒▓█..▄......▒...██▒▒▓▓▄.▄██▒░██░▒▓█..▄.▓██▒..▐▌██▒▒▓▓▄.▄██▒▒▓█..▄. ${NOCOLOR}"
echo -e "${Red}.▓█...▓██▒▒██▒.░..░░▒████▒░██▓.▒██▒..▒██▒.░.▒▒█████▓.░██▓.▒██▒░▒████▒...▒██████▒▒▒.▓███▀.░░██░░▒████▒▒██░...▓██░▒.▓███▀.░░▒████▒ ${NOCOLOR}"
echo -e "${Red}.▒▒...▓▒█░▒▓▒░.░..░░░.▒░.░░.▒▓.░▒▓░..▒.░░...░▒▓▒.▒.▒.░.▒▓.░▒▓░░░.▒░.░...▒.▒▓▒.▒.░░.░▒.▒..░░▓..░░.▒░.░░.▒░...▒.▒.░.░▒.▒..░░░.▒░.░ ${NOCOLOR}"
echo -e "${Red}..▒...▒▒.░░▒.░......░.░..░..░▒.░.▒░....░....░░▒░.░.░...░▒.░.▒░.░.░..░...░.░▒..░.░..░..▒....▒.░.░.░..░░.░░...░.▒░..░..▒....░.░..░ ${NOCOLOR}"
echo -e "${Red}..░...▒...░░..........░.....░░...░...░.......░░░.░.░...░░...░....░......░..░..░..░.........▒.░...░......░...░.░.░...........░... ${NOCOLOR}"
echo -e "${Red}......░..░............░..░...░.................░........░........░..░.........░..░.░.......░.....░..░.........░.░.░.........░..░ ${NOCOLOR}"
echo -e "${Red}.................................................................................░..............................░............... ${NOCOLOR}"
echo ""
echo -e "${Red}Aperture Science Server setup script ${NOCOLOR}"
echo -e "${Red}Version $version  ${NOCOLOR}"
echo -e "${Red}Copyright (C) 2022 Aperture Science ${NOCOLOR}"
echo ""
echo -e "${Red}This program is free software: you can redistribute it and/or modify ${NOCOLOR}"
echo -e "${Red}it is under the terms of the GNU General Public License  ${NOCOLOR}"
echo ""




#apt update
apt-get update
#apt upgrade
apt-get upgrade -y
#install wget
apt-get install wget -y


#!##########################################[NALA INSTALL]###################################################################

#install nala
echo  -e "${Green}Installing Nala ${NOCOLOR}"
echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
apt update 
#check the os version and install the correct nala version
if [ -f /etc/lsb-release ]; then
   . /etc/lsb-release
   if [ "$DISTRIB_RELEASE" = "$OS_Version" ]; then
      apt-get install nala -y
   else
      apt-get install nala-legacy -y
   fi
fi



#check if nala is installed and print success message in green or error message in red
if [ -f /usr/bin/nala ]; then
   echo  -e "${Green}Nala installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}Nala failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install nala manually ${NOCOLOR}"
   echo  -e "${Red}Nala is a core componet of this script and must be installed  ${NOCOLOR}"
   echo  -e "${Red}The scritp will now stop bye bye <3  ${NOCOLOR}"
   #remove the pid file
   rm /var/run/aperture.pid
   exit 1
fi

#update nala
echo -e "${Green}Updating Nala ${NOCOLOR}"
nala update
nala upgrade -y

#!##########################################[BASE PACK INSTALL]###################################################################

#install openssh-server over nala
echo -e "${Green}Installing openssh-server ${NOCOLOR}"
nala install openssh-server -y
#check if openssh-server is installed and print success message in green or error message in red
if [ -f /usr/sbin/sshd ]; then
   echo  -e "${Green}openssh-server installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}openssh-server failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install openssh-server manually ${NOCOLOR}"
fi



#install neofetch over nala
echo -e "${Green}Installing neofetch ${NOCOLOR}"
nala install neofetch -y
#check if neofetch is installed and print success message in green or error message in red
if [ -f /usr/bin/neofetch ]; then
   echo  -e "${Green}Neofetch installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}Neofetch failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install neofetch manually ${NOCOLOR}"
fi


#install net-tools over nala
echo -e "${Green}Installing net-tools ${NOCOLOR}"
nala install net-tools -y
#check if net-tools is installed and print success message in green or error message in red
#if [ -f /usr/bin/ifconfig ]; then
#  echo  -e "${Green}Net-tools installed successfully ${NOCOLOR}"
#else
#   echo  -e "${Red}Net-tools failed to install ${NOCOLOR}"
#   echo  -e "${Red}Please install net-tools manually ${NOCOLOR}"
#fi


#install nano over nala
echo -e "${Green}Installing nano ${NOCOLOR}"
nala install nano -y
#check if nano is installed and print success message in green or error message in red
if [ -f /usr/bin/nano ]; then
   echo  -e "${Green}nano installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}nano failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install nano manually ${NOCOLOR}"
   
fi


#install curl over nala
echo -e "${Green}Installing curl ${NOCOLOR}"
nala install curl -y
#check if curl is installed and print success message in green or error message in red
if [ -f /usr/bin/curl ]; then
   echo  -e "${Green}curl installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}curl failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install curl manually ${NOCOLOR}"
   
fi


#install git over nala
echo -e "${Green}Installing git ${NOCOLOR}"
nala install git -y
#check if git is installed and print success message in green or error message in red
if [ -f /usr/bin/git ]; then
   echo  -e "${Green}Git installed successfully ${NOCOLOR}"
else
   echo  -e "${Red}Git failed to install ${NOCOLOR}"
   echo  -e "${Red}Please install git manually ${NOCOLOR}"
   
fi


#installtion of homebrew
#echo "Installing Homebrew"
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#apt-get install build-essential

#install htop over nala
echo -e "${Green}Installing htop ${NOCOLOR}"
nala install htop -y
#check if htop is installed and print success message or error message


#!##########################################[BANNER and BASH SETUP]###################################################################

#copy the 99-banner file to /etc/update-motd.d/99-banner
echo -e "${Green}Installing banner ${NOCOLOR}"
cp 99-banner /etc/update-motd.d/99-banner
#make the file executable
chmod +x /etc/update-motd.d/99-banner


#get the username of the user with the id of 1000
USERNAME=$(cat /etc/passwd | grep 1000 | cut -d: -f1)
#change to the home directory of the user
cd /home/$USERNAME
echo $USERNAME
echo   -e "${Green}Changing to home directory of user ${NOCOLOR}"
#add the following to the .bashrc file
sudo -u $USERNAME echo "PS1='\[\e[0;91m\]Aperture Science Server Shell \n\[\e[0;91m\]├\[\e[0;91m\]SYSTEM:\[\e[0;38;5;202m\]\h \[\e[0;91m\]IP:\[\e[0;38;5;202m\]$(hostname -I) \[\e[0;91m\]USER:\[\e[0;38;5;202m\]\u\n\[\e[0;91m\]├\[\e[0;91m\]DIR:\[\e[0;38;5;199m\]\w\n\[\e[0;91m\]└\[\e[0;97m\]> \[ ${NOCOLOR}\]'" >> .bashrc

#!##########################################################[SOME SOFTWARE]###################################################################

#ask the user if they want to install docker and docker-compose over nala
echo -e "${Green}Do you want to install docker and docker-compose? ${NOCOLOR}"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install docker 
    echo -e "${Green}Installing docker ${NOCOLOR}"
    echo -e "${Green}Installing docker-compose ${NOCOLOR}"
    curl https://get.docker.com | bash
    #check if docker is installed and print success message in green or error message in red
    if [ -f /usr/bin/docker ]; then
       echo  -e "${Green}docker installed successfully ${NOCOLOR}"
    else
       echo  -e "${Red}docker failed to install ${NOCOLOR}"
       echo  -e "${Red}Please install docker manually ${NOCOLOR}"
    fi
    #check if docker-compose is installed and print success message in green or error message in red
    if [ -f /usr/bin/docker-compose ]; then
       echo  -e "${Green}docker-compose installed successfully ${NOCOLOR}"
    else
       echo  -e "${Red}docker-compose failed to install ${NOCOLOR}"
       echo  -e "${Red}Please install docker-compose manually ${NOCOLOR}"
    fi
fi

#ask the user if they want to install portainer 
echo -e "${Green}Do you want to install portainer? ${NOCOLOR}"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install portainer
    echo -e "${Green}Installing portainer ${NOCOLOR}"
    docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /media/portainer:/data portainer/portainer-ce:latest
fi

#ask the user if they want to install netdata in a docker container
echo -e "${Green}Do you want to install netdata in a docker container? (docker needet) ${NOCOLOR}"
read -p "y/n: "  
echo    # (optional) move to a new line
#check if docker is installed 
if [[ $REPLY =~ ^[Yy]$ ]]
then
   if [ -f /usr/bin/docker ]; then
       echo  -e "${Green}docker is installed  ${NOCOLOR}"
       #install netdata
         echo -e "${Green}Installing netdata ${NOCOLOR}"
         docker run -d --name=netdata \
               -p 19999:19999 \
               -v netdataconfig:/etc/netdata \
               -v netdatalib:/var/lib/netdata \
               -v netdatacache:/var/cache/netdata \
               -v /etc/passwd:/host/etc/passwd:ro \
               -v /etc/group:/host/etc/group:ro \
               -v /proc:/host/proc:ro \
               -v /sys:/host/sys:ro \
               -v /etc/os-release:/host/etc/os-release:ro \
               --restart unless-stopped \
               --cap-add SYS_PTRACE \
               --security-opt apparmor=unconfined \
               netdata/netdata:latest
    else
       echo  -e "${Red}docker is not installed ${NOCOLOR}"
       echo  -e "${Red}can not run netdata as container ${NOCOLOR}"
    fi   
fi

#get the local ip address of the server and save it in a variable
IP=$(hostname -I)

#ask the user if they want to install webmin
echo -e "${Green}Do you want to install webmin? ${NOCOLOR}"
read -p "y/n: "
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install webmin
    echo -e "${Green}Installing webmin ${NOCOLOR}"
    apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip -y
    wget http://prdownloads.sourceforge.net/webadmin/webmin_2.000_all.deb
    dpkg --install webmin_2.000_all.deb
    rm webmin_2.000_all.deb
    #test if you get a anser for  a webserver on port 10000
      echo -e "${Green}Testing if webmin is installed ${NOCOLOR}"
      if nc -z -w1 localhost 10000; then
         echo  -e "${Green}Webmin installed successfully ${NOCOLOR}"
         echo  -e "${Green}Webmin is running on http:// $IP :10000  ${NOCOLOR}"
               else
         echo  -e "${Red}Webmin failed to install ${NOCOLOR}"
         echo  -e "${Red}Please install webmin manually ${NOCOLOR}"
      fi
   
fi

#ask the user if they want to install ROS
echo -e "${Green}Do you want to install ROS? (ROS-noetic/ ubuntu 22) ${NOCOLOR}"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install ROS
      echo -e "${Green}Installing ROS ${NOCOLOR}"
      sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
      curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
      apt-get update
      sudo apt install ros-noetic-desktop-full -y
      echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
      apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
      apt install python3-rosdep -y
      rosdep init
      rosdep update
      source ~/.bashrc
fi



#print in green taht the script is done
echo  "\e[32mDone ${NOCOLOR}"

#remove the pid file
rm /var/run/aperture.pid

#restart the ssh service
echo -e "${Green}Restarting ssh service ${NOCOLOR}"
systemctl restart sshd