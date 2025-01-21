#!/bin/bash

# Update package lists
sudo apt-get update -y

# Retry update if necessary
if [ $? -ne 0 ]; then
  sudo apt-get update --fix-missing -y
fi

# Install Nginx
sudo apt-get install -y nginx

# Install network-manager (includes nmcli)
sudo apt-get install -y network-manager

# Restart NetworkManager and systemd-networkd if needed
sudo systemctl restart NetworkManager
sudo systemctl restart systemd-networkd

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Create the required directory for the web content
sudo mkdir -p /var/www/html

# Write "Hello World" to the index.html file
echo "Hello World" | sudo tee /var/www/html/index.html

# Check Nginx status
sudo systemctl status nginx

# Check NetworkManager status
sudo systemctl status NetworkManager

# Check systemd-networkd status
sudo systemctl status systemd-networkd

# Check for network issues
journalctl -xe

# Check if there are issues with package installation
sudo apt-get check

# Check Nginx error logs
sudo cat /var/log/nginx/error.log
