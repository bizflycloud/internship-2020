# Lab DHCP 

![](https://i.ibb.co/dWWdg79/topo16-24.png)

## 1. Cấu hình truy cập internet trên DHCP server
- nano /etc/network/interfaces

![](https://i.ibb.co/Yy4YvtW/Screenshot-from-2020-08-19-16-27-26.png)

## 2. Tải DHCP server và cấu hình
- apt update
- apt install isc-dhcp-server
- route add default gw 192.168.0.1
- Check lại bằng lệnh route

### Cấu hình dhcp
- nano /etc/default/isc-dhcp-server

![](https://i.ibb.co/nQdGPpm/Screenshot-from-2020-08-19-16-31-21.png)

- nano /etc/dhcp/dhcpd.conf

![](https://i.ibb.co/fr6HYG4/Screenshot-from-2020-08-19-16-33-14.png)

- service isc-dhcp-server restart
- service isc-dhcp-server status

## 3. Cấu hình DHCP trên client
- ifconfig ens3 up
- nano /etc/network/interfaces

![](https://i.ibb.co/Qbm9SJV/Screenshot-from-2020-08-19-16-37-13.png)

- /etc/init.d/networking restart

![](https://i.ibb.co/GvsKbm9/Screenshot-from-2020-08-19-16-39-53.png)
