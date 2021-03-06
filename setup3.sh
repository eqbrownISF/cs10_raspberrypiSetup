#!/bin/bash

############################################
# Setup Mesh Network/Autohotspot Switching #
############################################


echo "-- Installing Batman CTL --"
sudo apt-get install -y batctl

echo "-- Installing Alfred --"
sudo apt-get install -y alfred

echo "-- Setting up batman-adv mesh networking --"
crontab -r
sudo curl -o /etc/network/interfaces.d/wlan0.mesh https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/wlan0.mesh
sudo curl -o /usr/local/bin/setup-mesh-network https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-mesh-network.sh
sudo chmod +x /usr/local/bin/setup-mesh-network
sudo curl -o /usr/local/bin/start-batman-adv https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/start-batman-adv.sh
sudo chmod +x /usr/local/bin/start-batman-adv
sudo curl -o /etc/bat-hosts https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/bat-hosts

echo "-- Setting up hotspot switching service --"
sudo curl -o /etc/systemd/system/setup-hotspot-switching.service https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-hotspot-switching.service
sudo curl -o /usr/bin/setup-hotspot-switching https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/mesh-network/setup-hotspot-switching
sudo chmod +x /usr/bin/setup-hotspot-switching
sudo systemctl enable setup-hotspot-switching.service


