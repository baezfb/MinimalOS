#!/bin/bash
echo"Configuring sources..."
cp sources.list /etc/apt/sources.list
echo"Updating sources..."
apt-get update && apt-get upgrade -y
echo"Installing dependencies..."
apt-get install -y ufw fail2ban git lshw w3m network-manager firmware-iwlwifi chromium xserver-xorg-core xinit x11-xserver-utils xserver-xorg-video-all xserver-xorg-input-mouse xserver-xorg-input-kbd xserver-xorg-input-synaptics xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable libgl1-mesa-dri mesa-utils
echo"Dependencies installed..."
echo"Setting up firewall..."
ufw allow OpenSSH
ufw enable && ufw status
echo"Firewall enabled..."
echo"********************************************************************************"
echo"Creating user..."
useradd -m -s /bin/bash guest
echo"Set password for guest account..."
passwd guest
echo"Switching to guest account..."
su -c guest
echo"Create .bash_profile on guest directory..."
cp .bash_profile /home/guest
echo"Create .xinitrc on guest directory..."
cp .xinitrc /home/guest
exit 0
