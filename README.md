# MinimalOS

## Description

Debian-based minimal OS for web-based applications.

## Requirements

* Debian-based Linux distribution (net-install)
* xserver
* chromium or firefox browser
* git
* lshw (for hardware information)
* w3m (to view lshw output) optional

## Manual Setup

### Updating debian sources

```bash
sudo nano /etc/apt/sources.list
```

#### Add contrib and non-free

```bash
deb https://deb.debian.org/debian/ bullseye main contrib non-free
deb-src https://deb.debian.org/debian/ bullseye main contrib non-free

deb https://security.debian.org/debian-security bullseye-security main contrib non-free
deb-src https://security.debian.org/debian-security bullseye-security main contrib non-free

deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src https://deb.debian.org/debian/ bullseye-updates main contrib non-free
```

#### Update & Upgrade

```bash
sudo apt-get update && sudo apt-get upgrade
```

#### Install basic packages

```bash
sudo apt-get install -y ufw fail2ban git lshw w3m network-manager firmware-iwlwifi chromium
```

### Core xserver packages

```bash
sudo apt-get install -y xserver-xorg-core xinit x11-xserver-utils
```

#### Use lshw to get hardware information

```bash
sudo lshw > lshw.html
```

#### Look for display drivers needed for hardware( usually somewhere at the beginning of the list)

Example:

```
    *-display UNCLAIMED
             description: VGA compatible controller
             product: Wrestler [Radeon HD 6250]
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 1
             bus info: pci@0000:00:01.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pm pciexpress msi vga_controller bus_master cap_list
             configuration: latency=0
```

* xserver-xorg-video-intel (intel)
* xserver-xorg-video-nouveau (nvidia)
* xserver-xorg-video-openchrome (via)
* xserver-xorg-video-radeon (amd)
* xserver-xorg-video-vesa (generic display driver)

```bash
cat lshw.txt
```

### Input packages

* for mouse and keyboard

```bash
sudo apt-get install xserver-xorg-input-mouse xserver-xorg-input-kbd
```

* for touchpad

```bash
sudo apt-get install xserver-xorg-input-synaptics
```

#### Additional packages (optional but recommended)

```bash
apt-get install xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable libgl1-mesa-dri mesa-utils
```

### Configure xserver

#### Create a guest account

* Create user account
   ```bash
    sudo useradd  -m -s /bin/sh guest
    ```
* Set password
    ```bash
     sudo passwd guest
     ```
* Switch to guest account
    ```bash
     su guest
     ```
* Change into home directory
    ```bash
     cd ~
     ```
* Create .bash_profile
    ```bash
     touch .bash_profile
     ```
    * Add following to .bash_profile ( This will initialize startx on user login on tty1 )
      ```bash
       if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
         startx -- -nocursor
       fi
       ```
* Create a .xinitrc file
    ```bash
     touch .xinitrc
     ```
    * Add following to .xinitrc ( change localhost to your web address)
      ```bash
       #!/bin/sh
       xset -dpms
       xset s off
       xset s noblank
       chromium localhost --window-size=1920,1080 --start-fullscreen --kiosk --incognito --noerrdialogs --disable-translate --no-first-run --fast --fast-start --disable-infobars --disable-features=TranslateUI --disk-cache-dir=/dev/null  --password-store=basic
       ```
* Exit to default user account
    ```bash
     exit
     ```

## Setup autologin

```bash
sudo systemctl edit getty@tty1.service
```

* Add following to [Service] section
  ```bash
  [Service]
  ExecStart=
  ExecStart=-/sbin/agetty --noissue --autologin myusername %I $TERM
  Type=idle
  ```