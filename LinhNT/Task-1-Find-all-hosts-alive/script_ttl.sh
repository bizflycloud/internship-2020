#!/bin/bash
# 2020-08-07
#Author: Thanh-Linh Nguyen
#version: 1.1
# Using TTL to detect OS

read -p "Enter a net ip: " ip

ipAddress=$(echo $ip | cut -d "/" -f1)
threeOctets=$(echo $ipAddress | cut -d "." -f1-3)
lastOctet=$(echo $ipAddress | cut -d "." -f4)

subnetMask=$(echo $ip | cut -d "/" -f2)
numberOfBitsHost=$((32-$subnetMask))
hostRange=$((2**$numberOfBitsHost-2+$lastOctet))

for ip in $(seq $(($lastOctet+1)) $hostRange);
do
	ping -c 1 $threeOctets.$ip>/dev/null; 
	if [ $? -eq 0 ]; then 
		echo "====> $threeOctets.$ip UP";
		# Stop after sending 1 echo_request packet (-c1) and wait for a respone = 1s (-w1)
		ttlMatched=$(ping -w1 -c1 $threeOctets.$ip | grep -o "ttl=[0-9][0-9]*") # * : (0+), example : ttl=128, ttl=64
		
		# Get TTL value 
		ttl=$(echo $ttlMatched | cut -d "=" -f2)
		
		if [ $ttl -eq 128 ]; then
			echo "Running Window";
		elif [ $ttl -eq 64 ]; then
			echo "Running Linux";
		else 
			echo "unknown";
		fi

	else 
		echo "$threeOctets.$ip DOWN";
	fi
done
