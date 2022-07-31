#!/bin/bash
##############################################################
# Script to provision Ubuntu development machine using Ansible
##############################################################

set -euo pipefail

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y ansible

# Save ansible playbook from this repo to local path
wget -O playbook.yaml https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/main/playbook.yaml

# Run ansible playbook
ansible-playbook playbook.yaml --ask-become-pass

# Remove playbook once completed
rm playbook.yaml
