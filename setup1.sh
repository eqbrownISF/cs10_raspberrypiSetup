#!/bin/bash

#############
#Update Raspberry Pi
#############

echo "--Updating Raspbery Pi--"
sudo apt update
sudo apt full-upgrade

echo "--python3 version--"
python3 -version
alias python = python3
echo "--python version--"
python --version

#############
#Install and Updates pip
#############
echo "--Installing and updating pip--"

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
pip install -U pip
echo "--pip Version--"
pip --version

# #############
# #Install rmate for remote atom
# #############
echo "--Installing rmate for remote atom--"

sudo curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/rmate
sudo mv /usr/local/bin/rmate /usr/local/bin/ratom

