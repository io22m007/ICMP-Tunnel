#!/bin/bash

cd hans

# insert the network ip of the /24 network to be used by the tun interfaces into the following line:
sudo ./hans -s <network_ip> -p <password>

sudo sysctl net.ipv4.ip_forward net.ipv4.ip_forward=1

sudo iptables -A FORWARD -i tun0 -o eth0 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE