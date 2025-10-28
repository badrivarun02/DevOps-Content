#!/bin/bash

echo " Starting Docker installation..."

# Step 1: Install prerequisites
echo " Installing required packages..."
sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

# Step 2: Create keyring directory and GPG key
echo " Setting up Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor > /tmp/docker.gpg && \
  sudo mv /tmp/docker.gpg /etc/apt/keyrings/docker.gpg

# Step 3: Add Docker repository
UBUNTU_CODENAME=$(lsb_release -cs)
ARCH=$(dpkg --print-architecture)
echo "Adding Docker repository for $UBUNTU_CODENAME..."
echo \
  "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 4: Update and install Docker
echo " Updating apt and installing Docker..."
sudo apt update

# Try installing Docker CE packages
if apt-cache policy docker-ce | grep -q "Candidate:"; then
  sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
else
  echo " Docker CE not available for $UBUNTU_CODENAME — falling back to docker.io..."
  sudo apt install -y docker.io
fi

# Step 5: Enable and start Docker service
echo " Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Step 6: Add current user to docker group
echo " Adding user '$USER' to docker group..."
sudo usermod -aG docker "$USER"

echo " Docker installation complete. Please log out and back in or run 'newgrp docker' to activate group membership."

