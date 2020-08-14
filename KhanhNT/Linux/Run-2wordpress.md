# Install LEMP Stack and run 2 Wordpress 
## 1. Cài đặt Nginx
- `sudo apt-get install nginx`

## 2. Cài đặt mysql
- `sudo apt install mysql-server`
- `sudo mysql_secure_installation`

## 3. Cài đặt php
- `sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip`
- `sudo systemctl restart php7.2-fpm`

## 4. Cài đặt 2 site wordpress

- Tạo 2 trang web là: abc.xxx và abc.yyy

### 4.1 Tạo database trong mysql
-`sudo mysql` or `sudo mysql -u root -p`
- `CREATE DATABASE examplecomdb;`
- `CREATE DATABASE examplenetdb;`
- `GRANT ALL ON examplecomdb.* TO 'examplecomuser'@'localhost' IDENTIFIED BY 'password';`
-`GRANT ALL ON examplenetdb.* TO 'examplenetuser'@'localhost' IDENTIFIED BY 'passwored';`
- `FLUSH PRIVILEGES;`

### 4.2 Tải wordpress
- `wget https://wordpress.org/latest.zip`
- `sudo unzip latest.zip -d /var/www/html/`
- `sudo cp /var/www/html/wordpress /var/www/html/example.com`
- `sudo cp /var/www/html/wordpress /var/www/html/example.net`

**Note: Làm ở cả example.net và example.com**
- Copy the sample configuration file and rename it to wp-config.php.
 + `sudo cp wp-config-sample.php wp-config.php`
- `sudo nano wp-config.php`
![](https://i.ibb.co/0m9yS4G/Screenshot-from-2020-08-15-00-03-56.png)
- `sudo chown $USER:$USER /usr/share/nginx/example.com/ -R`
- `sudo chown $USER:$USER /usr/share/nginx/example.net/ -R`
- `sudo nano /etc/nginx/conf.d/example.com.conf`

server {
  
  listen 80;
  listen [::]:80;
  server_name www.example.com example.com;
  root /usr/share/nginx/example.com/;
  index index.php index.html index.htm index.nginx-debian.html;

  location / {
    try_files $uri $uri/ /index.php;
  }

  error_page 404 /404.html;
  error_page 500 502 503 504 /50x.html;

  location = /50x.html {
    root /usr/share/nginx/html;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
  }

  gzip on;
  gzip_vary on;
  gzip_min_length 1000;
  gzip_comp_level 5;
  gzip_types application/json text/css application/x-javascript application/javascript image/svg+xml;
  gzip_proxied any;

  
  location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
       access_log        off;
       log_not_found     off;
       expires           360d;
  }
  location ~ /\.ht {
      access_log off;
      log_not_found off;
      deny all;
  }
}
- `sudo nginx -t `
- `systemctl reload nginx `

![](https://i.ibb.co/PZ7qLBT/Screenshot-from-2020-08-14-23-46-27.png)

![](https://i.ibb.co/thdZQzj/wpxxx.png)
