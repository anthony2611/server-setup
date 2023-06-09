#check for root
clear
if [ "$(id -u)" != "0" ]; then
   echo "\e[91mThis script must be run as root\e[0mva" 1>&2
   exit 1
fi
#check if the script is already running
if [ -f /var/run/aperture.pid ]; then
   echo "\e[91mScript already running\e[0m" 1>&2
   exit 1
fi
#create pid file
touch /var/run/aperture.pid

#check if the operating system is Ubuntu
if [ -f /etc/lsb-release ]; then
   . /etc/lsb-release
   if [ "$DISTRIB_ID" != "Ubuntu" ]; then
      echo "\e[91mThis script is desingt to run on Ubuntu and you are not using it on Ubuntu this may lead to errors\e[0m" 1>&2
   fi
fi

#display the banner

echo ""
echo ""
echo "\e[91m.▄▄▄.......██▓███..▓█████..██▀███..▄▄▄█████▓.█....██..██▀███..▓█████......██████..▄████▄...██▓▓█████..███▄....█..▄████▄..▓█████.\e[0m"
echo "\e[91m▒████▄....▓██░..██▒▓█...▀.▓██.▒.██▒▓..██▒.▓▒.██..▓██▒▓██.▒.██▒▓█...▀....▒██....▒.▒██▀.▀█..▓██▒▓█...▀..██.▀█...█.▒██▀.▀█..▓█...▀.\e[0m"
echo "\e[91m▒██..▀█▄..▓██░.██▓▒▒███...▓██.░▄█.▒▒.▓██░.▒░▓██..▒██░▓██.░▄█.▒▒███......░.▓██▄...▒▓█....▄.▒██▒▒███...▓██..▀█.██▒▒▓█....▄.▒███...\e[0m"
echo "\e[91m░██▄▄▄▄██.▒██▄█▓▒.▒▒▓█..▄.▒██▀▀█▄..░.▓██▓.░.▓▓█..░██░▒██▀▀█▄..▒▓█..▄......▒...██▒▒▓▓▄.▄██▒░██░▒▓█..▄.▓██▒..▐▌██▒▒▓▓▄.▄██▒▒▓█..▄.\e[0m"
echo "\e[91m.▓█...▓██▒▒██▒.░..░░▒████▒░██▓.▒██▒..▒██▒.░.▒▒█████▓.░██▓.▒██▒░▒████▒...▒██████▒▒▒.▓███▀.░░██░░▒████▒▒██░...▓██░▒.▓███▀.░░▒████▒\e[0m"
echo "\e[91m.▒▒...▓▒█░▒▓▒░.░..░░░.▒░.░░.▒▓.░▒▓░..▒.░░...░▒▓▒.▒.▒.░.▒▓.░▒▓░░░.▒░.░...▒.▒▓▒.▒.░░.░▒.▒..░░▓..░░.▒░.░░.▒░...▒.▒.░.░▒.▒..░░░.▒░.░\e[0m"
echo "\e[91m..▒...▒▒.░░▒.░......░.░..░..░▒.░.▒░....░....░░▒░.░.░...░▒.░.▒░.░.░..░...░.░▒..░.░..░..▒....▒.░.░.░..░░.░░...░.▒░..░..▒....░.░..░\e[0m"
echo "\e[91m..░...▒...░░..........░.....░░...░...░.......░░░.░.░...░░...░....░......░..░..░..░.........▒.░...░......░...░.░.░...........░...\e[0m"
echo "\e[91m......░..░............░..░...░.................░........░........░..░.........░..░.░.......░.....░..░.........░.░.░.........░..░\e[0m"
echo "\e[91m.................................................................................░..............................░...............\e[0m"
echo ""
echo "\e[91mAperture Science Server setup script\e[0m"
echo "\e[91mVersion 1.0\e[0m"
echo "\e[91mCopyright (C) 2022 Aperture Science\e[0m"
echo ""
echo "\e[91mThis program is free software: you can redistribute it and/or modify\e[0m"
echo "\e[91mit under the terms of the GNU General Public License as published by\e[0m"
echo ""


#apt update
apt-get update
#apt upgrade
apt-get upgrade -y
#install wget
apt-get install wget -y

#check if the ubuntu version older tan 22.04 and print a warning message
if [ -f /etc/lsb-release ]; then
   . /etc/lsb-release
   if [ "$DISTRIB_RELEASE" != "22.04" ]; then
      echo "\e[91mYou are not using Ubuntu 22.04 this may lead to errors\e[0m" 1>&2
      exit
   fi
fi

#install nala
echo  "\e[92mInstalling Nala\e[0m"
echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
apt update && sudo apt install nala -y
#check if nala is installed and print success message in green or error message in red
if [ -f /usr/bin/nala ]; then
   echo  "\e[92mNala installed successfully\e[0m"
else
   echo  "\e[91mNala failed to install\e[0m"
   echo  "\e[91mPlease install nala manually\e[0m"
   echo  "\e[91mNala is a core componet of this script and must be installed \e[0m"
   echo  "\e[91mThe scritp will now stop bye bye <3 \e[0m"
   #remove the pid file
   rm /var/run/aperture.pid
   exit 1
fi

#update nala
echo "\e[92mUpdating Nala\e[0m"
nala update
nala upgrade -y

#install neofetch over nala
echo "\e[92mInstalling neofetch\e[0m"
nala install neofetch -y
#check if neofetch is installed and print success message in green or error message in red
if [ -f /usr/bin/neofetch ]; then
   echo  "\e[92mNeofetch installed successfully\e[0m"
else
   echo  "\e[91mNeofetch failed to install\e[0m"
   echo  "\e[91mPlease install neofetch manually\e[0m"
fi


#install net-tools over nala
echo "\e[92mInstalling net-tools\e[0m"
nala install net-tools -y
#check if net-tools is installed and print success message in green or error message in red
#if [ -f /usr/bin/ifconfig ]; then
#  echo  "\e[92mNet-tools installed successfully\e[0m"
#else
#   echo  "\e[91mNet-tools failed to install\e[0m"
#   echo  "\e[91mPlease install net-tools manually\e[0m"
#fi


#install nano over nala
echo "\e[92mInstalling nano\e[0m"
nala install nano -y
#check if nano is installed and print success message in green or error message in red
if [ -f /usr/bin/nano ]; then
   echo  "\e[92mnano installed successfully\e[0m"
else
   echo  "\e[91mnano failed to install\e[0m"
   echo  "\e[91mPlease install nano manually\e[0m"
   
fi


#install curl over nala
echo "\e[92mInstalling curl\e[0m"
nala install curl -y
#check if curl is installed and print success message in green or error message in red
if [ -f /usr/bin/curl ]; then
   echo  "\e[92mcurl installed successfully\e[0m"
else
   echo  "\e[91mcurl failed to install\e[0m"
   echo  "\e[91mPlease install curl manually\e[0m"
   
fi


#install git over nala
echo "\e[92mInstalling git\e[0m"
nala install git -y
#check if git is installed and print success message in green or error message in red
if [ -f /usr/bin/git ]; then
   echo  "\e[92mGit installed successfully\e[0m"
else
   echo  "\e[91mGit failed to install\e[0m"
   echo  "\e[91mPlease install git manually\e[0m"
   
fi


#installtion of homebrew
#echo "Installing Homebrew"
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#apt-get install build-essential

#install htop over nala
echo "\e[92mInstalling htop\e[0m"
nala install htop -y
#check if htop is installed and print success message or error message


#get the username of the user with the id of 1000
USERNAME=$(cat /etc/passwd | grep 1000 | cut -d: -f1)
#change to the home directory of the user
cd /home/$USERNAME
echo $USERNAME
echo   "\e[92mChanging to home directory of user\e[0m"
#add the following to the .bashrc file
sudo -u $USERNAME echo "PS1='\[\e[0;91m\]Aperture Science Server Shell \n\[\e[0;91m\]├\[\e[0;91m\]SYSTEM:\[\e[0;38;5;202m\]\h \[\e[0;91m\]IP:\[\e[0;38;5;202m\]$(hostname -I) \[\e[0;91m\]USER:\[\e[0;38;5;202m\]\u\n\[\e[0;91m\]├\[\e[0;91m\]DIR:\[\e[0;38;5;199m\]\w\n\[\e[0;91m\]└\[\e[0;97m\]> \[\e[0m\]'" >> .bashrc

#sudo -u $USERNAME brew install gcc
#install btop over brew
#sudo -u $USERNAME brew install btop

#ask the user if they want to install docker and docker-compose over nala
echo "\e[92mDo you want to install docker and docker-compose?\e[0m"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install docker 
    echo "\e[92mInstalling docker\e[0m"
    echo "\e[92mInstalling docker-compose\e[0m"
    curl https://get.docker.com | bash
    #check if docker is installed and print success message in green or error message in red
    if [ -f /usr/bin/docker ]; then
       echo  "\e[92mdocker installed successfully\e[0m"
    else
       echo  "\e[91mdocker failed to install\e[0m"
       echo  "\e[91mPlease install docker manually\e[0m"
    fi
    #check if docker-compose is installed and print success message in green or error message in red
    if [ -f /usr/bin/docker-compose ]; then
       echo  "\e[92mdocker-compose installed successfully\e[0m"
    else
       echo  "\e[91mdocker-compose failed to install\e[0m"
       echo  "\e[91mPlease install docker-compose manually\e[0m"
    fi
fi

#ask the user if they want to install portainer 
echo "\e[92mDo you want to install portainer?\e[0m"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install portainer
    echo "\e[92mInstalling portainer\e[0m"
    docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /media/portainer:/data portainer/portainer-ce:latest
fi

#ask the user if they want to install netdata in a docker container
echo "\e[92mDo you want to install netdata in a docker container? (docker needet)\e[0m"
read -p "y/n: "  
echo    # (optional) move to a new line
#check if docker is installed 
if [[ $REPLY =~ ^[Yy]$ ]]
then
   if [ -f /usr/bin/docker ]; then
       echo  "\e[92mdocker is installed \e[0m"
       #install netdata
         echo "\e[92mInstalling netdata\e[0m"
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
       echo  "\e[91mdocker is not installed\e[0m"
       echo  "\e[91mcan not run netdata as container\e[0m"
    fi   
fi

#get the local ip address of the server and save it in a variable
IP=hostname -I | awk '{print $1}'

#ask the user if they want to install webmin
echo "\e[92mDo you want to install webmin?\e[0m"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install webmin
    echo "\e[92mInstalling webmin\e[0m"
    apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip -y
    wget http://prdownloads.sourceforge.net/webadmin/webmin_2.000_all.deb
    dpkg --install webmin_2.000_all.deb
    rm webmin_2.000_all.deb
    #test if you get a anser for  a webserver on port 10000
      echo "\e[92mTesting if webmin is installed\e[0m"
      if nc -z -w1 localhost 10000; then
         echo  "\e[92mWebmin installed successfully\e[0m"
         echo  "\e[92mWebmin is running on http:// $IP :10000 \e[0m"
               else
         echo  "\e[91mWebmin failed to install\e[0m"
         echo  "\e[91mPlease install webmin manually\e[0m"
      fi
   
fi

#ask the user if they want to install ROS
echo "\e[92mDo you want to install ROS? (ROS-noetic/ ubuntu 22)\e[0m"
read -p "y/n: "  
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    #install ROS
      echo "\e[92mInstalling ROS\e[0m"
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
echo  "\e[32mDone\e[0m"

#remove the pid file
rm /var/run/aperture.pid


