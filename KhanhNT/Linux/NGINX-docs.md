# NGINX
## 1. Tổng quan về NGINX
- Sản phẩm mã nguồn mở dành cho web server.
- Là 1 reverse proxy cho các giao thức HTTP, SMTP, POP3, IMAP.

![](https://topdev.vn/blog/wp-content/uploads/2019/04/ad1ad442-f39b-49b9-81ad-1102c8a7ccf6.jpg)

## 2. Cách hoạt động:
- Cách 1 web server hoạt động:
 - Khi gửi yêu cầu mở 1 trang web:
    - Trình duyệt sẽ liên lạc với server chứa website đó.
    - Server sẽ tìm đúng file yêu cầu của trang đó để gửi ngược về server. 
    - Ví dụ trên là 1 Single thread: Web server truyền thống tạo thread cho mỗi request.
- NGINX hoạt động:
 - Kiến trúc bất đồng bộ (asynchoronous)
 - Những thread tương đồng nhau sẽ quản lí trong 1 tiến trình.
 - Tiến trình hoạt động chứa các worker connections. Chịu trách nhiệm xử lí các thread.
 - Worker connections sẽ gửi các truy vấn cho 1 worker process, worker process gửi đến master process. Master process trả kết quả cho những yêu cầu đó,.

## 3. Cài đặt NGINX from source
- Môi trường ubuntu 16.04 virtual-box

- NGINX viết bằng C, cài đặt tool biên dịch

`sudo apt install -y build-essential git tree`

- Tải NGINX source code vào package liên quan rồi giải nén

`wget https://nginx.org/download/nginx-1.15.0.tar.gz && tar zxvf nginx-1.15.0.tar.gz`

# PCRE version 8.42
`wget https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz && tar xzvf pcre-8.42.tar.gz`

# zlib version 1.2.11
`wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz`

# OpenSSL version 1.1.0h
`wget https://www.openssl.org/source/openssl-1.1.0h.tar.gz && tar xzvf openssl-1.1.0h.tar.gz `

- Cài optional phụ thuộc

`sudo add-apt-repository -y ppa:maxmind/ppa`

`sudo apt update && sudo apt upgrade -y `

`sudo apt install -y perl libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev`


`cd ~/nginx-1.15.0`

`sudo cp ~/nginx-1.15.0/man/nginx.8 /usr/share/man/man8`

`sudo gzip /usr/share/man/man8/nginx.8`

`ls /usr/share/man/man8/ | grep nginx.8.gz`

#### Check that Man page for NGINX is working:

man nginx

- Configure, compile and install NGINX:

./configure --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/usr/lib/nginx/modules \
            --conf-path=/etc/nginx/sites-enabled \
            --error-log-path=/var/log/nginx/error.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock \
            --user=nginx \
            --group=nginx \
            --build=Ubuntu \
            --builddir=nginx-1.15.0 \
            --with-select_module \
            --with-poll_module \
            --with-threads \
            --with-file-aio \
            --with-http_ssl_module \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_xslt_module=dynamic \
            --with-http_image_filter_module=dynamic \
            --with-http_geoip_module=dynamic \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_auth_request_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_slice_module \
            --with-http_stub_status_module \
            --with-http_perl_module=dynamic \
            --with-perl_modules_path=/usr/share/perl/5.26.1 \
            --with-perl=/usr/bin/perl \
            --http-log-path=/var/log/nginx/access.log \
            --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
            --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
            --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --with-mail=dynamic \
            --with-mail_ssl_module \
            --with-stream=dynamic \
            --with-stream_ssl_module \
            --with-stream_realip_module \
            --with-stream_geoip_module=dynamic \
            --with-stream_ssl_preread_module \
            --with-compat \
            --with-pcre=../pcre-8.42 \
            --with-pcre-jit \
            --with-zlib=../zlib-1.2.11 \
            --with-openssl=../openssl-1.1.0h \
            --with-openssl-opt=no-nextprotoneg \
            --with-debug

`make`

`make install`

`cd ~`

`sudo ln -s /usr/lib/nginx/modules /etc/nginx/modules`

`sudo adduser --system --home /nonexistent --shell /bin/false --no-create-home --disabled-login --disabled-password --gecos "nginx user" --group nginx`

`sudo vim /etc/systemd/system/nginx.service`

- file nginx.service:

[Unit]
Description=nginx - high performance web server

Documentation=https://nginx.org/en/docs/

After=network-online.target remote-fs.target nss-lookup.target

Wants=network-online.target

[Service]

Type=forking

PIDFile=/var/run/nginx.pid

ExecStartPre=/usr/sbin/nginx -t -c /etc/nginx/sites-enabled

ExecStart=/usr/sbin/nginx -c /etc/nginx/sites-enabled

ExecReload=/bin/kill -s HUP $MAINPID

ExecStop=/bin/kill -s TERM $MAINPID

[Install]
WantedBy=multi-user.target

`sudo systemctl enable nginx.service`
 
`sudo systemctl start nginx.service`

`curl -I 127.0.0.1`


![](https://i.ibb.co/Wv6cgkk/Screenshot-from-2020-08-08-16-42-16.png)

![](https://i.ibb.co/QQrgNYr/Screenshot-from-2020-08-08-17-06-16.png)

