#!/bin/bash

cd hans

# insert the server ip address and the password into the following line:
sudo ./hans -c <ip_over_icmp_server_ip> -p <password>
sleep 2

# insert the server ip address and the gateway ip address which should be used to reach the server into the following line:
sudo route add -host <ip_over_icmp_server_ip> gw <gateway_ip_for_internet_connection>
sleep 2

# insert the servers' tun interface ip address into the following line:
sudo route add default gw <ip_of_server_tun_interface>
sleep 2

# insert the current gateway ip address into (the same gateway ip address which should be used to reach the server) the following line:
sudo route del default gw <gateway_ip_for_internet_connection>