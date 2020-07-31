#!/bin/bash
# 2020-07-31
#Author: Thanh-Linh Nguyen
#version: 1.1

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
		sudo nmap -O $threeOctets.$ip | ((grep "Linux" || grep "Window" || echo "unknown") | head -1);
	else 
		echo "$threeOctets.$ip DOWN";
	fi
done
