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

set -euo pipefail

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

# Fetch default settings
wget -O settings.json 'https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/main/vscode/settings.json'
chown "$1":"$1" settings.json
mkdir -p "/home/$1/.config/Code/User"
mv settings.json "/home/$1/.config/Code/User"

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

# Install Docker compose for managing multiple dependent containers
curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64
chmod +x /usr/local/bin/docker-compose

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
Keywords=android;
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
# Inkscape
#-------------------------------------------------------------
apt-get install -y inkscape

# Write new desktop entry with reference to icon, that will
# later be used to add to favourites panel
echo '[Desktop Entry]
Name=Inkscape
StartupWMClass=Inkscape
Comment=Inkscape
GenericName=Inkscape
Exec=/usr/bin/inkscape
Icon=/usr/share/inkscape/icons/inkscape.svg
Type=Application
Categories=Utility;Development;
Keywords=Inkscape;
' > /usr/share/applications/inkscape.desktop

#-------------------------------------------------------------
# NodeJS Version Manager (nvm)
# https://github.com/nvm-sh/nvm
#-------------------------------------------------------------
git clone --branch v0.38.0 https://github.com/nvm-sh/nvm.git /usr/share/nvm
# Add to system wide bashrc for all users
tee -a /etc/bash.bashrc <<- \EOF
# Node Version Manager
export NVM_DIR="$HOME/.nvm"
. /usr/share/nvm/nvm.sh

EOF

#-------------------------------------------------------------
# Python version manager (pyenv)
# https://github.com/pyenv/pyenv
#-------------------------------------------------------------

# Install python build dependencies
apt-get install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncurses5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev

# Install pyenv
git clone https://github.com/pyenv/pyenv /usr/share/pyenv
cd /usr/share/pyenv || { echo "Error changing directory"; exit 1; }
src/configure
make -C src
cd - || { echo "Error returning to previous directory"; exit 1; }
# Add to system wide bashrc for all users
tee -a /etc/bash.bashrc <<- \EOF
# Pyenv Python version manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:/usr/share/pyenv/bin
eval "$(pyenv init -)"
. /usr/share/pyenv/completions/pyenv.bash

EOF

#-------------------------------------------------------------
# Ruby version manager (rbenv) with ruby builder
# https://github.com/rbenv/rbenv
#-------------------------------------------------------------

# Install rbenv
git clone https://github.com/rbenv/rbenv /usr/share/rbenv
# Add to system wide bashrc for all users
tee -a /etc/bash.bashrc <<- \EOF
# Rbenv Ruby version manager
export RBENV_ROOT="$HOME/.rbenv"
export PATH=$PATH:/usr/share/rbenv/bin
eval "$(rbenv init -)"
. /usr/share/rbenv/completions/rbenv.bash

EOF

# Add Ruby builder plugin for installing ruby versions
git clone https://github.com/rbenv/ruby-build.git /usr/share/ruby-build
chmod +x /usr/share/ruby-build/bin/*
# Add to system wide bashrc for all users
tee -a /etc/bash.bashrc <<- \EOF
# Rbenv Ruby version builder
export PATH=$PATH:/usr/share/ruby-build/bin

EOF

#-------------------------------------------------------------
# Keybase for GPG key verification
# https://keybase.io
#-------------------------------------------------------------
wget -O keybase.deb 'https://prerelease.keybase.io/keybase_amd64.deb'
dpkg -i keybase.deb

#-------------------------------------------------------------
# Terraform version manager (tfenv)
# https://github.com/tfutils/tfenv
#-------------------------------------------------------------
git clone https://github.com/tfutils/tfenv.git /usr/share/tfenv
# Add to system wide bashrc for all users
# Create symlink to bins because tfenv downloads to bin directory
tee -a /etc/bash.bashrc <<- \EOF
# TFenv Terraform version builder
export TFENV_ROOT="$HOME/.tfenv"
mkdir -p "$TFENV_ROOT"
export PATH=$PATH:$TFENV_ROOT/bin
ln -sf /usr/share/tfenv/* $TFENV_ROOT
eval "$(tfenv init -)"

EOF

#-------------------------------------------------------------
# Google Chrome
#-------------------------------------------------------------
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i chrome.deb

# Write new desktop entry with reference to icon, that will
# later be used to add to favourites panel
echo '[Desktop Entry]
Version=1.0
Name=Google Chrome
GenericName=Web Browser
Comment=Access the Internet
Exec=/usr/bin/google-chrome-stable %U
StartupNotify=true
Terminal=false
Icon=google-chrome
Type=Application
Categories=Network;WebBrowser;
MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/ftp;x-scheme-handler/http;x-scheme-handler/https;
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=New Window
Exec=/usr/bin/google-chrome-stable

[Desktop Action new-private-window]
Name=New Incognito Window
Exec=/usr/bin/google-chrome-stable --incognito
' > /usr/share/applications/google-chrome.desktop

#-------------------------------------------------------------
# Configure Desktop favourites panel (as user)
#-------------------------------------------------------------
apps="\"['ubiquity.desktop', 'firefox.desktop', 'google-chrome.desktop', 'code.desktop', 'discord.desktop', 'postman.desktop', 'org.gnome.Terminal.desktop', 'mysql-workbench.desktop', 'android-studio.desktop', 'inkscape.desktop', 'org.gnome.Nautilus.desktop', 'snap-store_ubuntu-software.desktop', 'yelp.desktop']\""
sudo -H -u "$1" bash -c "dconf write /org/gnome/shell/favorite-apps ${apps}"

#-------------------------------------------------------------
# Restart for gnome changes to take affect
#-------------------------------------------------------------
reboot now
