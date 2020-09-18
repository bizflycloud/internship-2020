# IP Route

## 1. Liệt kê thông tin trong bảng Routing

- `route` hoặc `route -n`

```
root@ubuntu:~# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         192.168.17.1    0.0.0.0         UG    0      0        0 ens3
192.168.17.0    *               255.255.255.0   U     0      0        0 ens3
root@ubuntu:~# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.17.1    0.0.0.0         UG    0      0        0 ens3
192.168.17.0    0.0.0.0         255.255.255.0   U     0      0        0 ens3

```

với

```
U: Route đang up
G: Sử dụng route này là Gateway 
R: Routing động\
!: Route bị reject
```

## 2. Cấu hình quản lí địa chỉ IP
### 2.1 Thêm địa chỉ IP tĩnh
- `ip address add {ip address} dev [name device]`

`EX: ip address add 192.168.1.0/24 dev ens3`

- Kiểm tra lại thông tin địa chỉ ip trên card mạng ens3
 + `ip link show ens3`

### 2.2 Xóa địa chỉ IP tĩnh
- `ip address del {ip address} dev [name device]`
- Xem thông tin IP
  + `ip address show dev [name]`

## 3. Cấu hình các thiết bị card mạng
### 3.1 Up/Down card mạng
- `ip link set [device] {up/down}`

```
Ex:
ip link ens3 down
ip link ens3 up
```

### 3.2 Show thông tin card mạng
- `ip link show [Device]`

## 4. Cấu hình quản lí bảng định tuyến (routing Table)
### 4.1 Hiển thị thông tin bảng đinh tuyến
- `ip route show`

```
root@ubuntu:~# ip route show
default via 192.168.17.1 dev ens3 
192.168.17.0/24 dev ens3  proto kernel  scope link  src 192.168.17.50 
```

### 4.2. Thêm/Xóa route tĩnh vào bảng định tuyến
- `ip route {add/del} {network}`

```
EX:
ip route add 192.168.1.0/24 via 192.168.1.1 dev ens3
ip route add 192.168.1.99 via 192.168.1.1 dev ens3

ip route del 192.168.1.0/24 via 192.168.1.1 dev ens3
ip route del 192.168.1.99 via 192.168.1.1 dev ens3
```

### 4.3 Thêm/xóa default gateway route
- `ip route [add/del] default via [ip_Gateway] dev [NAME]`

```
Ex:
ip route add default via 192.168.1.0 dev ens3
ip route del default via 192.168.1.0 dev ens3
```

### 4.4 Tìm route mà packet sẽ đi
- `ip route get {IP_Address}`

```
root@ubuntu:~# ip route get 8.8.8.8
8.8.8.8 via 192.168.17.1 dev ens3  src 192.168.17.50 
    cache 
```

## 5. Cấu hình bảng ARP hệ thống 
- `ip neighbour`

```
root@ubuntu:~# ip neighbour
192.168.17.1 dev ens3 lladdr ac:1f:6b:2d:f1:74 DELAY
192.168.17.130 dev ens3 lladdr f4:6d:04:cf:bd:e9 STALE
```

- `ip neigh add 192.168.1.99 ||addr 1:2:3:4:5:6 dev ens3`
- `ip neigh del 192.168.1.99 ||addr 1:2:3:4:5:6 dev ens3`

## 6. Hiển thị Network Statistics
- `ip -s link`

```
root@ubuntu:~# ip -s link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX: bytes  packets  errors  dropped overrun mcast   
    17928      228      0       0       0       0       
    TX: bytes  packets  errors  dropped carrier collsns 
    17928      228      0       0       0       0       
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 50:19:00:01:00:00 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    3583423    19050    0       6       0       0       
    TX: bytes  packets  errors  dropped carrier collsns 
    129654     1348     0       0       0       0   

```
- Nhận thông tin về 1 network interface cụ thể
  + `ip -s -s link ls [interface_name]`

```
root@ubuntu:~# ip -s -s link ls ens3
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 50:19:00:01:00:00 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    3649270    19909    0       6       0       0       
    RX errors: length   crc     frame   fifo    missed
               0        0       0       0       0       
    TX: bytes  packets  errors  dropped carrier collsns 
    134682     1390     0       0       0       0       
    TX errors: aborted  fifo   window heartbeat transns
               0        0       0       0       2       

```
