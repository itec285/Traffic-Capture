#!/bin/bash

# Kali Linux 2016.2 mitmf helper
# Feb 13 2017

# This script automates the process of installing mitmf and mimtf lib and then
# automatically fixing an issue with the Twister library.

# Install the necessary software

apt-get update
apt install mitmf mitmflib

#Remove the new, broken Twisted app, and install the old version that works.  
#    See https://github.com/byt3bl33d3r/MITMf/issues/294
cd /usr/lib/python2.7/dist-packages
rm -rf twisted/
rm -rf Twisted-16.3.0.egg-info/

cd /usr/share/mitmf
wget http://twistedmatrix.com/Releases/Twisted/15.5/Twisted-15.5.0.tar.bz2
pip install ./Twisted-15.5.0.tar.bz2
