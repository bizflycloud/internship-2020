# Lab Cluster Web-server 

![](https://i.ibb.co/Hzm93KC/Screenshot-from-2020-09-30-14-56-57.png)

## 1. Đặt IP như hình vẽ và truy cập internet cho các phần tử

### 1.1 Đặt ip như hình vẽ

### 1.2 Cài đặt truy cập mạng:

- Trên Linux-GW (192.168.0.254)

```
root@ubuntu:~# vim /etc/sysctl.conf
Sửa net.ipv4.ip_forward=1
 
root@ubuntu:~# sysctl -p /etc/sysctl.conf 
net.ipv4.ip_forward = 1
root@ubuntu:~# /etc/init.d/procps restart
Restarting procps (via systemctl): procps.service.
root@ubuntu:~# iptables -t nat -A POSTROUTING -o ens3 -s 192.168.0.0/24 -j MASQUERADE
```

## 2. Cấu hình Loadbalancer và Keepalived
### 2.1 Cài đặt Nginx trên Wordpress 1,2,3
- `sudo apt-get update && apt-get install nginx`
- Check 

```
root@ubuntu:~# service nginx status
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-09-30 08:32:38 UTC; 1min 11s ago
 Main PID: 12171 (nginx)
   CGroup: /system.slice/nginx.service
           ├─12171 nginx: master process /usr/sbin/nginx -g daemon on; master_process on
           └─12172 nginx: worker process                           

Sep 30 08:32:38 ubuntu systemd[1]: Starting A high performance web server and a reverse proxy server...
Sep 30 08:32:38 ubuntu systemd[1]: nginx.service: Failed to read PID from file /run/nginx.pid: Invalid argument
Sep 30 08:32:38 ubuntu systemd[1]: Started A high performance web server and a reverse proxy server.
```

### 2.2 Cấu hình Keepalived trên Wordpress 1,2,3
- sudo apt-get install keepalived
- Cho phép HAProxy ràng buộc vào các địa chỉ được chia sẻ: 

```
root@ubuntu:~# echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf 
root@ubuntu:~# vim /etc/sysctl.conf                                                                                                            
root@ubuntu:~# sysctl -p
net.ipv4.ip_nonlocal_bind = 1
```

- Check: sysctl -p 
- `vim /etc/keepalived/keepalived.conf`

#### WP1
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
            192.168.0.10
        }
        track_script {
            chk_haproxy
        }
}
```

#### WP2

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
            192.168.0.10
        }
        track_script {
            chk_haproxy
        }
}
```

#### WP3

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
            192.168.0.10
        }
        track_script {
            chk_haproxy
        }
}

```

- Check
 +  WP1

```
root@ubuntu:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 50:19:00:01:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.1/24 brd 192.168.0.255 scope global ens3
       valid_lft forever preferred_lft forever
    inet 192.168.0.10/32 scope global ens3
       valid_lft forever preferred_lft forever
    inet6 fe80::5219:ff:fe01:0/64 scope link 
       valid_lft forever preferred_lft forever
3: ens4: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 50:19:00:01:00:01 brd ff:ff:ff:ff:ff:ff
4: ens5: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 50:19:00:01:00:02 brd ff:ff:ff:ff:ff:ff
```

### 2.3 Cấu hình HAProxy trên WP1,2,3
- Vì HAProxy sử dụng port 80 nên ta đổi port của NGINX sang 200.
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
        server static 192.168.0.10:80
    backend app
        balance roundrobin
        server test1 192.168.0.1:200 check
        server test2 192.168.0.2:200 check
        server test3 192.168.0.3:200 check
```

- `service haproxy restart`

### 2.4 Cấu hình truy cập từ ngoài vào WP
- Trên Linux Server Gateway

```
root@ubuntu:~# iptables -t nat -A PREROUTING -i ens3 -p tcp -d 192.168.17.78 --dport 200 \-j DNAT --to-destination 192.168.0.10:200

root@ubuntu:~# iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         
DNAT       tcp  --  anywhere             192.168.17.78        tcp dpt:200 to:192.168.0.10:200

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  192.168.0.0/24       anywhere            
```

## Bước 3: Cài đặt Galara Clutser trên 3 máy DataBase

-`sudo apt-get update`
- `sudo apt-get install mysql-server`
- `sudo apt-get install galera rsync`
- `vim /etc/mysql/mysql.conf.d/mysqld.cnf`
   + comment dòng bind-address=127.0.0.1
- `vim /etc/mysql/conf.d/galera.cnf`

#### DB4: 

```
[mysqld]
query_cache_size=0
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
query_cache_type=0
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://192.168.0.4,192.168.0.5,192.168.0.6"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="192.168.0.4"
wsrep_node_name="node-4"
```

#### DB5

```
[mysqld]
query_cache_size=0
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
query_cache_type=0
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://192.168.0.4,192.168.0.5,192.168.0.6"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="192.168.0.5"
wsrep_node_name="node-5"
```

#### DB6

```
[mysqld]
query_cache_size=0
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
query_cache_type=0
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://192.168.0.4,192.168.0.5,192.168.0.6"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="192.168.0.6"
wsrep_node_name="node-6"
```

https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mysql-5-6-on-ubuntu-16-04





