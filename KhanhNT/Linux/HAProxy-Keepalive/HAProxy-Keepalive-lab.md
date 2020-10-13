# HAProxy-Keepalive Lab

![](https://i.ibb.co/6b57KQ5/Screenshot-from-2020-09-28-09-37-57.png)

## Bước 1. Cấu hình địa chỉ IP và Mạng
### 1.1 Cấu hình địa chỉ IP

- Linux Gateway

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto ens3
iface ens3 inet static
address 192.168.0.1
netmask 255.255.255.0

auto ens4
iface ens4 inet dhcp

# Source interfaces
# Please check /etc/network/interfaces.d before changing this file
# as interfaces may have been defined in /etc/network/interfaces.d
# See LP: #1262951
source /etc/network/interfaces.d/*.cfg
```

- Web Server 1

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto ens3
iface ens3 inet static
address 192.168.0.2 
netmask 255.255.255.0
gateway 192.168.0.1
dns-nameservers 8.8.8.8


# Source interfaces
# Please check /etc/network/interfaces.d before changing this file
# as interfaces may have been defined in /etc/network/interfaces.d
# See LP: #1262951
source /etc/network/interfaces.d/*.cfg
```

- WebServer 2

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto ens3
iface ens3 inet static
address 192.168.0.3
netmask 255.255.255.0
gateway 192.168.0.1
dns-nameservers 8.8.8.8

# Source interfaces
# Please check /etc/network/interfaces.d before changing this file
# as interfaces may have been defined in /etc/network/interfaces.d
# See LP: #1262951
source /etc/network/interfaces.d/*.cfg
```

- Web Server 3

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto ens3
iface ens3 inet static
address 192.168.0.4
netmask 255.255.255.0
gateway 192.168.0.1
dns-nameserver 8.8.8.8

# Source interfaces
# Please check /etc/network/interfaces.d before changing this file
# as interfaces may have been defined in /etc/network/interfaces.d
# See LP: #1262951
source /etc/network/interfaces.d/*.cfg
```

- Truy cập internet 
 + Linux Server Gateway
   - `nano /etc/sysctl.conf`
   - `net.ipv4.ip_forward=1`
   - Check: `sysctl -p /etc/sysctl.conf`
   - `/etc/init.d/procps restart`

## Bước 2: Cài đặt Nginx trên Webserver1,2,3

- `sudo apt-get update`
- `sudo apt-get install nginx`

## Bước 3: Cấu hình keepalived
### Thực hiện trên cả 3 máy:

- `sudo apt-get install keepalived`
- Cho phép HAProxy ràng buộc vào các địa chỉ được chia sẻ:
   + `vim /etc/sysctl.conf`
   + Thêm dòng: `net.ipv4.ip_nonlocal_bind=1`
- Check: `sysctl -p`

### Web Server 1

```
vrrp_script chk_haproxy {
        script "killall -0 haproxy"
        interval 2
        weight 2
}

vrrp_instance VI_1 {
        interface ens3
        state MASTER
        virtual_router_id 51
        priority 101
        virtual_ipaddress {
            192.168.0.5
        }
        track_script {
            chk_haproxy
        }
}
```


### Web Server 3

```

vrrp_script chk_haproxy {
        script "killall -0 haproxy"
        interval 2
        weight 2
}

vrrp_instance VI_1 {
        interface ens3
        state BACKUP
        virtual_router_id 51
        priority 100
        virtual_ipaddress {
            192.168.0.5
        }
        track_script {
            chk_haproxy
        }
}
```


### Web Server 3

```
vrrp_script chk_haproxy {
        script "killall -0 haproxy"
        interval 2
        weight 2
}

vrrp_instance VI_1 {
        interface ens3
        state BACKUP
        virtual_router_id 51
        priority 99
        virtual_ipaddress {
            192.168.0.5
        }
        track_script {
            chk_haproxy
        }
}

```

```
Trong đó:
- interval: Kiểm tra trạng thái keepalive mỗi 2 giây
- weight: Kiểm tra thành công sẽ được cộng 2 điểm
- priority
- track_script: giúp keepalive xác định node nào nắm VIP (ở đây là node 1 MASTER)
```

- Check trên node web2

```
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 50:19:00:03:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.2/24 brd 192.168.0.255 scope global ens3
       valid_lft forever preferred_lft forever
    inet 192.168.0.5/32 scope global ens3
       valid_lft forever preferred_lft forever
    inet6 fe80::5219:ff:fe03:0/64 scope link 
       valid_lft forever preferred_lft forever

192.168.0.5 là VIP
```

## Bước 4: Truy cập từ ngoài Public vào Server
### Linux Gateway:
- `root@ubuntu:~# iptables -A FORWARD -p tcp --dst 192.168.0.5 --dport 80 -j ACCEPT`

- `root@ubuntu:~# iptables -t nat -A PREROUTING -i ens4 -p tcp -d 192.168.17.75 --dport 80 \-j DNAT --to-destination 192.168.0.5:80`

### Kiểm tra:

![](https://i.ibb.co/t887yNC/Screenshot-from-2020-09-29-15-00-02.png) 

- Sau khi shutdown web1, nhảy sang web2

![](https://i.ibb.co/V3BymF1/Screenshot-from-2020-09-29-15-02-22.png)

## Bước 5: Cấu hình HAProxy
- `sudo apt-get install haproxy`
- `vim /etc/haproxy/haproxy.cfg`

```
global
        daemon
        maxconn 256

    defaults
        mode http
        timeout connect 5000ms
        timeout client 50000ms
        timeout server 50000ms

    frontend http-in
        bind *:80
        default_backend app
    backend static
        balance roundrobin
        server static 192.168.0.5:80
    backend app
        balance roundrobin
        server test1 192.168.0.2:200 check
        server test2 192.168.0.3:200 check
        server test3 192.168.0.4:200 check

```

**Note**
- Đổi `port` của nginx thành 200 để tránh trùng với port của `haproxy`

- **Trên Linux Gateway**:
  + `root@ubuntu:~# iptables -t nat -A PREROUTING -i ens4 -p tcp -d 192.168.17.75 --dport 200 \-j DNAT --to-destination 192.168.0.5:200`

__Tài liệu tham khảo__

- https://viblo.asia/p/trien-khai-dich-vu-high-available-voi-keepalived-haproxy-tren-server-ubuntu-jOxKdqWlzdm











