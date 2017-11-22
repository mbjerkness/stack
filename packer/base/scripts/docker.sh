#!/bin/bash
set -e

rm -f /etc/init.d/docker
rm -f /etc/rc*/*docker

# Update the apt package index
apt-get update -y

# Purge any existing
apt-get remove -y docker docker-engine docker.io

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Setup the stable docker repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index to reflect the addition of the docker repository
apt-get update -y

# Install Docker 17.09.0
apt-get install -y docker-ce=17.09.0~ce-0~ubuntu

gpasswd -a ubuntu docker

systemctl daemon-reload
systemctl enable format-var-lib-docker.service
systemctl enable var-lib-docker.mount
systemctl enable docker.service
