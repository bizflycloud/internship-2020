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
