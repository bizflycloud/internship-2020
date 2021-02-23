#!/bin/bash
IF="ens3"
echo "$IF"
ifb="ifb3"
echo "$ifb"
lan="192.168.0."
down="100000"
up="100000"

TC=$(which tc)

modprobe ifb numifb=1
ip link add $ifb type ifb
ip link set dev $ifb up

## Limit incoming traffic

### Clean interface
$TC qdisc del dev $IF handle ffff: ingress
$TC qdisc del root dev $ifb
$TC qdisc del root dev $IF

#$TC qdisc add dev $IF root handle 1: htb default 999
$TC qdisc add dev $IF handle ffff: ingress

### Redirect ingress ens3 to egress ifb3
$TC filter add dev $IF parent ffff: protocol ip u32 match u32 0 0 action mirred egress redirect dev $ifb

$TC qdisc add dev $ifb root handle 1: htb default 10
$TC qdisc add dev $IF root handle 1: htb default 10


for i in $(seq 1 255); do
        $TC class add dev $ifb parent 1:1 classid 1:$i htb rate ${down}kbit
        $TC class add dev $IF parent 1:1 classid 1:$i htb rate ${down}kbit
        $TC filter add dev $ifb protocol ip parent 1: prio 1 u32 match ip dst $lan$i/32 flowid 1:$i
done
