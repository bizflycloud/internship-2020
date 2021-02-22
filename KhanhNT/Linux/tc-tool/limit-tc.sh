#!/bin/bash
TC=$(which tc)
interface=ens3
download_limit=512kbit
upload_limit=10mbit
IP=192.168.0.10
# Functions
run_traffic_control(){
    U32="$TC filter add dev $IF protocol ip parent 1:0 prio 1 u32"

    #Use tc tool
    $TC qdisc add dev $interface root handle 1: htb default 30 > /dev/null 2>$1
    
    # Limit Download
    $TC class add dev $interface parent 1: classid 1:1 htb rate $download_limit
    $U32 match ip dest $IP/32 flowid 1:1

    # limit upload
    $TC class add dev $interface parent 1: classid 1:2 htb rate $upload_limit
    $U32 match ip src $IP/32 flowid 1:2
}

stop_traffic_control(){
    $TC qdisc del dev $interface root
}

show(){
    $TC -s qdisc ls dev $interface
}

case "$1" in

start)

echo -n "Start traffic shaping: "
run_traffic_control
echo "done"
;;

stop)

echo -n "stop traffic shaping"
stop_traffic_control
echo "done"
;;

show)
show
echo ""
;;

*)

pwd=$(pwd)
echo "Usage: shaping {start|stop|show}"
;;

esac exit 0