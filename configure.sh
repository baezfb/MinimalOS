#!/bin/bash
echo"Configuring sources..."
cp sources.list /etc/apt/sources.list
echo"Done configuring sources."

sleep 2

echo"Updating & Upgrading..."
apt-get update && apt-get upgrade -y
echo"Done updating & upgrading."

sleep 2

echo"Installing ufw and fail2ban"
apt-get install -y ufw fail2ban
echo"Done installing ufw and fail2ban."

sleep 2

echo"Installing wifi drivers and firmware..."
apt-get install -y network-manager firmware-realtek firmware-iwlwifi
echo"Done installing wifi drivers and firmware."

sleep 2

echo"Installing xserver and dependencies..."
apt-get install -y xserver-xorg-core xinit x11-xserver-utils xserver-xorg-video-all xserver-xorg-input-mouse xserver-xorg-input-kbd xserver-xorg-input-synaptics
echo"Done installing xserver and dependencies."

sleep 2

echo"Installing extras for xserver..."
apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable libgl1-mesa-dri mesa-utils
echo "Done installing extras for xserver."

sleep 2

echo"Installing Chromium..."
apt-get install -y chromium
echo"Done installing Chromium."

sleep 2

echo"Setting up firewall..."
ufw allow OpenSSH
ufw enable && ufw status
echo"Done setting up firewall!"

sleep 2

echo"Setting up autologin..."
sed -i '2 r tty_override.conf' /etc/systemd/system/getty@tty1.service.d/override.conf
echo"Done setting up autologin!"

sleep 2

echo"Creating guest account..."
useradd -m -s /bin/bash guest
passwd guest
echo"Done creating guest account!"

sleep 2

echo"Switching to guest account..."
su -c guest
echo"Done switching to guest account!"

sleep 2

echo"Create .bash_profile on guest directory..."
cp .bash_profile /home/guest
echo"Done creating .bash_profile on guest directory!"

sleep 2

echo"Create .xinitrc on guest directory..."
cp .xinitrc /home/guest
echo"Done creating .xinitrc on guest directory!"

sleep 2

echo"Configure Wifi..."
nmtui
echo"Done configuring Wifi!"
echo"********************************************************************************"
echo"Done...."
echo"********************************************************************************"

sleep 2

exit 0
