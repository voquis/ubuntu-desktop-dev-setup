#!/bin/bash
##############################################################
# Script to provision Ubuntu development machine with:
# - Visual Studio Code
# - Docker
# - Discord
# - Postman
# - MySQL Workbench
# - Android Studio
#
# This script should be run as root and the username should be
# supplied as a parameter:
#
# sudo deploy.sh myuser
##############################################################

# General update of repositories and packages
apt-get update
apt-get upgrade -y

#-------------------------------------------------------------
# Command line tools
#-------------------------------------------------------------
apt-get install -y \
  curl \
  vim \
  git \
  jq

#-------------------------------------------------------------
# VSCode
#-------------------------------------------------------------

# Download and install vscode
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
dpkg -i vscode.deb

#-------------------------------------------------------------
# Discord
#-------------------------------------------------------------

# Install discord dependencies
apt-get install -y \
  libatomic1 \
  libgconf-2-4 \
  libappindicator1 \
  libc++1

# Download and install Discord
wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
dpkg -i discord.deb

#-------------------------------------------------------------
# Docker
#-------------------------------------------------------------

# Install containerd
wget -O containerd.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.3-1_amd64.deb
dpkg -i containerd.deb

# Install docker ce cli
wget -O docker-ce-cli.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.1~3-0~ubuntu-focal_amd64.deb
dpkg -i docker-ce-cli.deb

# Install docker ce and configure service to start on boot
wget -O docker-ce.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.1~3-0~ubuntu-focal_amd64.deb
dpkg -i docker-ce.deb
systemctl enable docker

# Add user to docker users group (effectively root)
usermod -aG docker "$1"

#-------------------------------------------------------------
# Postman
#-------------------------------------------------------------

# Download and extract archive
wget -O postman.tar.gz 'https://dl.pstmn.io/download/latest/linux64'
tar -xf postman.tar.gz
mv Postman /usr/share

# Write new desktop entry with reference to icon, that will
# later be used to add to favourites panel
echo '[Desktop Entry]
Name=Postman
StartupWMClass=Postman
Comment=Postman
GenericName=Postman API Platform
Exec=/usr/share/Postman/Postman
Icon=/usr/share/Postman/app/resources/app/assets/icon.png
Type=Application
Categories=Utility;Development;API;
Keywords=postman;
' > /usr/share/applications/postman.desktop

#-------------------------------------------------------------
# MySQL Workbench
#-------------------------------------------------------------

# Download and install dependencies
apt-get install -y \
  libpcrecpp0v5 \
  libpython2.7 \
  libzip5

# Download and install package
wget -O mysql-workbench.deb 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.22-1ubuntu20.04_amd64.deb'
dpkg -i mysql-workbench.deb


#-------------------------------------------------------------
# Android Studio
#-------------------------------------------------------------

# Download and extract archive
wget -O android-studio.tar.gz 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.3/android-studio-2020.3.1.3-linux.tar.gz'
tar -xf android-studio.tar.gz
mv android-studio /usr/share

# Write new desktop entry with reference to icon, that will
# later be used to add to favourites panel
echo '[Desktop Entry]
Name=Android Studio
StartupWMClass=Android Studio
Comment=Android Studio
GenericName=Android Studio
Exec=/usr/share/android-studio/bin/studio.sh
Icon=/usr/share/android-studio/bin/studio.svg
Type=Application
Categories=Utility;Development;IDE;
Keywords=postman;
' > /usr/share/applications/android-studio.desktop

# Configure virtual machine acceleration for Android emulator
apt-get install -y \
  cpu-checker
# Run the kvm-ok tool and check if KVM acceleration can be used
kvm-ok
is_kvm_ok=$(kvm-ok | grep -c 'KVM acceleration can be used')
if [ "$is_kvm_ok" -eq 1 ]; then
  # Install dependencies
  apt-get install -y \
    qemu \
    qemu-kvm \
    libvirt-daemon \
    libvirt-clients \
    bridge-utils \
    virt-manager

  # Enable on next boot
  systemctl enable libvirtd
fi


#-------------------------------------------------------------
# Configure Desktop favourites panel (as user)
#-------------------------------------------------------------
apps="\"['ubiquity.desktop', 'firefox.desktop', 'code.desktop', 'discord.desktop', 'postman.desktop', 'org.gnome.Terminal.desktop', 'mysql-workbench.desktop', 'android-studio.desktop', 'org.gnome.Nautilus.desktop', 'snap-store_ubuntu-software.desktop', 'yelp.desktop']\""
sudo -H -u "$1" bash -c "dconf write /org/gnome/shell/favorite-apps ${apps}"

#-------------------------------------------------------------
# Restart for gnome changes to take affect
#-------------------------------------------------------------
reboot now
