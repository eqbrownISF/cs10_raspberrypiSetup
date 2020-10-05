#!/bin/bash
# batman-adv interface to use
sudo batctl if add wlan0
sudo ifconfig bat0 mtu 1468

# Tell batman-adv this s a gateway client
sudo batctl gw_mode client

# Activates batman-adv interface
sudo ifconfig wlan0 up
sudo ifconfig bat0 up

#set bat0 mac address as wlan0 mac address plus one
sudo ip link set bat0 address b8:27:eb:8d:b4:1a

# set IPv6 link-local address
sudo ip -6 addr add fe80::ba27:ebff:fe8d:b41a/64 dev bat0
