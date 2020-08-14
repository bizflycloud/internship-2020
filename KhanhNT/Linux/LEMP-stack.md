# LEMP
## 1. LAMP stack
- Nền tảng hosting website sủ dụng chủ yếu Linux.
- Linux, Apache, MySQL, PHP.

### 1.1. Linux: 
- Lớp đầu tiên trong stack. Hệ điều hành cơ sở  nền tảng cho các lớp phần mềm khác.

### 1.2 Apache:
- Phần mềm webserver.
- Chuyển đổi các web browser sang các website chính xác của nó.

### 1.3 MySQL:
- Nơi cơ sở dữ liệu database được lưu trữ

### 1.4 PHP:
-  PHP hoặc các ngôn ngữ lập trình web tương tự

![](https://techvccloud.mediacdn.vn/2018/8/20/lamp-server-1534736942968861711237.png)

## 2. LEMP stack 
- Giống với LAMP
- Khác: Apache được thay thế bởi NGINX

## 3. Cài đặt LEMP
### 3.1 Cài đặt nginx
- `sudo apt-get install nginx`
- `sudo systemctl start nginx.service`
- `sudo systemctl enable nginx.service`
- Truy cập từ máy thật __localhost:8080__

![](https://websiteforstudents.com/wp-content/uploads/2016/11/nginx_default_page.png)

### 3.2 Cài đặt mysql 

- `sudo apt install mysql-server`
- `sudo mysql_secure_installation`
- `sudo mysql`
- `mysql -u root -p`

### 3.3 Cài đặt php-fpm

- `sudo apt install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-zip php-curl`
- Kiểm tra php đã được cài đặt
 - `php -v`
- `sudo nano /var/www/html/phpinfo.php`
- Type and save file
  - `<?php phpinfo( ); ?>`
- `sudo nano /etc/nginx/sites-available/default`

![](https://www.upsieutoc.com/images/2020/08/10/Screenshot-from-2020-08-10-15-17-28.png)

**Reference:**

- `https://websiteforstudents.com/how-to-install-lemp-on-ubuntu-16-04-18-04-18-10/`

- `https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04` 
