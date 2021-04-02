Ubuntu Desktop Development Environment Setup
===
Scripts to set up a new Ubuntu Desktop host with development and deployment tools. Tested with 20.04 LTS (Focal).

Development tools include:
- IDEs: VSCode, Android Studio
- Virtual environments: Docker, KVM
- Database studio: MySQL Workbench

Development environments include:
- Java/Scala/Groovy/other JVM tooling ([sdkman](https://sdkman.io))
- Python ([pyenv](https://github.com/pyenv/pyenv))
- NodeJS ([nvm](https://github.com/nvm-sh/nvm))
- Ruby ([rbenv](https://github.com/rbenv/rbenv))

Deployment tools
- Terraform ([tfenv](https://github.com/tfutils/tfenv))
- Packer ([pkenv](https://github.com/iamhsa/pkenv))

# Deployment
Run the `deploy.sh` script as privileged user, providing the username for which to apply additional customisations, e.g. Desktop favourites:

```shell
sudo -i
```

## Without git
Download the script locally:
```shell
wget -O deploy.sh https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/main/deploy.sh
```

Make the script executable with:
```shell
chmod +x deploy.sh
```

Execute the deployment script providing a `username` to update.
```shell
./deploy.sh username
```

## Using git
Clone the repository to a local path
```shell
git clone https://github.com/voquis/ubuntu-desktop-dev-setup.git
```

Execute the deployment script providing a `username` to update.
```shell
./ubuntu-desktop-dev-setup/deploy.sh username
```

# Testing
To run code standard checks, use shellcheck.
## Shellcheck in Docker
```
docker run --rm \
-v $(pwd)/deploy.sh:/deploy.sh \
koalaman/shellcheck-alpine \
shellcheck /deploy.sh
```
