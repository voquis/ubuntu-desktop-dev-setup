Ubuntu Desktop Development Setup
===
Scripts to set up a new Ubuntu Desktop host with development tools, including IDEs. Tested with 20.04 LTS (Focal).  Tools include:
- IDEs: VSCode, Android Studio
- Virtual environments: Docker, KVM
- Database studio: MySQL Workbench

# Deployment
Run the `deploy.sh` script as privileged user, providing the username for which to apply additional customisations, e.g. Desktop favourites:

```shell
sudo -i
```

Clone the repository to a local path
```shell
git clone https://github.com/voquis/ubuntu-development-setup.git
```

Execute the deployment script providing a `username` to update.
```shell
./ubuntu-development-setup/deploy.sh username
```
