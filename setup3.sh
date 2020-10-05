#!/bin/bash

############################################
# Setup Mesh Network/Autohotspot Switching #
############################################


echo "-- Installing Batman CTL --"
sudo apt-get install -y batctl

echo "-- Setting up batman-adv mesh networking --"
mkdir -p ~/bin
sudo curl -o ~/bin/wlan0.mesh https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/wlan0.mesh
sudo curl -o ~/bin/setup-mesh-network.sh https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-mesh-network.sh
sudo curl -o ~/bin/start-batman-adv.sh https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/start-batman-adv.sh
chmod +x start-batman.sh
sudo curl -o /etc/bat-hosts https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/bat-hosts

echo "-- Setting up hotspot switching service --"
sudo curl -o /etc/systemd/system/setup-hotspot-switching.service https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-hotspot-switching.service
sudo curl -o /usr/bin/setup-hotspot-switching https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-hotspot-switching
sudo systemctl enable setup-hotspot-switching.service


