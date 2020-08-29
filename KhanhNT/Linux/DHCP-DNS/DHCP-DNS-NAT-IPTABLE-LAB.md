# DHCP-DNS-NAT-IPTABLE

![](https://trello-attachments.s3.amazonaws.com/5f3207eef8e2d77b22619a21/832x603/f0e84cab9e792218500d05ad5216e452/image.png)

## Bước 1: Cấu hình DHCP 
- Cấu hình kết nối mạng cho Linux server Gateway

![](https://i.ibb.co/qjcn6r4/Screenshot-from-2020-08-20-15-40-56.png)

- /etc/init.d/networking restart

- Cài đặt isc-dhcp-server
  +  `apt install isc-dhcp-server`
-  Cấu hình DHCP trong 2 file 
 + /etc/dhcp/dhcpd.conf
 + /etc/default/isc-dhcp-server

![](https://i.ibb.co/n3SD1pM/Screenshot-from-2020-08-20-15-45-17.png)

![](https://i.ibb.co/Lr0P2Nd/Screenshot-from-2020-08-20-15-46-56.png)

![](https://i.ibb.co/cbsXqyp/Screenshot-from-2020-08-20-15-47-54.png)

- service isc-dhcp-server restart
- service isc-dhcp-server status

- Cấu hình mạng trên client
  
![](https://i.ibb.co/3c874wT/Screenshot-from-2020-08-20-15-50-43.png)

- /etc/init.d/networking restart 

![](https://i.ibb.co/DbSFtJw/Screenshot-from-2020-08-20-15-53-00.png)

## Bước 2: Cấu hình NAT
### Mục đích: thiết lập kết nối mạng ra internet cho các máy client
- Kích hoạt IPtables forward sang máy khác
   + nano `/etc/sysctl.conf`
   + Sửa  `net.ipv4.ip_forward = 1`
- `sysctl -p /etc/sysctl.conf`: kiểm tra cài đặt
- `/etc/init.d/procps restart`
- Thiết lập kết nối

```
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

- ACCEPT gói tin thông qua server từ mạng LAN và cấu hình NAT
```
iptables -A FORWARD -i ens3 -o ens4 -j ACCEPT
iptables -t nat -A POSTROUTING -o ens4 -s 192.168.0.0/24 -j SNAT --to-source 192.168.17.125
iptables -t nat -A POSTROUTING -o ens4 -s 192.168.0.0/24 -j MASQUERADE
```

- `iptables -t nat -L`

![](https://i.ibb.co/ZGf1fTf/Screenshot-from-2020-08-20-17-27-11.png)

## Bước 3: Cài đặt DNS-Server
### Mục đích: gán địa chỉ web server 192.168.0.2 cho tên miền bizflycloud.com

- Cài đặt Bind9
 + `apt install bind9` 
- Để phân giải tên miền ta cần cấu hình file zone, file phân giải thuận và file phân giải nghịch
- Thêm 1 zone
  + `nano /etc/bind/named.conf.local`

![](https://i.ibb.co/k9nxKN7/Screenshot-from-2020-08-26-10-32-39.png)
https://i.ibb.co/6Nmqt8C/Screenshot-from-2020-08-26-10-55-08.png
- Cấu hình file cấu hình thuật
  + `cp /etc/bind/db.empty /etc/bind/db.bizflycloud.com`
  + `nano /etc/bind/db.bizflycloud.com`
![](https://i.ibb.co/cTXtP82/Screenshot-from-2020-08-26-10-41-07.png)

  ```
  - ns.bizflycloud.com: địa chỉ phân giải cho DNS server
  - @ IN NS ns.bizflycloud.com: tên miền phân giải cho DNS server
  - @ IN A 192.168.0.1: địa chỉ IP DNS server
  - ns IN A 192.168.0.1: tên miền phân cấp đằng trước bizflycloud.com trỏ về địa chỉ IP
  - www IN A 192.168.0.2: IP trỏ trực tiếp đến bixzflycloud.com
  
  ```
- Cấu hình file nghịch
  + `cp /etc/bind/db.empty /etc/bind/db.bizflycloud.reverse`

  ![](https://i.ibb.co/xmWjpC5/Screenshot-from-2020-08-26-10-48-56.png)

   ```
   + 1 IN PTR ns.bizflycloud.com: địa chỉ được gán với ns.bizflycloud.com
   + 2 IN PTR www.bizflycloud.com: địa chỉ được gán với www.bizflycloud.com
    ```
- Sửa file /etc/resolv.conf
   ![](https://i.ibb.co/T4brSJH/Screenshot-from-2020-08-26-10-52-47.png)

- `service bind9 restart`
- `service bind9 status`

![](https://i.ibb.co/6Nmqt8C/Screenshot-from-2020-08-26-10-55-08.png)
 
