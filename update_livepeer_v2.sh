#!/bin/bash

# Prompt user to choose between latest release or specific version
echo "Choose an option:"
echo "1) Install latest release"
echo "2) Install a specific version"
read choice

if [ $choice == "1" ]; then
  # Download latest release
  download_url=$(curl -s https://api.github.com/repos/livepeer/go-livepeer/releases/latest | grep "browser_download_url.*linux-amd64.tar.gz" | cut -d '"' -f 4)
else
  # Prompt user to input version
  echo "Enter the version you would like to install (e.g. v0.5.38):"
  read version

  # Construct download URL for specific version
  download_url="https://github.com/livepeer/go-livepeer/releases/download/$version/livepeer-linux-amd64.tar.gz"
fi

# Download release
wget $download_url

# Prompt user to enter SHA-256 checksum for verification
echo "Enter SHA-256 checksum for the downloaded file, or press Enter to bypass the check:"
read checksum

if [ -n "$checksum" ]; then
  # Verify SHA-256 checksum
  computed_checksum=$(sha256sum livepeer-linux-amd64.tar.gz | awk '{print $1}')
  if [ "$checksum" != "$computed_checksum" ]; then
    echo "Checksum verification failed. Aborting installation."
    exit 1
  fi
fi

# Extract archive
sudo tar -zxvf livepeer-linux-amd64.tar.gz

# Remove archive
sudo rm livepeer-linux-amd64.tar.gz

# Prompt user to enter a destination directory
echo "Enter the destination directory for the Livepeer binaries, or press Enter to use /usr/local/bin:"
read destination

if [ -z "$destination" ]; then
  # Move binaries to /usr/local/bin by default
  sudo mv livepeer_linux_amd64/* /usr/local/bin/
else
  # Move binaries to user-specified directory
  sudo mv livepeer_linux_amd64/* $destination
fi

# Prompt user to restart Livepeer service
echo "Would you like to restart the Livepeer service now? (y/n)"
read restart_service

if [[ $restart_service =~ ^[Yy]$ ]]; then
  sudo systemctl daemon-reload
  sudo systemctl enable --now livepeer
  sudo systemctl restart livepeer.service
fi
