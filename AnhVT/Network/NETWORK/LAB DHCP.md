# LAB DHCP

![LAB%20DHCP/Untitled.png](LAB%20DHCP/Untitled.png)

# Yêu cầu

- 2 Server
    - 1 server sử dụng làm DHCP Server
    - 1 server sử dụng làm client để test

# Bước thực hiện

## Tại Server DHCP

![LAB%20DHCP/Untitled%201.png](LAB%20DHCP/Untitled%201.png)

### Thực hiện cài DHCP Server

```bash
sudo apt-get install isc-dhcp-server -y
```

### Tiến hành chỉnh sửa file cấu hình của DHCP

```bash
sudo nano /etc/dhcp/dhcpd.conf
```

```bash
#Them doan code sau xuong duoi cung
#Cac gia tri thay doi tuy theo thong so tai server su dung DHCP
subnet 192.168.150.0 mask 255.255.255.0{
range 192.168.150.100 192.168.150.200;
option routers 192.168.150.2;
option domain-name-servers 8.8.8.8, 8.8.4.4;

```

Ngoài ra nếu Server có nhiều giao diện mạng khác nhau thì cần định nghĩa giao diện phục vụ DHCP tại đường dẫn `/etc/default/isc-dhcp-server`

```bash
INTERFACESv4="eth0"
```

Sau đó set up cho Server trở thành Server DHCP chính cho các clients trong mạng:

```bash
#Uncomment
authoritative;
```

### Tiến hành bật dịch vụ DHCP

```bash
sudo systemctl start isc-dhcp-server.service
sudo systemctl enable isc-dhcp-server.service
sudo systemctl status isc-dhcp-server.service
```

## Tại Server Clients

![LAB%20DHCP/Untitled%202.png](LAB%20DHCP/Untitled%202.png)

Thực hiện lệnh nhận ip từ DHCP,interface đang xét ở đây là `ens38`:

```bash
dhclient -r ens38
```

Kiểm tra lại việc nhận IP từ máy chủ thông qua

```bash
ip a
```

Nếu muốn reset lấy 1 địa chỉ IP khác cần thực hiện

```bash
dhclient -r dev ens38
```

hoặc có thể sử dụng lệnh sau để xóa ip :

```bash
ip addr del xxx.xxx.xxx.xxx dev ens38
```