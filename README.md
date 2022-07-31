Ubuntu Desktop Development Environment Setup
===
Scripts to set up a new Ubuntu Desktop host with development and deployment tools. Tested with the following LTS Ubuntu distributions:
- 22.04 (Jammy)

# Deployment
Run the `deploy.sh` script:

## Without git
```shell
# Download the script locally:
wget -O deploy.sh https://raw.githubusercontent.com/voquis/ubuntu-desktop-dev-setup/deploy.sh
# Make the script executable with:
chmod +x deploy.sh
# Execute the deployment script:
./deploy.sh
```

## Using git
Clone the repository to a local path
```shell
git clone https://github.com/voquis/ubuntu-desktop-dev-setup.git
```

```shell
./ubuntu-desktop-dev-setup/deploy.sh
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
