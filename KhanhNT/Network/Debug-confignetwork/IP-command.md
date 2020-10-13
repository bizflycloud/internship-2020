# IP command
## 1. Cấu hình quản lí địa chỉ IP
### Thêm địa chỉ IP tĩnh
  + `ip address add [ip/subnet] dev [NAME]`

```
corgi@ubuntu:~$ sudo ip address add 192.168.0.1/24 dev eth0
[sudo] password for corgi: 
corgi@ubuntu:~$ ip a
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:00:2b:b9 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet 192.168.0.1/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe00:2bb9/64 scope link 
       valid_lft forever preferred_lft forever

```

### Xóa địa chỉ IP tĩnh
- `ip address del [ip/subnet] dev [NAME]`

### Xem thông tin IP
- `ip address show [dev][name]`

```
corgi@ubuntu:~$ ip add show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:00:2b:b9 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe00:2bb9/64 scope link 
       valid_lft forever preferred_lft forever

```

```
corgi@ubuntu:~$ ip add show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:00:2b:b9 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe00:2bb9/64 scope link 
       valid_lft forever preferred_lft forever
```

## 2. Cấu hình thiết bị card mạng
### Up/Down card mạng
- `ip link set [Device] {up/down}`

### Xem thông tin card mạng
- `ip link show [Device]`

## 3. Cấu hình quản lí bảng định tuyến
### Hiển thị thông tin bảng định tuyến

- `ip route show`

### Thêm/xóa route tĩnh vào bảng định tuyến
- `ip route {add|del} {NETWORK}`

### Thêm/Xóa Default gateway route
- `ip route [add/del] default via [IP_GATEWAY] dev [NAME]`

### Tìm route mà packet sẽ đi
- `ip route get {ip_address}`

## 4. Cấu hình quản lí bảng ARP hệ thống
- Liệt kê thông tin bảng `ARP mapping` giữa địa chỉ IP và MAC Address
  + `ip neighbor`

```
corgi@ubuntu:~$ ip neighbor
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 DELAY

```
- Thêm xóa thông tin trong bảng `ARP mapping`
 + `ip neigh {add/del} {ip} ||addr {MAC address} dev {Name_device}`
