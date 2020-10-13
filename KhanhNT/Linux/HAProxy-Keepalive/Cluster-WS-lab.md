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

### Cài đặt trên mỗi DB4,5,6

- `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv BC19DDBA`

```
root@ubuntu:~# apt-key adv --keyserver keyserver.ubuntu.com --recv BC19DDBA
Executing: /tmp/tmp.0HXUylkjaM/gpg.1.sh --keyserver
keyserver.ubuntu.com
--recv
BC19DDBA
gpg: requesting key BC19DDBA from hkp server keyserver.ubuntu.com
gpg: key BC19DDBA: public key "Codership Oy <info@galeracluster.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
```

- `sudo vim /etc/apt/sources.list.d/galera.list`

```
deb http://releases.galeracluster.com/mysql-wsrep-5.6/ubuntu xenial main
deb http://releases.galeracluster.com/galera-3/ubuntu xenial main

```

- `sudo vim /etc/apt/preferences.d/galera.pref`

```
# Prefer Codership repository
Package: *
Pin: origin releases.galeracluster.com
Pin-Priority: 1001
```

- `sudo apt-get update`

- `sudo apt-get install galera-3 galera-arbitrator-3 mysql-wsrep-5.6`

- `sudo apt-get install rsync`

- `sudo vim /etc/mysql/conf.d/galera.cnf`

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

- `systemctl stop mysql`

- `vim /etc/mysql/mysql.conf.d/mysqld.cnf`

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
log-error       = /var/log/mysql/error.log
# Disabling symbolic-links is recommended to prevent assorted security risks
bind-address    = 0.0.0.0 # mysql bind duoc den tat ca dia chi IP
symbolic-links=0
```

#### Trên DB4:
- `/etc/init.d/mysql start --wsrep-new-cluster`

#### Trên DB5 và DB6:
- `systemctl restart mysql`

```
root@ubuntu:~# mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
Enter password: 
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+
```



## Bước 4: Tạo User cho từng Wordpress Server trên DataBase Cluster
### Vì cụm DataBase đã đồng bộ nên ta chỉ cần thực hiện trên 1 DataBase => Ở đây sử dụng DB4

- mysql -u root -p

```

mysql> CREATE USER 'wp'@'192.168.0.1' IDENTIFIED BY 'Password@123';
Query OK, 0 rows affected (0.03 sec)

mysql> GRANT ALL PRIVILEGES ON wordpress.* TO 'wp'@'192.168.0.1';
Query OK, 0 rows affected (0.03 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.04 sec)
```

```

mysql> CREATE USER 'wp'@'192.168.0.2' IDENTIFIED BY 'Password@123';
Query OK, 0 rows affected (0.02 sec)

mysql> GRANT ALL PRIVILEGES ON wordpress.* TO 'wp'@'192.168.0.2';
Query OK, 0 rows affected (0.03 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.03 sec)
```

```

mysql> CREATE USER 'wp'@'192.168.0.3' IDENTIFIED BY 'Password@123';
Query OK, 0 rows affected (0.04 sec)

mysql> GRANT ALL PRIVILEGES ON wordpress.* TO 'wp'@'192.168.0.3';
Query OK, 0 rows affected (0.03 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)
```
- Dùng `select * from mysql.user;` trên cả 3 DB để check => Xuất hiện user trên cả 3 DB là đã thành công.

## Bước 5: Cài đặt keepalive cho 3 máy Database để WP có thể truy cập đến cụm qua 1 IP duy nhất.

- `apt-get install keepalived`



```
root@ubuntu:~# echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf 
root@ubuntu:~# vim /etc/sysctl.conf                                                                                                            
root@ubuntu:~# sysctl -p
net.ipv4.ip_nonlocal_bind = 1
```

- `vim /etc/keepalived/keepalived.conf`

#### DB4

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
            192.168.0.11
        }
        track_script {
            chk_haproxy
        }
}

```

#### DB5

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
            192.168.0.11
        }
        track_script {
            chk_haproxy
        }
}
```

#### DB6

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
            192.168.0.11
        }
        track_script {
            chk_haproxy
        }
}
```
- `service keepalived restart `
- Check:

```
root@ubuntu:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 50:19:00:04:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.4/24 brd 192.168.0.255 scope global ens3
       valid_lft forever preferred_lft forever
    inet 192.168.0.11/32 scope global ens3
       valid_lft forever preferred_lft forever
    inet6 fe80::5219:ff:fe04:0/64 scope link 
       valid_lft forever preferred_lft forever
3: ens4: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 50:19:00:04:00:01 brd ff:ff:ff:ff:ff:ff
4: ens5: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 50:19:00:04:00:02 brd ff:ff:ff:ff:ff:ff
```

## Bước 6: Connect đến cụm DataBase Cluster từ Wordpress
### Cấu hình trên WP1, WP2, WP3
- `apt-get install mysql-client`

```
root@ubuntu:~# mysql -u wp -h 192.168.0.11 -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.6.48 MySQL Wsrep Server (GPL), wsrep_25.30

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
Bye
```

## Bước 7: Cài đặt php trên WP1, WP2, WP3

- `apt-get install nginx php-fpm php-mysql`

- `vim /etc/php/7.0/fpm/php.ini `

`cgi.fix_pathinfo=0`



## Bước 9: Cài đặt Wordpress trên 3 máy WP1, WP2, WP3:


#### Trên máy WP1:

- Thực hiện tạo database cho user `wp`:

```
mysql> create database wordpress;
Query OK, 1 row affected (0.03 sec)

mysql> show databases
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| wordpress          |
+--------------------+
2 rows in set (0.00 sec)
```

#### Note: vì cùng thuộc user `wp` nên trên WP2 và WP3 cũng xuất hiện databases wordpress

- `wget http://wordpress.org/latest.tar.gz`
- `tar xzvf latest.tar.gz`
- `cd /wordpress`
- `mkdir -p /var/www/example.com`
- `cp -r ~/wordpress/* /var/www/example.com/`
- `cd /var/www/example.com`
- `chown -R www-data:www-data *`
- `usermod -a -G www-data root`
- `chmod -R g+rw /var/www/example.com`
- `nano /var/www/example/wp-config.php`

 ```
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wp' );

/** MySQL database password */
define( 'DB_PASSWORD', 'Password@123' );

/** MySQL hostname */
define( 'DB_HOST', '192.168.0.11' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '9Bi*f&g|nXRB7--Prn+,@3. ohR]k@)gvaE|1Ja/)eVqH:|k4!v7}7JB^a`CH|w)');
define('SECURE_AUTH_KEY',  'X-GTT Qouz&{|IAn(V2D)Uj`2~*V[QF0J#v+MX8JTbH;RoB6%k+*xxpu%>3$OPS-');
define('LOGGED_IN_KEY',    '.G[.I@LSwNU5LDq7=^QA6)KXvKfBU8]+tRgSY/IjUC,kG]d|L~n>-ML17t_+s?7n');
define('NONCE_KEY',        'Mc#;2^ZBOVD6usf/=~:#kgK3Kub4V4F{sS6+qU=R7y]e% 4p%J[.y2|:ZY*;si|+');
define('AUTH_SALT',        '.A#R< ue486oe0U!`qq.pz5Eg?PM=;u_R.M(j[,ld0|(b}tB<#v{IuE7UXV/zKV/');
define('SECURE_AUTH_SALT', '#pEX6i3HaSCO30@z-o>p`e_TBvqa@t>yiC&&i+w( t~pP*M;&CTEI9(mG|dOU.I2');
define('LOGGED_IN_SALT',   'uuWg5ILnl5Wrh,|S-XoT+kK31&5aW6&oA+V-W7{n^;XR}61;5q);hJuDV6fCe>-;');
define('NONCE_SALT',       '(XCm8!@;v.Q1NMJ1;GZu{?$r2D6M_NR-frikYGpzrFIQz?#c,aRo#ljF|DWSpwJ*');
```

## Bước 8: Cài đặt NFS đồng bộ file cấu hình giữa 3 WP

#### Mục tiêu:
- Cần đồng bộ giữa các máy:
+ ` /var/www/example.com`
+ `/etc/nginx/`

- Trên WP1: 
    + `apt-get install nfs-kernel-server -y`
    + `vim /etc/exports`

```
# /etc/exports: the access control list for filesystems which may be exported
#               to NFS clients.  See exports(5).
#
# Example for NFSv2 and NFSv3:
# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
#
# Example for NFSv4:
# /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
# /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
#

/var/www/ 192.168.0.2/24(rw,insecure,sync,no_subtree_check,no_root_squash)
/var/www/ 192.168.0.3/24(rw,insecure,sync,no_subtree_check,no_root_squash)
/etc/nginx/ 192.168.0.2/24(rw,insecure,sync,no_subtree_check,no_root_squash)
/etc/nginx/ 192.168.0.3/24(rw,insecure,sync,no_subtree_check,no_root_squash)



#/var/www/html/ 192.168.0.2/24(rw)

:wq

```

#### Checks

```
root@ubuntu:~# exportfs -arv
exportfs: /etc/exports [2]: Neither 'subtree_check' or 'no_subtree_check' specified for export "192.168.0.2/24:/var/www/example.com/".
  Assuming default behaviour ('no_subtree_check').
  NOTE: this default has changed since nfs-utils version 1.0.x

exportfs: /etc/exports [3]: Neither 'subtree_check' or 'no_subtree_check' specified for export "192.168.0.3/24:/var/www/".
  Assuming default behaviour ('no_subtree_check').
  NOTE: this default has changed since nfs-utils version 1.0.x

exportfs: /etc/exports [4]: Neither 'subtree_check' or 'no_subtree_check' specified for export "192.168.0.2/24:/etc/nginx/".
  Assuming default behaviour ('no_subtree_check').
  NOTE: this default has changed since nfs-utils version 1.0.x

exportfs: /etc/exports [5]: Neither 'subtree_check' or 'no_subtree_check' specified for export "192.168.0.3/24:/etc/nginx/".
  Assuming default behaviour ('no_subtree_check').
  NOTE: this default has changed since nfs-utils version 1.0.x

exporting 192.168.0.2/24:/etc/nginx
exporting 192.168.0.3/24:/etc/nginx
exporting 192.168.0.2/24:/var/www/
exporting 192.168.0.3/24:/var/www/
```

- Trên WP2,3: 
    + `apt-get install nfs-common -y`
    + `mount 192.168.0.1:/etc/nginx/ /etc/nginx/`

```
root@ubuntu:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            991M     0  991M   0% /dev
tmpfs           200M  8.1M  192M   5% /run
/dev/sda1        62G  1.5G   61G   3% /
tmpfs          1000M     0 1000M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs          1000M     0 1000M   0% /sys/fs/cgroup
tmpfs           200M     0  200M   0% /run/user/0
root@ubuntu:~# mount 192.168.0.1:/etc/nginx/ /etc/nginx/
root@ubuntu:~# df -h
Filesystem              Size  Used Avail Use% Mounted on
udev                    991M     0  991M   0% /dev
tmpfs                   200M  8.1M  192M   5% /run
/dev/sda1                62G  1.5G   61G   3% /
tmpfs                  1000M     0 1000M   0% /dev/shm
tmpfs                   5.0M     0  5.0M   0% /run/lock
tmpfs                  1000M     0 1000M   0% /sys/fs/cgroup
tmpfs                   200M     0  200M   0% /run/user/0
192.168.0.1:/etc/nginx   62G  1.5G   61G   3% /etc/nginx
root@ubuntu:~# mount 192.168.0.1:/var/www/ /var/www/
root@ubuntu:~# df -h
Filesystem              Size  Used Avail Use% Mounted on
udev                    991M     0  991M   0% /dev
tmpfs                   200M  8.1M  192M   5% /run
/dev/sda1                62G  1.5G   61G   3% /
tmpfs                  1000M     0 1000M   0% /dev/shm
tmpfs                   5.0M     0  5.0M   0% /run/lock
tmpfs                  1000M     0 1000M   0% /sys/fs/cgroup
tmpfs                   200M     0  200M   0% /run/user/0
192.168.0.1:/etc/nginx   62G  1.5G   61G   3% /etc/nginx
192.168.0.1:/var/www     62G  1.5G   61G   3% /var/www
```

#### Tạo kết nối từ lúc khởi động cumj:
- `vim /etc/fstab`

```
LABEL=cloudimg-rootfs   /        ext4   defaults        0 0

192.168.0.1:/etc/nginx /etc/nginx nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
192.168.0.1:/var/www /var/www nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0

```


### Sử dụng `lsyncd` đồng bộ WP 
- `sudo apt-get update`
- `sudo apt-get install lsyncd`
- `mkdir /var/log/lsyncd`
- `touch /var/log/lsyncd/lsyncd.{log,status}`
-  `nano /etc/lsyncd/lsyncd.conf.lua`


#### TH 1 Server 

```
settings {
logfile = "/var/log/lsyncd/lsyncd.log",
statusFile = "/var/log/lsyncd/lsyncd-status.log",
statusInterval = 10,
}



sync {
default.rsyncssh,
source="/var/www/",
host="192.168.0.1",
targetdir="/var/www/",
source="/etc/nginx/",
targetdir="/etc/nginx",
delay = 1,
rsync = {
compress = true,
acls = true,
--delete = false, 
verbose = true,
owner = true,
group = true,
perms = true,
rsh = "/usr/bin/ssh -p 22 -o StrictHostKeyChecking=no",
}
}

```

#### TH 2 server

```
serverList = {
 "192.168.0.2",:
 "192.168.0.3",
}


-- be carefull non of them is a parent directory of another
sourceList =
{
        "/var/www/",
        "/etc/nginx",
}

for _, server in ipairs( serverList ) do
  for _, source in ipairs( sourceList ) do
    sync{
          default.rsyncssh,
          delete = 'running',
          source=source,
          host=server,
          targetdir=source,
          delay = 0,
          rsync     = {
              archive  = true,
              compress = true,
              _extra   = {"--omit-dir-times","-e ssh -i /home/lsync/.ssh/id_rsa"}
                      }
        }

  end
end
```

```
settings {
        logfile = "/var/log/lsyncd/lsyncd.log",
        statusFile = "/var/log/lsyncd/lsyncd.status"
}
serverList = {
 "192.168.0.2",
 "192.168.0.3",
}


-- be carefull non of them is a parent directory of another
sourceList =
{
        "/var/www/",
        "/etc/nginx",
}

for _, server in ipairs( serverList ) do
  for _, source in ipairs( sourceList ) do
    sync{
          default.rsyncssh,
          delete = 'running',
          source=source,
          host=server,
          targetdir=source,
          delay = 1,
          rsync     = {
              archive  = true,
              compress = true,
              perms = false, -- Keep the permissions
              owner = false, -- Keep the owner
              _extra   = {"/usr/bin/ssh -l root /root/.ssh/id_rsa -o StrictHostKeyChecking=no"}
                      }
        }

  end
end
```

```
settings {
        logfile = "/var/log/lsyncd/lsyncd.log",
        statusFile = "/var/log/lsyncd/lsyncd.status"
}

sync{
          default.rsync,
          source="/etc/nginx/",
          target="root@192.168.0.2:/etc/nginx/",
          delay = 1,
          rsync     = {
              archive  = true,
              compress = true,
              perms = false, -- Keep the permissions
              owner = false, -- Keep the owner
              rsh = "/usr/bin/ssh -l root -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no"
                      }
     }

sync{
          default.rsync,
          source="/etc/nginx/",
          target="root@192.168.0.3:/etc/nginx/",
          delay = 1,
          rsync     = {
              archive  = true,
              compress = true,
              perms = false, -- Keep the permissions
              owner = false, -- Keep the owner
              rsh = "/usr/bin/ssh -l root -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no"
                      }
     } 

sync{
          default.rsync,
          source="/var/www/",
          target="root@192.168.0.2:/var/www/",
          delay = 1,
          rsync     = {
              archive  = true,
              compress = true,
              perms = false, -- Keep the permissions
              owner = false, -- Keep the owner
              rsh = "/usr/bin/ssh -l root -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no"
                      }
     }

sync{
          default.rsync,
          source="/var/www/",
          target="root@192.168.0.3:/var/www/",
          delay = 1,
          rsync     = {
              archive  = true,
              compress = true,
              perms = false, -- Keep the permissions
              owner = false, -- Keep the owner
              rsh = "/usr/bin/ssh -l root -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no"
                      }
     }
```


- Enable or Disable Services in Ubuntu Systemd/Upstart:
  + `systemctl enable lsyncd`
  + `systemctl enable keepalived`

__Docs__:
- https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mysql-5-6-on-ubuntu-16-04
- https://github.com/hoangdh/ghichep-database/tree/master/Galera_on_Ubuntu

- https://github.com/khanhnt99/internship-2020/blob/master/KhanhNT/Linux/Wordpress/Wordpress-iptables.md

- https://github.com/khanhnt99/internship-2020/blob/master/KhanhNT/Linux/HAProxy-Keepalive/Cluster-WS-lab.md

- https://laptrinhx.com/lam-the-nao-de-thiet-lap-mot-nfs-gan-ket-tren-ubuntu-18-04-3852007090/

- https://www.percona.com/doc/percona-xtradb-cluster/5.7/howtos/crash-recovery.html

- https://www.percona.com/blog/2014/09/01/galera-replication-how-to-recover-a-pxc-cluster//

- https://serverfault.com/questions/212178/chown-on-a-mounted-nfs-partition-gives-operation-not-permitted

- https://groups.google.com/g/lsyncd/c/zzCbWGLssco


