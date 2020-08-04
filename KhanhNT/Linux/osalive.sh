#!/bin/bash
for ip in $@ ;do
     	net=$(echo $ip | cut -d '/' -f 1);
        prefix=$(echo $ip | cut -d '/' -f 2);
        o1=$(echo $net | cut -d '.' -f4);
        o2=$(echo $net | cut -d '.' -f3);
        o3=$(echo $net | cut -d '.' -f2);
        o4=$(echo $net | cut -d '.' -f1);
        len=$(echo "2^(32 - $prefix)"|bc);
		for i in `seq $len`;do
			echo "$o4.$o3.$o2.$o1";
            o1=$(echo "$o1+1"|bc);
            if [ $o1 -eq 256 ]; then
            	o1=0;
                o2=$(echo "$o2+1"|bc);
                	if [ $o2 -eq 256 ]; then
                    	o2=0;
                        o3=$(echo "$o3+1"|bc);
                        	if [ $o3 -eq 256 ]; then
                        		o3=0;
                            	o4=$(echo "$o4+1"|bc);
                                     
                        	fi
                     fi
            fi 
            for ip in $o4.$o3.$o2.$o1; do  # for loop and the {} operator
				ttlstr=$(ping -c1 -w1 $o4.$o3.$o2.$o1 | grep -o 'ttl=[0-9][0-9]*') || {
        			printf "%s is Offline\n" "$o4.$o3.$o2.$o1"
        			continue;
    			}
    			ttl="${ttlstr#*=}"  ## parameter expansion separating numeric ttl
    			printf "%s is Online, ttl=%d\n" "$o4.$o3.$o2.$o1" "$ttl"
    			if [ $ttl == 64 ]
            		then
                		echo "$o4.$o3.$o2.$o1 is Linux"
            		elif [ $ttl == 128 ]
            		then
                		echo "$o4.$o3.$o2.$o1 is Windows"
                		
 					
            	fi
			done	
   					
		done  
done
