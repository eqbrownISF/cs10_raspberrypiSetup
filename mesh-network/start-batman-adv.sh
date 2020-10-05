#!/bin/bash
# batman-adv interface to use
sudo batctl if add wlan0
sudo ifconfig bat0 mtu 1468

# Tell batman-adv this s a gateway client
sudo batctl gw_mode client

# Activates batman-adv interface
sudo ifconfig wlan0 up
sudo ifconfig bat0 up
