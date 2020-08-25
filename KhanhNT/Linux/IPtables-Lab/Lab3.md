# LAB 3

![](https://i.ibb.co/6XnTXvT/Screenshot-from-2020-08-25-16-25-53.png)

## 1. Mục tiêu
- Cấu hình iptables tại server

- Backend1, webserver (apache2)  lắng nghe port 80

- Backend2, webserver (apache2) lắng nghe port 443

- FORWARD gói tin đến port 80 trên e0 đến port tương tự trên Backend1

- FORWARD gói tin đến port 443 trên e0 đến port tương tự trên Backend2

- ACCEPT Outgoing Packets thông qua server từ mạng LAN(10.10.10.0/24) ra internet

## 2. Cấu hình truy cập internet
- Cấu hình địa chỉ IP như hình vẽ 
- Cấu hình truy cập internet trên server
 + `nano /etc/sysctl.conf`
 + `net.ipv4.ip_forward=1`
 + Kiểm tra bằng lệnh `sysctl -p /etc/sysctl.conf`
 + `/etc/init.d/procps restart`
 + `iptables -t nat -A POSTROUTING -o ens3 -s 10.10.10.0/24 -j SNAT --to-source 172.29.129.98`

## 3. Cấu hình web-server trên client
- `apt-get update`
- `apt install apache2`
- Trên Backend1
 + `nano /var/www/html/index.html`
 + `<h1>This is backend1</h1>

- Trên Backend2
 + `nano /var/www/html/index.html`
 + `<h1>This is backend2</h1>
 + Kích hoạt ssl:
    + `a2enmod ssl`
    + `a2ensite default-ssl.conf`
    + `systemctl restart apache2`
## 4. Cấu hình trên server
- `nano /etc/sysctl.conf`
   + `net.ipv4.ip_forward=1`
- `/etc/init.d/procps restart`

### Cấu hình iptables
- Cấu hình kết nối mạng: 
  + `iptables -t nat -A POSTROUTING -o ens3 -s 10.10.10.0/24 -j SNAT --to-source 192.168.17.55`
- Cấu hình gói tin đến port 80 ứng với port tương tự trên backend1, Cấu hình gói tin đến port 443 ứng với port tương tự trên backend2.
   + `iptables -A FORWARD -p tcp --dst 10.10.10.2 --dport 80 -j ACCEPT`
   + `iptables -A FORWARD -p tcp --dst 10.10.10.3 --dport 443 -j ACCEPT`
   + `iptables -t nat -A PREROUTING -i ens3 -p tcp 192.168.17.55 --dport 80 \-j DNAT --to-destination 10.10.10.2:80`
   + `iptables -t nat -A PREROUTING -i ens3 -p tcp 192.168.17.55 --dport 443 \-j DNAT --to-destination 10.10.10.2:443`

![](https://i.ibb.co/R4cQP4v/Screenshot-from-2020-08-25-18-10-08.png)

