# LEMP stack and Wordpress
___
## Mục lục
- [1. Introduction](#1)
	- [1.1. LAMP stack là gì ?](#1.1)
	- [1.2. LEMP stack là gì ?](#1.2)
	- [1.3. Wordpress](#1.3)
- [2. Install LEMP stack on Ubuntu 18.04](#2)
	- [2.1. Implementation](#2.1)
		- [a. Install nginx web server](#a)
		- [b. Install MySQL để quản lí dữ liệu](#b)
		- [c. Install and configure PHP](#c)
- [3. Install Wordpress](#3)
	- [3.1. Tạo 1 database và user cho Wordpress](#3.1)
	- [3.2. Install thêm một số PHP extensions](#3.2)
	- [3.3. Download Wordpress](#3.3)
	- [3.4. Configure Wordpress](#3.4)
	- [3.5. Hoàn thành việc install thông qua Web interface](#3.5)
- [References](#references)

### 1. Introduction

#### 1.1. LAMP stack là gì ? 
> **LAMP stack** là một bộ **open-source software** được dùng để tạo các websites và các website applications. **LAMP** là viết tắt của Linux, Apache, MySQL và PHP.

![](https://i.stack.imgur.com/IhvAT.png)

\- Trong đó : 

+ **Linux** : là stack đầu tiên, là hệ điều hành - cơ sở nền tảng cho stack này.
+ **Apache** : đây là **web server**, chịu trách nhiệm cho việc chuyển đổi từ ***web browser*** tới ***correct websites*** - cung cấp cơ chế **get web page** tới người dùng.
+ **MYSQL** : nơi lưu trữ cơ sở dữ liệu db- và chúng ta có thể **query** tới db này bằng các scripts.
+ **PHP** : là ngôn ngữ lập trình trên server được phát triển cho việc phát triển các websites và các ứng dụng websites.


#### 1.2. LEMP stack là gì ?
> Các thành phần trong **LEMP** stack cũng tương tự như **LAMP** stack. ĐIểm khác là **apache** được thay thế bằng **nginx** 

**NOTE** : **nginx** được đọc là ***engine-x***, điều này giải thích cho chữ **E** trong **LEMP**.

![](https://www.cloudways.com/blog/wp-content/uploads/nginx-vs-apache.png)

Kết luận, về cơ bản thì **nginx** xử lí các requests nhanh hơn và chịu tải tốt hơn rất nhiều so với **apache** khi sử dụng cùng lượng tài nguyên như : RAM, CPU,..

#### 1.3. Wordpress
\- **Wordpress** là một open-source **CMS** ( Content Management System ) được viết bằng PHP, sử dụng MySQL ( Database management system ) - cho phép user xây dựng dynamic web và blogs.

\- **CMS** (Content Management System) là phần mềm lưu trữ trữ data như text, photos, music, document,..

\- **CMS** đóng vài trò quan trọng trong việc **control** và **management** website : 

+ Tạo, lưu trữ nội dung trên websites
+ Chỉnh sửa, thêm, bơt nội dung
+ Chuyển, chia sẻ nội dung
+ Quản lí, phân quyền người dùng 

### 2. Install LEMP stack on Ubuntu 18.04
#### 2.1. Implementation
###### a. Install nginx web server
Ta thực hiện command-line sau : 
```
sudo apt-get install nginx
```

Sau đó, ghi địa chỉ trên web brower để truy cập nginix's default page :
```
http://server_domain_or_IP
```

Nếu nhìn thấy hình ảnh dưới đây là chúng ta đã thực hiện install thành công nginx : 

![](https://assets.digitalocean.com/articles/lemp_ubuntu_1604/nginx_default.png)

###### b. Install MySQL để quản lí dữ liệu
Bây giờ chúng ta đã có một web server, chúng ta cần install MySQL ( a Database management system) để chứ và quản lí dữ liệu cho website.

\- Thực hiện command-line
```
sudo apt-get install mysql-server
```

###### c. Install and configure PHP 
\- PHP là ngôn ngữ khởi tạo **dynamic content**. Nó chạy các dòng codes, connect tới MySQL database để lấy data và đưa content đó tới web server để hiển thị.

**NOTE** : Vì `nginx` không chứa **native PHP processing** giống như các web servers khác, nên chúng ta cần install `php-fpm` (fastCGI process manager). Việc sử dụng module này giúp **pass** PHP requests tới `php-fpm` để xử lí.

\- Install `php-mysql` để communicate với `mysql-server` : 
```
sudo apt install php-fpm php-mysql
```

Lúc này, chúng ta đã có đủ các thành phần yêu cầu cho `LEMP stack` (Linux, nginx, MySQL, PHP). Nhưng chúng ta vẫn cần thực hiện một vài **configurations** để nói với `nginx` để sử dụng PHP processor cho **dynamic content**.

\- Chúng ta thực hiện bằng cách tạo một file cấu hình server trong `/etc/nginx/sites-avalable`. Ở đây, ta sẽ tạo một file có tên là `linhvcc.com` bằng command-line :
```
sudo nano /etc/nginx/sites-available/linhvcc.com
```

Việc tạo file này chúng ta không cần thay đổi file `default` file cấu hình trong cùng thư mục đó. Copy file cấu hình sau đây vào `/etc/nginx/sites-available/linhvcc.com`
```
server {
        listen 80;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name linhvcc.com;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}
```

\- Trong đó : 
+ **listen** : định nghĩa port mà Nginx sẽ listen on. Trong trường hợp trên là port 80, default port cho HTTP.
+ **root** : định nghĩa *document root* nơi các file phục vụ cho những thông tin mà các website cung cấp.
+ **index** : cấu hình nginx để ưu tiên những file được đặt tên là `index.php` khi 1 index file được request.
+ **server_name** : trỏ đến server's domain name hoặc Ip
+ **location /** : gồm chỉ thị `try_file**, sẽ kiểm tra các file đang tồn tịa có match với URL requests hay không. Nếu không trả về ***404 error***.
+ **location ~ \.php$** : block này xử lí tất cả quá trình PHP bằng cách trỏ ngĩn tới file cấu hình `fastcgi-php.conf` và file `php7.2-fpm.sock` - cái khởi tạo socket cùng với `php-fpm`.
+ **location ~ /\.ht** : block này xử lí `.htaccess` file - nginx không xử lí file mày. Việc thêm chỉ thị `deny all`, nếu bất kì files `.htaccess` nào xuất hiện để tìm vào `document rôt` thì chúng sẽ bị reject.

Sau khi thêm nội dung này, save và đóng file lại. Chúng ta sẽ enable server block bằng việc tạo [**symbolic link**](https://www.hostinger.vn/huong-dan/symbolic-link/) từ server block configuration flie vừa tạo trong `/etc/nginx/sites-available/` tới `/etc/nginx/sites-enabled/` bằng command-line sau : 
```
sudo ln -s /etc/nginx/sites-available/linhvcc.com /etc/nginx/sites-enabled/
```

Sau đó, unlink **default configuration file** trong `/sites-enabled/` : 
```
sudo unlink /etc/nginx/sites-enabled/default
```

Để kiểm tra file cấu hình mới xem có lỗi syntax hay không ta sử dụng command-line : 
```
sudo nginx -t
```

Cuối cùng, chúng ta thực hiện reload lại `nginx` để cập nhật cấu hình : 
```
sudo systemctl reload nginx
```

\- Test PHP processor and nginx
+ Tạo 1 file `info.php` 
```
sudo nano /var/www/html/info.php
```

Sau đó, thêm đoạn code sau vào trong file vừa tạo : 
```
<?php
phpinfo();
```

Bây giờ, chúng ra có thể vào web browser để truy cập thông qua :
```
http://your_server_domain_or_IP/info.php
```

Nếu nhìn thấy kết quả như hình dưới đây, có nghĩa chúng ta đã thiết lập PHP processing cùng nginx thành công.


### 3. Install Wordpress
`Wordpress` sử dụng MySQL để quản lí và chứa dữ liệu, thông tin. Trước đó, chúng ta đã install MySQL, tiếp theo ta sẽ tạo 1 database và 1 user cho Wordpress.

##### 3.1. Tạo 1 database và user cho Wordpress.
\- Đăng nhập vào MySQL : 
```
sudo mysql
```

\- Tạo database cho Wordpress : 
```
mysql> CREATE DATABASE wordpress;
```

\- Tạo `wordpressUser` user cùng với password truy cập để operate database `wordpress` : 
```
CREATE USER wordpressUser@localhost IDENTIFIED BY '12345678';
```

\- Cấp quyền cho `wordpressUser` user để truy cập, moddify `wordpress` database " 
```
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressUser@localhost;
```

##### 3.2. Install thêm một số PHP extensions.
\- Thực hiện command-line : 
```
sudo apt update
sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
```

\- Restart **PHP-fpm** process để PHP processor tận dụng những tính năng mới vừa tải : 
```
sudo systemctl restart php7.2-fpm
```

##### 3.3. Download Wordpress
\- Thực hiện command-line sau để download, giải nén và lưu wordpress trong /Download
```
cd ~/Downloads/ && wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
```

##### 3.4. Configure Wordpress
\- Di chuyển đến folder wordpress : 
```
cd ~/wordpress
```

\- Có một sample configuration file có tên là `wp-config-sample.php`, chúng ta cần copy nó tới default configuration file `wp-config.php` để Wordpress có thể đọc được, vì file default thuộc document root
```
cp wp-config-sample.php wp-config.php
```

\- Mở file `wp-config.php` : 
```
sudo nano wp-config.php`
```

\- Tìm đến các giá trị như dưới đây và thay đổi các parameters mà chúng ta đã thiết lập ở phía trên : 

```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpressUser' );

/** MySQL database password */
define( 'DB_PASSWORD', '12345678' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

```

\- Copy toàn bộ file và folder trong `wordpress` tới `/var/www/html : 
```
~/Downloads/wordpress$ sudo cp -r * /var/www/html/
```

\- Chúng ta cần thay đổi ownership của files để tăng cường bảo mật 
```
sudo chown -R www-data:www-data /var/www
```

##### 3.5. Hoàn thành việc install thông qua Web interface.
\- Truy cập vào wordpress thông qua IP của web server với port 80 : http://192.168.76.89/
![]()

\- ĐIền thông tin cần thiết. Khi hoàn tất, nhấn `install` ở bên dưới. Ta sẽ có giao diện Wordpress như hình dưới : 
![]()

\- Sử dụng theme mới : 
![]()
## References
+ [LAMP stack](https://stackoverflow.com/questions/10060285/what-is-a-lamp-stack#:~:text=A%20LAMP%20Stack%20is%20a%20set%20of%20open%2Dsource%20software,and%20the%20PHP%20programming%20language.)

+ [Different between LAMP and LEMP stack](https://www.javatpoint.com/difference-between-apache-and-nginx#:~:text=Let's%20see%20the%20difference%20between,server%20and%20reverse%20proxy%20server.&text=In%20Apache%2C%20single%20thread%20is,Nginx%20can%20handle%20multiple%20connections.)

+ [Installation LEMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04)

+ [Installation Wordpres](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04#step-2-%E2%80%94-installing-additional-php-extensions)
