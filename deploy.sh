#!/bin/bash
##############################################################
# Script to provision Ubuntu development machine using Ansible
##############################################################

set -euo pipefail

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y ansible

# Save ansible playbook from this repo to local path
wget -O playbook.yaml https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/19-use-ansible/playbook.yaml

# Run ansible playbook
ansible-playbook playbook.yaml

# Remove playbook once completed
rm playbook.yaml

# # Fetch default settings
# wget -O settings.json 'https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/main/vscode/settings.json'
# mkdir -p "/home/$1/.config/Code/User"
# mv settings.json "/home/$1/.config/Code/User"
# chown -R "$1":"$1" "/home/$1/.config/Code"

# #-------------------------------------------------------------
# # Postman
# #-------------------------------------------------------------

# # Write new desktop entry with reference to icon, that will
# # later be used to add to favourites panel
# echo '[Desktop Entry]
# Name=Postman
# StartupWMClass=Postman
# Comment=Postman
# GenericName=Postman API Platform
# Exec=/usr/share/Postman/Postman
# Icon=/usr/share/Postman/app/resources/app/assets/icon.png
# Type=Application
# Categories=Utility;Development;API;
# Keywords=postman;
# ' > /usr/share/applications/postman.desktop

# #-------------------------------------------------------------
# # Android Studio
# #-------------------------------------------------------------

# # Download and extract archive
# wget -O android-studio.tar.gz 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.3/android-studio-2020.3.1.3-linux.tar.gz'
# tar -xf android-studio.tar.gz
# mv android-studio /usr/share

# # Write new desktop entry with reference to icon, that will
# # later be used to add to favourites panel
# echo '[Desktop Entry]
# Name=Android Studio
# StartupWMClass=Android Studio
# Comment=Android Studio
# GenericName=Android Studio
# Exec=/usr/share/android-studio/bin/studio.sh
# Icon=/usr/share/android-studio/bin/studio.svg
# Type=Application
# Categories=Utility;Development;IDE;
# Keywords=android;
# ' > /usr/share/applications/android-studio.desktop

# #-------------------------------------------------------------
# # AWS CLI
# #-------------------------------------------------------------

# # Download archive from URL
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# # Unzip the installer
# unzip awscliv2.zip
# # Run the install program
# ./aws/install
# # Remove the archive
# rm -rf awscliv2.zip
# # Create aws directory
# mkdir /home/"$1"/.aws
# # Create config file
# touch /home/"$1"/.aws/config

# #-------------------------------------------------------------
# # AWS Vault for managing multiple profiles
# # https://github.com/99designs/aws-vault
# #-------------------------------------------------------------

# wget -O /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v6.4.0/aws-vault-linux-amd64
# chmod +x /usr/local/bin/aws-vault

# # Write new desktop entry with reference to icon, that will
# # later be used to add to favourites panel
# echo '[Desktop Entry]
# Name=Inkscape
# StartupWMClass=Inkscape
# Comment=Inkscape
# GenericName=Inkscape
# Exec=/usr/bin/inkscape
# Icon=/usr/share/inkscape/icons/inkscape.svg
# Type=Application
# Categories=Utility;Development;
# Keywords=Inkscape;
# ' > /usr/share/applications/inkscape.desktop

# # Write new desktop entry with reference to icon, that will
# # later be used to add to favourites panel
# echo '[Desktop Entry]
# Version=1.0
# Name=Google Chrome
# GenericName=Web Browser
# Comment=Access the Internet
# Exec=/usr/bin/google-chrome-stable %U
# StartupNotify=true
# Terminal=false
# Icon=google-chrome
# Type=Application
# Categories=Network;WebBrowser;
# MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/ftp;x-scheme-handler/http;x-scheme-handler/https;
# Actions=new-window;new-private-window;

# [Desktop Action new-window]
# Name=New Window
# Exec=/usr/bin/google-chrome-stable

# [Desktop Action new-private-window]
# Name=New Incognito Window
# Exec=/usr/bin/google-chrome-stable --incognito
# ' > /usr/share/applications/google-chrome.desktop

# # Write new desktop entry with reference to icon, that will
# # later be used to add to favourites panel
# echo '[Desktop Entry]
# Version=1.0
# Name=Brave Web Browser
# GenericName=Web Browser
# Comment=Access the Internet
# Exec=/usr/bin/brave-browser-stable %U
# StartupNotify=true
# Terminal=false
# Icon=brave-browser
# Type=Application
# Categories=Network;WebBrowser;
# MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ipfs;x-scheme-handler/ipns;
# Actions=new-window;new-private-window;

# [Desktop Action new-window]
# Name=New Window
# Exec=/usr/bin/brave-browser-stable

# [Desktop Action new-private-window]
# Name=New Incognito Window
# Exec=/usr/bin/brave-browser-stable --incognito
# ' > /usr/share/applications/brave-browser.desktop

# #-------------------------------------------------------------
# # Oh My Bash
# # https://github.com/ohmybash/oh-my-bash
# #-------------------------------------------------------------
# git clone git://github.com/ohmybash/oh-my-bash.git /usr/share/oh-my-bash
# tee -a /etc/bash.bashrc <<- \EOF
# # Oh My Bash
# /usr/share/oh-my-bash/tools/install.sh > /dev/null

# EOF

# #-------------------------------------------------------------
# # NodeJS Version Manager (nvm)
# # https://github.com/nvm-sh/nvm
# #-------------------------------------------------------------
# git clone --branch v0.38.0 https://github.com/nvm-sh/nvm.git /usr/share/nvm
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # Node Version Manager
# export NVM_DIR="$HOME/.nvm"
# . /usr/share/nvm/nvm.sh

# EOF

# #-------------------------------------------------------------
# # Python version manager (pyenv)
# # https://github.com/pyenv/pyenv
# #-------------------------------------------------------------

# # Install python build dependencies
# apt-get install -y \
#         build-essential \
#         libssl-dev \
#         zlib1g-dev \
#         libbz2-dev \
#         libreadline-dev \
#         libsqlite3-dev \
#         llvm \
#         libncurses5-dev \
#         xz-utils \
#         tk-dev \
#         libxml2-dev \
#         libxmlsec1-dev \
#         libffi-dev \
#         liblzma-dev

# # Install pyenv
# git clone https://github.com/pyenv/pyenv /usr/share/pyenv
# cd /usr/share/pyenv || { echo "Error changing directory"; exit 1; }
# src/configure
# make -C src
# cd - || { echo "Error returning to previous directory"; exit 1; }
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # Pyenv Python version manager
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH=$PATH:/usr/share/pyenv/bin
# eval "$(pyenv init -)"
# . /usr/share/pyenv/completions/pyenv.bash

# EOF

# #-------------------------------------------------------------
# # Ruby version manager (rbenv) with ruby builder
# # https://github.com/rbenv/rbenv
# #-------------------------------------------------------------

# # Install rbenv
# git clone https://github.com/rbenv/rbenv /usr/share/rbenv
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # Rbenv Ruby version manager
# export RBENV_ROOT="$HOME/.rbenv"
# export PATH=$PATH:/usr/share/rbenv/bin
# eval "$(rbenv init -)"
# . /usr/share/rbenv/completions/rbenv.bash

# EOF

# # Add Ruby builder plugin for installing ruby versions
# git clone https://github.com/rbenv/ruby-build.git /usr/share/ruby-build
# chmod +x /usr/share/ruby-build/bin/*
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # Rbenv Ruby version builder
# export PATH=$PATH:/usr/share/ruby-build/bin

# EOF

# #-------------------------------------------------------------
# # PHP version manager (phpenv) with version builder
# # https://github.com/phpenv/phpenv
# #-------------------------------------------------------------

# # Install dependencies for php extensions
# apt-get install -y \
#   autoconf \
#   libcurl4-openssl-dev \
#   libjpeg-dev \
#   libonig-dev \
#   libtidy-dev \
#   libzip-dev

# # Install phpenv
# git clone https://github.com/phpenv/phpenv /usr/share/phpenv
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # phpenv PHP version manager
# export PHPENV_ROOT="$HOME/.phpenv"
# export PATH=$PATH:/usr/share/phpenv/bin
# eval "$(phpenv init -)"
# . /usr/share/phpenv/completions/phpenv.bash

# EOF

# # Add PHP builder plugin for installing PHP versions
# git clone https://github.com/php-build/php-build.git /usr/share/php-build
# chmod +x /usr/share/php-build/bin/*
# # Add to system wide bashrc for all users
# tee -a /etc/bash.bashrc <<- \EOF
# # PHP version builder
# export PATH=$PATH:/usr/share/php-build/bin

# EOF

# #-------------------------------------------------------------
# # Terraform version manager (tfenv)
# # https://github.com/tfutils/tfenv
# #-------------------------------------------------------------
# git clone https://github.com/tfutils/tfenv.git /usr/share/tfenv
# # Add to system wide bashrc for all users
# # Create symlink to bins because tfenv downloads to bin directory
# tee -a /etc/bash.bashrc <<- \EOF
# # TFenv Terraform version manager
# export TFENV_ROOT="$HOME/.tfenv"
# mkdir -p "$TFENV_ROOT"
# export PATH=$PATH:$TFENV_ROOT/bin
# ln -sf /usr/share/tfenv/* $TFENV_ROOT
# eval "$(tfenv init -)"

# EOF

# #-------------------------------------------------------------
# # Packer version manager (pkenv)
# # https://github.com/iamhsa/pkenv
# #-------------------------------------------------------------
# git clone https://github.com/iamhsa/pkenv.git /usr/share/pkenv
# # Add to system wide bashrc for all users
# # Create symlink to bins because pkenv downloads to bin directory
# tee -a /etc/bash.bashrc <<- \EOF
# # PKenv Packer version manager
# export PKENV_ROOT="$HOME/.pkenv"
# mkdir -p "$PKENV_ROOT"
# export PATH=$PATH:$PKENV_ROOT/bin
# ln -sf /usr/share/pkenv/* $PKENV_ROOT

# EOF

# #-------------------------------------------------------------
# # SDKman for Java/JVM tooling version management
# # https://sdkman.io
# #-------------------------------------------------------------
# wget -O /usr/share/sdkman "https://get.sdkman.io"
# chmod +x /usr/share/sdkman
# tee -a /etc/bash.bashrc <<- \EOF
# # SDKMan version manager
# /usr/share/sdkman > /dev/null
# chmod +x $HOME/.sdkman/bin/sdkman-init.sh
# $HOME/.sdkman/bin/sdkman-init.sh

# EOF

# #-------------------------------------------------------------
# # Uncomplicated firewall (UFW) and the associated GUI
# #-------------------------------------------------------------
# ufw enable

# #-------------------------------------------------------------
# # Configure Desktop favourites panel (as user)
# #-------------------------------------------------------------
# apps="\"['ubiquity.desktop', 'firefox.desktop', 'google-chrome.desktop', 'brave-browser.desktop', 'code.desktop', 'discord.desktop', 'postman.desktop', 'org.gnome.Terminal.desktop', 'mysql-workbench.desktop', 'android-studio.desktop', 'inkscape.desktop', 'org.gnome.Nautilus.desktop', 'snap-store_ubuntu-software.desktop', 'yelp.desktop']\""
# sudo -H -u "$1" bash -c "dconf write /org/gnome/shell/favorite-apps ${apps}"

# #-------------------------------------------------------------
# # Restart for gnome changes to take affect
# #-------------------------------------------------------------
# reboot now
