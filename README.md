# Livepeer-Update-Script

When run the script it will display a menu with two options: 1 to install the latest release, and 2 to install a specific version.
After the file is downloaded a prompt allows the user to enter a SHA-256 checksum if desired or can be bypassed by pressing enter
When the update is complete it will prompt the user to restart the Livepeer service if desired or the user can choose to manually restart the service at a later time.

The script installs the binaries to /usr/local/bin/ by default. If you wish to install the binaries to another directory you can modify the following section:
Move binaries to /usr/local/bin
sudo mv livepeer_linux_amd64/* /usr/local/bin/

The v2 version of the script asks the user if they would like to install the binaries to the default usr/local/bin/ directory or manually enter a directory. 
