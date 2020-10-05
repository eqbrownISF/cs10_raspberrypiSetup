#!/bin/bash
# Add mesh network interface config
WLAN=/etc/network/interfaces.d/wlan0
if test -f "$WLAN"
then
	if ! grep -Fxq "rpi-mesh" "$WLAN" 
	then
		sudo cp /etc/network/interfaces.d/wlan0 /etc/network/interfaces.d/wlan0.backup
		sudo cp /etc/network/interfaces.d/wlan0.mesh /etc/network/interfaces.d/wlan0
	fi
else
	sudo cp $HOME/bin/wlan0.mesh /etc/network/interfaces.d/wlan0
fi

# Stop DHCPCD from managing interfaces
if ! grep -Fxq "denyinterfaces wlan0 eth0 bat0" /etc/dhcpcd.conf
then
	echo "denyinterfaces wlan0 eth0 bat0" >> /etc/dhcpcd.conf
fi


# Remove hotspot switching crontab task scheduling
sudo crontab -l > mycron
sed -i "/^# Automating hotspot switching for cs10/d" mycron
sed -i "/^.*autohotspotN.*/d" mycron
sudo crontab mycron
rm mycron

# Reset wlan0 interface
sudo wpa_cli terminate wlan0
sudo ifdown wlan0
sudo ifup wlan0

# Restart dhcpcd to apply interface denial
#sudo systemctl daemon-reload
#sudo systemctl restart dhcpcd

# Start batman adv interfaces
$HOME/bin/start-batman-adv.sh
