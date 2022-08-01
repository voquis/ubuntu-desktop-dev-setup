Ubuntu Desktop Development Environment Setup
===
Ansible-based utility to set up a new Ubuntu Desktop machine with development and deployment tools. Tested with the following LTS Ubuntu distributions:
- 22.04 (Jammy Jellyfish)

To request an additional tool, please raise a [new issue](https://github.com/voquis/ubuntu-desktop-dev-setup/issues).

## Features

### Version Managers
Version managers are a convenient way of running multiple versions of a runtime or programming language on a single machine.
When working on multiple projects, often a specific version of e.g. Python or NodeJS is required per project.
Version managers dramatically reduce the effort needed to switch between different runtime/language versions.
This deployment includes the following version managers for programming languages:
- [nvm](https://github.com/nvm-sh/nvm) - NodeJS version manager
- [SDKMAN](https://sdkman.io/) - Java and Java ecosystem tooling version manager
- [pyenv](https://github.com/pyenv/pyenv) - Python version manager
- [rbenv](https://github.com/rbenv/rbenv) - Ruby version manager
- [goenv](https://github.com/syndbg/goenv) - Golang version manager
- [phpenv](https://github.com/phpenv/phpenv) - PHP version manager

The following tooling version managers are also installed:
- [tfenv](https://github.com/tfutils/tfenv) - Terraform version manager
- [pkenv](https://github.com/iamhsa/pkenv) - Packer version manager

### Virtualisation
- Virtual machine manager with QEMU/KVM - Run full virtual machines
- Docker and Docker Composer - Run application containers

### Developer tools
The following developer tools are installed:
- Microsoft Visual Studio Code (VSCode) - `code`
- GitHub CLI - `gh`
- Postman - API development utilities

### Cloud and infrastructure management tools
- Google Cloud SDK - `gcloud` CLI tool
- AWS CLI (v2) - `aws` CLI tool
- aws-vault - AWS credential and role switching manager
- Azure CLI - `az` CLI tool
- kubectl - Kubernetes CLI tool
- Terraform (via `tfenv` version manager)
- Packer (via `pkenv` version manager)
- Remmina - Remote desktop access

### Browsers
The following web browsers are installed:
- Brave browser
- Google Chrome

### Communication & Collaboration
The following messaging tools are installed:
- Slack
- Discord
- Microsoft Teams
- Signal Messenger

### Database administration tools
The following database administration (DBA) tools are installed:
- MySQL Workbench
- PostgreSQL pgAdmin

### Security
The following security tools are installed:
- Keybase - Secure communications
- Uncomplicated Firewall (`ufw`)
- ClamAV - Virus scanner

### Productivity
- Libreoffice - document creation
- Gimp - graphical image manipulation
- Inkscape - vector drawing utilities
- Xournal - PDF management
- OBS Studio - Screen recording

## Installation
First Download the `deploy.sh` script locally:

```shell
wget -O deploy.sh https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/main/deploy.sh
```

Then make the downloaded script executable:
```shell
chmod +x deploy.sh
```

Finally, execute the deployment script with:
```shell
./deploy.sh
```

Reboot machine for all changes to take effect.
