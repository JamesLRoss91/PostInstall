#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# xorg display server installation
sudo apt install -y xorg 

# Python pip
sudo apt install -y python3-pip 

# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -y intel-microcode 

# Network Manager
sudo apt install -y network-manager-gnome

# Installation for Appearance management
sudo apt install -y lxappearance 

# File Manager (eg. pcmanfm,krusader)
sudo apt install -y thunar xfce4-settings ranger

# Terminal
sudo apt install -y kitty

# Sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Neofetch/HTOP
sudo apt install -y neofetch htop

# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
sudo apt install -y exa

# Printing and bluetooth (if needed)
sudo apt install -y cups
sudo apt install -y bluez blueman

sudo systemctl enable bluetooth
sudo systemctl enable cups

# Browser Installation (eg. chromium)
sudo apt install -y firefox-esr 

# Desktop background browser/handler 
sudo apt install -y nitrogen

# ------- Setup and install regolith ----------

# Register the Regolith public key to your local apt
wget -qO - https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

# Add the repository URL to your local apt
echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-debian-bullseye-amd64 bullseye main" | \
sudo tee /etc/apt/sources.list.d/regolith.list

# Update apt
sudo apt update
sudo apt install regolith-desktop regolith-compositor-picom-glx
sudo apt install regolith-look-*

#---------- END SETUP ----------

# Extra quality of life packages
sudo apt install -y dmenu rofi unzip geany

# Command line text editor
sudo apt install -y neovim

# Install fonts
sudo apt install fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus fonts-cascadia-code

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Dependencies for Ly Console Manager
sudo apt install -y libpam0g-dev libxcb-xkb-dev

# Install Ly Console Display Manager
cd 
cd Downloads
git clone --recurse-submodules https://github.com/nullgemm/ly.git
cd ly/
make
sudo make install
sudo systemctl enable ly

# XSessions and i3.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

#cat > ./temp << "EOF"
#[Desktop Entry]
#Encoding=UTF-8
#Name=i3
#Comment=Dynamic window manager
#Exec=i3
#Icon=i3
#Type=XSession
#EOF
#sudo cp ./temp /usr/share/xsessions/i3.desktop;rm ./temp

########################################################
# End of script for default config
#

## These two scripts will install nerdfonts and copy my configuration files into the ~/.config directory
## Configuration uses 

source ~/i3gaps-debian/nerdfonts.sh
#source ~/i3gaps-debian/copyconf.sh

sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
