#!/bin/bash
# 2020-08-07
#Author: Thanh-Linh Nguyen
#version: 1.2

read -p "Enter a net ip: " ip

ipAddress=$(echo $ip | cut -d "/" -f1)
threeOctets=$(echo $ipAddress | cut -d "." -f1-3)
lastOctet=$(echo $ipAddress | cut -d "." -f4)

subnetMask=$(echo $ip | cut -d "/" -f2)
numberOfBitsHost=$((32-$subnetMask))
hostRange=$((2**$numberOfBitsHost-2+$lastOctet))

for ip in $(seq $(($lastOctet+1)) $hostRange);
do
	ping -c 1 -i 0.2 $threeOctets.$ip>/dev/null; 
	if [ $? -eq 0 ]; then 
		echo "====> $threeOctets.$ip UP";

		OS="" # initialization 
		# Timeout : 15s
		OS=$(sudo timeout 15 nmap -O $threeOctets.$ip | ((grep "Linux" || grep "Window") | head -1);)
		
		# if OS != NULL --> return OS
		if [ ! -z "$OS" ]; then 
			echo $OS;

		else
			echo "unknown";
		fi

	else 
		echo "$threeOctets.$ip DOWN";
	fi
done
