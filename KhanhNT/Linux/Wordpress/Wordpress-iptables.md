
# Lab iptables-wordpress

![](https://i.ibb.co/SvpXdGK/Screenshot-from-2020-08-28-17-46-16.png)

## 1. Mục đích
- Kết nối internet cho 3 máy server
- Cài đặt wordpress default trên webserver
- Database trên Databa-server
- Từ ngoài mạng truy cập vào ip public port 80 trỏ vào webserver
- Database chặn tất cả các port 3306 trừ webserver
- General không gọi dc đến 8.8.8.8
- Linuxservergateway2 không truy cập được đến database và general , chỉ truy cập được đến  web-server

## 2. Kết nối internet cho 3 máy client 
### a. Đặt IP như hình vẽ
### b. Trên Linux server gateway
- nano /etc/sysctl.conf
- net.ipv4.ip_forward=1
- Kiểm tra bằng lệnh 
    + sysctl -p /etc/sysctl.conf
    + /etc/init.d/procps restart
-`iptables -t nat -A POSTROUTING -o ens4 -s 192.168.0.0/24 -j MASQUERADE`

![](https://i.ibb.co/r22zYzj/Screenshot-from-2020-08-29-09-57-30.png)
 

## 3. Cài đặt database trên Database server 
- `apt-update`
- `apt-install mysql-server`
- Sửa file /etc/mysql/mysql.conf.d/mysqld.cnf
   + `nano /etc/mysql/mysql.conf.d/mysqld.cnf`

![](https://i.ibb.co/ggy0FpS/Screenshot-from-2020-08-29-10-19-54.png)

- service mysql restart

### Cài đặt remote wordpress database
- `mysql -u root -p`
- `CREATE DATABASE wordpress;`
- ` CREATE USER 'wordpressuser'@'192.168.0.2' IDENTIFIED BY 'Password@123';`
- `GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'192.168.0.2';`
- `FLUSH PRIVILEGES;`
- `exit`

## 3. Cài đặt wordpress trên web-server
- Đầu tiên kiểm tra web-server đã kết nối được database trên Web server 
  + Install mysql client
     - `apt-get update`
     - `apt-get install mysql-client`

- `mysql -u wordpressuser -h database_server_IP -p`

![](https://i.ibb.co/tmWx8fx/Screenshot-from-2020-08-29-10-44-13.png)

## 4. Cài đặt web-server trên web-server 
- Cài đặt các gói cần thiết
  + `apt-get install nginx php-fpm php-mysql`
- Sửa file /etc/php/7.0/fpm/php.ini
  + Uncomment dòng cgi.fix_pathinfo=1
  + `cgi.fix_pathinfo=0`
-  `service php7.0-fpm restart `

## 5. Cấu hình nginx
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

- nginx -t 

## 6. Cài đặt Wordpress
- wget http://wordpress.org/latest.tar.gz
- tar xzvf latest.tar.gz
- cd /wordpress
- nano  wp-config.php
 
```

/** MySQL database password */
define( 'DB_PASSWORD', 'Password@123' );

/** MySQL hostname */
define( 'DB_HOST', '192.168.0.3' );

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
define('AUTH_KEY',         't+gXvghMBRYgJS-.j}ze|qfxuM{GIkG+q/kX?L{nhSe+ s5b}ui0Uj2p.O)y}HSZ');
define('SECURE_AUTH_KEY',  '=kTnTo(emSG(MN=-^~GLZ+K|`;/cP `YUGDP3+kcx!=00QldjF&AI]<|&+-u&5lM');
define('LOGGED_IN_KEY',    'Vd4|;SqTh!+Wiay<|uDXlmaBiKP#OH1]F2DvKLZ0k{u!(?dBqrhk#d8-N?_>pg9>');
define('NONCE_KEY',        'Cw|v[/; ;/Wkh[J0[cRu>#Ro-O7q#i%4e-v46J+gfuwa8!ob0RuuLN@-R(E~qUpC');
define('AUTH_SALT',        'u,>a6i~EmhoCjlz,y>9CVvcE)VrW >b7Q2J}Gps!Pe]X+++]f!4AA:BF;6G6k<$>');
define('SECURE_AUTH_SALT', '~fj!v)uF$I=L_<(Q=+|#by)-+>j66n:N{CY8{WMqzVOU:(kx~*Q59Ick%y^yqT-D');
define('LOGGED_IN_SALT',   'oss8{WkYSBR&<<?+%;%^OACeyb)c/L=3lY-3j^cnEw3Jh#(&/2Z&`iMn.NI-:;K+');
define('NONCE_SALT',       '/5|+F[+[vOk6|Usft%wD1^y,<h~zVudu9H/;eDGO$|,v~9F3Nm6pNZS5`<]8/!sm');

```
- mkdir -p /var/www/example.com
- cp -r ~/wordpress/* /var/www/example.com/
- cd /var/www/example.com
- chown -R www-data:www-data *
- usermod -a -G www-data root
- chmod -R g+rw /var/www/example.com
- service php7.0-fpm restart
- service nginx restart 

![](https://i.ibb.co/TvLcv0b/Screenshot-from-2020-08-29-11-38-05.png) 


## 7. Database chặn port 3306 (Database-server configure)
- iptables -A INPUT -p tcp -s 192.168.0.2 --dport 3306 -j ACCEPT
- iptables -A INPUT -p tcp --dport 3306 -j DROP

# 8. Chặn General server gọi đến internet 8.8.8.8
- Trên linux server gateway
 + iptables -A FORWARD -s 192.168.0.4 -j DROP

Tài liệu tham khảo và fix 1 số lỗi
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-remote-database-to-optimize-site-performance-with-mysql
- https://askubuntu.com/questions/172514/how-do-i-uninstall-mysql
- https://www.scaleway.com/en/docs/deploy-wordpress-with-lemp/
- https://www.digitalocean.com/community/questions/error-permission-denied-publickey-when-i-try-to-ssh







