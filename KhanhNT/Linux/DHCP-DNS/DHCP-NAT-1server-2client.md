# DHCP-NAT

![](https://i.ibb.co/bdnQHLP/Screenshot-from-2020-08-25-15-22-27.png)

## 1. Mục đích:
- DHCP server chạy isc-dhcp-server
- Cấu hình dhcp cho 2 client qua server
- Dùng iptables nat để client kết nối được ra internet

## 2. Cách làm
### a. Cấu hình dhcp server
- Xem qua bài dhcp-lab
- Cấu hình fix địa chỉ ip cho client
- `nano /etc/dhcp/dhcpd.conf`

![](https://i.ibb.co/fYxSys9/Screenshot-from-2020-08-25-15-29-22.png)

### b. Cấu hình dhcp-client
- `ifconfig ens3 up`
- `nano /etc/network/interfaces`

![](https://camo.githubusercontent.com/1dfb9deec45d9a6f5d02e5574a8fb07df33723d7/68747470733a2f2f692e6962622e636f2f51626d39534a562f53637265656e73686f742d66726f6d2d323032302d30382d31392d31362d33372d31332e706e67)

- `/etc/init.d/networking restart`

![](https://camo.githubusercontent.com/893e90bf54876a01474ae16bb6c9ae88925c228b/68747470733a2f2f692e6962622e636f2f4776734b626d392f53637265656e73686f742d66726f6d2d323032302d30382d31392d31362d33392d35332e706e67)

### c. Cấu hình truy cập mạng
- Để kích hoạt iptables forward packet sang máy khác, cần sửa file `/etc/sysctl.conf`
 + `net.ipv4.ip_forward=1`
- Chạy lệnh `sysctl -p /etc/sysctl.conf` để kiểm tra cài đặt
- `/etc/init.d/procps restart`
- Cấu hình kết nối ra ngoài mạng
  + `iptables -t nat -A POSTROUTING -o ens3 -s 192.168.0.0/24 -j MASQUERADE`

