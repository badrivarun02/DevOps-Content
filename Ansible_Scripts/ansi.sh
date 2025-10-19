#!/bin/bash
set -e  # Exit on error

# Ensure required tools are present
sudo apt update
sudo apt install -y software-properties-common python3-pip libssl-dev

# Add Ansible PPA and install
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
