#!/bin/bash

#############
#Update Raspberry Pi
#############

echo "--Updating Raspbery Pi--"
sudo apt-get update --fix-missing
sudo apt full-upgrade

echo "--python3 version--"
python3 --version
alias python=python3
echo "--python version--"
python --version

#############
#Install and Updates pip
#############
echo "--Installing and updating pip--"

sudo apt install python3-pip 
echo "--pip Version--"
pip3 --version

# #############
# #Install rmate for remote atom
# #############
echo "--Installing rmate for remote atom--"

sudo curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/rmate
sudo mv /usr/local/bin/rmate /usr/local/bin/ratom

