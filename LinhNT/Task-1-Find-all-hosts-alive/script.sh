#!/bin/bash

read -p "Enter a net ip: " ip
for ip in $(seq 1 254);
do
	ping -c 1 -i 0.2 192.168.76.$ip>/dev/null; 
	if [ $? -eq 0 ]; then 
		echo "====> 192.168.76.$ip UP";
		sudo nmap -O 192.168.76.$ip | ((grep "Linux" || grep "Window" || echo "unknown") | head -1);
	else 
		echo "192.168.76.$ip DOWN";
	fi
done
