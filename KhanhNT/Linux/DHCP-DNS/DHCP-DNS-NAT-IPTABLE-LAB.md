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

```
subnet 192.168.0.0 netmask 255.255.255.0 {
   range 192.168.0.2 192.168.0.30;
   option domain-name-servers 192.168.0.1;
   option domain-name "lan";
   option subnet-mask 255.255.255.0;
   option routers 192.168.0.1;
   option broadcast-address 192.168.0.255;
   default-lease-time 600;
   max-lease-time 7200;
}

host webserver{
     hardware ethernet 50:19:00:01:00:00;
     fixed-address 192.168.0.2;
}

host database{
      hardware ethernet 50:19:00:02:00:00;
      fixed-address 192.168.0.3;
}

host general{
        hardware ethernet 50:19:00:03:00:00;
        fixed-address 192.168.0.4;
}

```





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


~iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT~

~~iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT~~


- ACCEPT gói tin thông qua server từ mạng LAN và cấu hình NAT
```
iptables -A FORWARD -i ens3 -o ens4 -j ACCEPT
iptables -t nat -A POSTROUTING -o ens4 -s 

192.168.0.0/24 -j SNAT --to-source 192.168.17.125

hoặc

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

```
zone "bizflycloud.com"{
      type master;
      file "/etc/bind/db.bizflycloud.com";
};
zone "0.168.192.in-addr.arpa"{
      type master;
      file "/etc/bind/db.bizflycloud.reverse";
};

```


![](https://i.ibb.co/k9nxKN7/Screenshot-from-2020-08-26-10-32-39.png)

![](https://i.ibb.co/6Nmqt8C/Screenshot-from-2020-08-26-10-55-08.png)

- Cấu hình file cấu hình thuận
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

## Bước 4. Web server cài 1 trang wordpress default (Database nằm trên database server)

### 4.1 Cài đặt database Mysql trên Database server
- apt-update
- apt-install mysql-server
- Sửa file /etc/mysql/mysql.conf.d/mysqld.cnf 
  + `vim /etc/mysql/mysql.conf.d/mysqld.cnf`

```
[mysqld_safe]
socket          = /var/run/mysqld/mysqld.sock
nice            = 0

[mysqld]
#
# * Basic Settings
#
user            = mysql
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
port            = 3306
basedir         = /usr
datadir         = /var/lib/mysql
tmpdir          = /tmp
lc-messages-dir = /usr/share/mysql
skip-external-locking
#
# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address            = 192.168.0.3 
# IP database-server
```
- service mysql restart

### 4.2 Cài đặt remote wordpress database
```
- mysql -u root -p
- CREATE DATABASE wordpress;
- CREATE USER 'wordpressuser'@'192.168.0.2' IDENTIFIED BY 'Password@123';
- GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'192.168.0.2';
- FLUSH PRIVILEGES;
- exit
```
### 4.3. Cài đặt wordpress trên web-server 
#### 4.3.1 Đầu tiên kiểm tra web-server đã kết nối được database trên Web server
  + Install mysql client 
     - apt-get update
     - apt-get install mysql-client

```
mysql -u wordpressuser -h 192.168.0.3 -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.31-0ubuntu0.16.04.1 (Ubuntu)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

#### 4.3.2 Cài đặt các gói cần thiết
- apt-get install nginx php-fpm php-mysql
- Sửa file /etc/php/7.0/fpm/php.ini
     + Uncomment dòng cgi.fix_pathinfo=1
     + cgi.fix_pathinfo=0

- service php7.0-fpm restart 

#### 4.3.3 Cấu hình Nginx
- cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
- cat > /etc/nginx/sites-available/example.com
- nano /etc/nginx/sites-available/example.com

```
server {
        listen 80;

        root /var/www/example.com;
        index index.php index.html index.htm;

        server_name example.com;

        error_page 404 /404.html;

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
                root /usr/share/nginx/html;
        }
location / {
                # try_files $uri $uri/ =404;
                try_files $uri $uri/ /index.php?q=$uri&$args;
        }


        location ~ \.php$ {
                try_files $uri =404;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }

location = /favicon.ico {
        access_log off;
        log_not_found off;
        expires max;
}
location = /robots.txt {
        access_log off;
        log_not_found off;
}

# Cache Static Files For As Long As Possible
location ~*
\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$
{
        access_log off;
        log_not_found off;
        expires max;
}
# Security Settings For Better Privacy Deny Hidden Files
location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
}
# Return 403 Forbidden For readme.(txt|html) or license.(txt|html)
if ($request_uri ~* "^.+(readme|license)\.(txt|html)$") {
    return 403;
}
# Disallow PHP In Upload Folder
location /wp-content/uploads/ {
        location ~ \.php$ {
                deny all;
        }
}
}
```
- cd /etc/nginx/sites-enabled/
- unlink default
- ln -s /etc/nginx/sites-available/example.com
- nginx -t

#### 4.3.4 Cài đặt wordpress
- wget http://wordpress.org/latest.tar.gz
- tar xzvf latest.tar.gz
- cd wordpress/
- cp wp-config-sample.php wp-config.php
- Sửa file wp-config.php
   + nano config.php

```
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpressuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'Password@123' );

/** MySQL hostname */
define( 'DB_HOST', '192.168.0.3' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
```

## 5. Bước 5: Từ ngoài gọi đến IP Public của Linux Server Gateway port 80 thì forward vào Webserver 
- Trên linux server-gateway1
  + `iptables -A FORWARD -p tcp --dst 192.168.0.2 --dport 80 -j ACCEPT`
  + `iptables -t nat -A PREROUTING -i ens4 -p tcp -d 192.168.17.125 --dport 80 \-j DNAT --to-destination 192.168.0.2:80  `

![](https://camo.githubusercontent.com/b2aa816034d8dc82a27ee49fa199ffca00a5b1fd/68747470733a2f2f692e6962622e636f2f54764c637630622f53637265656e73686f742d66726f6d2d323032302d30382d32392d31312d33382d30352e706e67)

## Bước 6.  Database server chặn tất cả port 3306 trừ Webserver 192.168.0.2
- iptables -A INPUT -p tcp --src www.bizflycloud.com --dport 3306 -j ACCEPT
- iptables -A INPUT -p tcp -s 192.168.0.2 --dport 3306 -j ACCEPT
- iptables -A INPUT -p tcp --dport 3306 -j DROP


## Bước 7: General Server không được gọi đến 8.8.8.8
- Trên linux server gateway
  + ~iptables -A FORWARD -s 192.168.0.4 -j DROP~
- Trên General Server
  + iptables -A OUTPUT -d 8.8.8.8 -j DROP


## Bước 8: Linux Server Gateway2 có thể gọi đến Webserver nhưng không được gọi đến Database Server và General Server
- ~iptables -A OUTPUT --dst 192.168.0.2 -j ACCEPT~
- ~iptables -A OUTPUT --dst 192.168.0.0/24 -j DROP~
- iptables -A FORWARD -i ens5 -o ens3 -j DROP
- iptables -I FORWARD -i ens5 --dst 192.168.0.2 -j ACCEPT

(ens5: GW1 và GW2, ens3: GW1 và mạng 192.168.0.0/24)

## Lưu iptables
- `iptables-save > /root/myfirewall.conf`
- `iptables-restore < /root/myfirewall.conf`

