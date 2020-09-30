#!/bin/bash

echo "--Installing Python3.8 files--"
cd Python-3.8.0
sudo ./configure --enable-optimizations
sudo make -j 4
sudo make altinstall
echo "--Python3.8 Version--"
python3.8 --version
alias python=python3.8
echo "--Python Version--"
python --version
