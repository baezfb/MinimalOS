#!/bin/bash
cp sources.list /etc/apt/sources.list
apt-get update && apt-get upgrade -y

apt-get install -y ufw fail2ban

ufw allow OpenSSH
ufw enable

cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
nano /etc/fail2ban/fail2ban.local
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano /etc/fail2ban/jail.local
service fail2ban restart

apt-get install -y network-manager firmware-realtek firmware-iwlwifi

apt-get install -y xserver-xorg-core xinit x11-xserver-utils

apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable libgl1-mesa-dri mesa-utils

apt-get install -y chromium

#echo"Setting up autologin..."
#sed -i '2 r tty_override.conf' /etc/systemd/system/getty@tty1.service.d/override.conf
#echo"Done setting up autologin!"

useradd -m -s /bin/bash guest
passwd guest

su -c guest

cp .bash_profile /home/guest

cp .xinitrc /home/guest

nmtui
echo"********************************************************************************"
echo"Done...."
echo"********************************************************************************"

exit 0
