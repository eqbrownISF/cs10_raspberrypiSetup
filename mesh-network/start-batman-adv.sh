#!/bin/bash

# batman-adv interface to use
sudo batctl if add wlan0
sudo ifconfig bat0 mtu 1468

# Tell batman-adv this s a gateway client
sudo batctl gw_mode client

# Activates batman-adv interface
sudo ifconfig wlan0 up
sudo ifconfig bat0 up

# Find wlan0 MAC address
IFACE=wlan0
read MAC < /sys/class/net/$IFACE/address

# Add one to MAC address
IFS=":"; set $MAC; unset IFS
LAST_NUM="$(printf %02x $((0x$6+0x1)))"
BAT_MAC="$1:$2:$3:$4:$5:$LAST_NUM"

# Convert MAC address to IPc6 address
IFS=":"; set $BAT_MAC; unset IFS
IPV6_ADDR="fe80::$(printf %02x $((0x$1 ^ 2)))$2:${3}ff:fe$4:$5$6"

#set bat0 mac address as wlan0 mac address plus one
sudo ip link set bat0 address $BAT_MAC

# set IPv6 link-local address
sudo ip -6 addr add $IPV6_ADDR/64 dev bat0
