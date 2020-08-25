# LAB 2

![](https://i.ibb.co/LNC1rnJ/Screenshot-from-2020-08-25-14-50-29.png)

## 1. Mục đích
+ ACCEPT Outgoing goí tin thông qua server từ mạng LAN (10.10.10.0/24)
+ Nat địa chỉ nguồn gói tin

## 2. Cấu hình
### a. Trên client 
- Cấu hình ip 10.10.10.2
- Gateway là 10.10.10.1

### b. Trên server
- `nano /etc.sysctl.conf`
  + `net.ipv4.ip_forward=1`
- Kiểm tra `sysctl -p /etc/sysctl.conf`
- `/etc/init.d/procps restart`
- `iptables -t nat -A POSTROUTING -o ens3 -s 10.10.10.0/24 -j MASQUERADE`
