#!/bin/bash
echo"Configuring apt sources and updating system"
cp sources.list /etc/apt/sources.list
apt-get update && apt-get upgrade -y

echo"installing ufw and fail2ban"
apt-get install -y ufw fail2ban

echo"Configuring ufw"
ufw allow OpenSSH
ufw enable

echo"Configuring fail2ban"
cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
nano /etc/fail2ban/fail2ban.local
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano /etc/fail2ban/jail.local
service fail2ban restart

echo"Installing wifi drivers and firmware..."
apt-get install -y network-manager firmware-realtek firmware-iwlwifi

echo"Installing xserver and dependencies..."
apt-get install -y xserver-xorg-core xinit x11-xserver-utils

echo"Installing extras for xserver..."
apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable libgl1-mesa-dri mesa-utils

echo"Installing Chromium..."
apt-get install -y chromium
echo"Done installing Chromium."

echo"Setting up autologin..."
sed -i '2 r tty_override.conf' /etc/systemd/system/getty@tty1.service.d/override.conf
echo"Done setting up autologin!"

sleep 2

echo"Creating guest account..."
useradd -m -s /bin/bash guest
passwd guest

echo"Switching to guest account..."
su -c guest

echo"Create .bash_profile on guest directory..."
cp .bash_profile /home/guest

echo"Create .xinitrc on guest directory..."
cp .xinitrc /home/guest

echo"Configure Wifi..."
nmtui
echo"********************************************************************************"
echo"Done...."
echo"********************************************************************************"

exit 0
