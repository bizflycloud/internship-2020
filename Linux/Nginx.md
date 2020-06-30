# OS ( Open source)

## 1. OS là gì ?

- Open Source là một sản phẩm bao gồm quyền sử dụng code, tài liệu thiết kế hay nội dung của nó. 
Phong trào nguồn mở là phong trào hỗ trợ sử dụng giấy phép cho các phần mềm. 
Các nhà phát triển và lập trình viên đóng góp những mã code của mình và trao đổi chúng để phát triển phần mềm. 
Thuật ngữ Open Source code không phân biệt bất kỳ nhóm hay cá nhân nào khi lấy hay chỉnh sửa code của OSS

## 1.1Các lưu ý khi cài đặt OS

- Kiểm tra source trước khi cài đặt vì có thể cài từ một trang source lừa đảo.

## 2. Các bước cài đặt 1 OS

# 2.1 Nginx 

## 2.1.1 NginX là gì và dùng để làm gì ?

- Nginx là một máy chủ proxy ngược mã nguồn mở (open source reverse proxy server) sử dụng phổ biến giao thức HTTP, HTTPS, SMTP, POP3 và IMAP , 
cũng như dùng làm cân bằng tải (load balancer), HTTP cache và máy chủ web (web server). 
Dự án Nginx tập trung vào việc phục vụ số lượng kết nối đồng thời lớn (high concurrency), hiệu suất cao và sử dụng bộ nhớ thấp. 
Nginx được biết đến bởi sự ổn định cao, nhiều tính năng, cấu hình đơn giản và tiết kiệm tài nguyên.

## 2.1.2 Cài đặt nginx như thế nào ?

### Trên ubuntu 18.04 LTS

Kiểm tra phiên bản ubuntu thông qua lệnh: `lsb_release -ds`


- B1: Tải xuống source

Có thể tải xuống thông qua lệnh : `wget https://nginx.org/download/nginx-1.15.12.tar.gz

![image](https://user-images.githubusercontent.com/66721505/84874220-80355b80-b0ae-11ea-8e10-b77d21c6e8a4.png)

`
> Note: Lệnh naỳ sẽ thực hiện tải xuống source từ trang chủ nginx.org 



- B2: Giải nén source

Thực hiện giải nén thông qua lệnh `tar -zxvf nginx-1.15.12.tar.gz`


![image](https://user-images.githubusercontent.com/66721505/84874337-a6f39200-b0ae-11ea-8cba-783b2f2bf7d4.png)


Kiểm tra lại thư mục đã được giải nén chưa thông qua lệnh ` ls -l`

![image](https://user-images.githubusercontent.com/66721505/84874418-c1c60680-b0ae-11ea-854f-e9245edacbbc.png)


Tiếp đó chuyển tới thư mực vừa giải nén: `cd nginx-1.15.12/`

![image](https://user-images.githubusercontent.com/66721505/84874471-d60a0380-b0ae-11ea-8515-043a43730e54.png)


- B3: cài Compiler và Dev Tool:

Vì cơ bản nginx được tạo trên code C nên chúng ta cần sử dụng 1 compiler và dev tool thông qua 2 lệnh sau:

```
apt-get install build-essential

apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev
```

Sau đó có thể config nginx thông qua lệnh sau: 

`./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log 
--with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module`

Với 

```
- sbin-path: nơi chạy nginx, dùng để chạy và dừng server
- conf-path: nơi config nginx
- error-log-path: log lỗi trong quá trình chạy nginx
- http-log-path: log trong quá trình chạy
- with-pcre: nói nginx thư viện pcre của hệ thống cho các đoạn code dùng biểu thức chính quy (regular expression)
- process-id-path: dùng để biết các pid của service thứ 3 mình sẽ sử dụng sau này
```

hoặc đơn giản hơn có thể thông qua lệnh: `./configure` 

 và lệnh này sẽ cái các đường dẫn mặc định.

Sau khi chạy xong custom config, thực hiện lệnh compile source như sau

`make && make install`

Nếu không phải root có thể thêm `sudo` ở đầu câu lệnh để tiến hành thực thi lệnh

Ở bước cuối cùng kiểm tra lại 1 lần nữa thông qua lệnh: `nginx -v`

nếu cài đặt thành công sẽ nhận được 1 msg như sau: 

> nginx version: nginx/1.15.12

![image](https://user-images.githubusercontent.com/66721505/84874627-11a4cd80-b0af-11ea-896b-12b8d574ffca.png)


## Tiến hành chạy thử 1 sever

- Vào file config của nginx: `sudo vi /usr/local/nginx/conf/nginx.conf`

![image](https://user-images.githubusercontent.com/66721505/84874863-6a746600-b0af-11ea-93fc-e81e97e7cf59.png)


tiến hành tìm kiếm
```
server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;
```

vào mode insert chỉnh sửa `listen       80` trở thành `listen       8081`

tiếp theo đó nhập lệnh `cd /usr/local/nginx/sbin/`

sau đó tiếp tục nhập lệnh `sudo ./nginx` để bắt đầu chạy service

truy cập trình duyệt web tiến hành nhập ip của máy với port 8081: 

i.e : http://192.168.18.66:8081/

sẽ thấy thông  báo chạy thành công nginx

có thể tiến hành ngừng service thông qua lệnh `sudo ./nginx -s stop`

![image](https://user-images.githubusercontent.com/66721505/84875042-a3143f80-b0af-11ea-9d75-8019039399a2.png)


## 2.2 Openresty

## 2.2.1 Openresty là gì ? dùng để làm gì ?

OpenResty là một máy chủ web mở rộng Nginx bằng cách gộp nó với nhiều mô-đun Nginx và thư viện Lua hữu ích. OpenResty vượt trội trong việc mở rộng các ứng dụng và dịch vụ web

## Cài đặt Openresty như thế nào ?

- B1 : Tải trực tiếp Openresty từ trên trang chủ:

`wget https://openresty.org/download/openresty-1.11.2.2.tar.gz`

![image](https://user-images.githubusercontent.com/66721505/84875528-436a6400-b0b0-11ea-9626-b64d02b566d7.png)


Các phiên bản khác có thể tải thông qua trang : > https://openresty.org

Sau khi tải về, chuyển sang thư mục tải file tar.gz về: 

`cd /home/user/Downloads`

Tiếp đó tiến hành giải nén:

` tar xvf openresty-1.11.2.2.tar.gz`

![image](https://user-images.githubusercontent.com/66721505/84875671-7a407a00-b0b0-11ea-828f-f405ee38cdfc.png)


Chuyển đến file vừa giải nén:

` cd cd openresty-1.11.2.2`

( *Optional*) : Bạn sẽ phải  cài thêm 1 số compiler và thư viện cho openresty: 

```
sudo apt-get install build-essential
sudo apt-get install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl
```

Khi đã ở trong thư mục giải nén, thực hiện lệnh: 
`./configure -j2` - note: j2 - thực hiện 2 công việc cùng lúc

![image](https://user-images.githubusercontent.com/66721505/84875816-ae1b9f80-b0b0-11ea-9c7f-4af89f91df4f.png)


`make -j2` - note: tiến hành compile 

![image](https://user-images.githubusercontent.com/66721505/84876147-1a969e80-b0b1-11ea-8f96-a31c207a0e82.png)


`sudo make install` - tiến hành cài đặt onpenresty

`sudo ufw allow http` - cho phép các kết nối http để máy chủ web hoạt động

`sudo ufw status` - check lại 1 lần nữa trạng thái

`sudo /usr/local/openresty/bin/openresty` - tiến hành bật openresty


`sudo /usr/local/openresty/bin/openresty -s quit` - tiến hành tắt openresty

Và bạn đã hoàn thành cài đặt Openresty !





## Tiến hành tạo 1 script bật nginx khi boot máy

### Sử dụng systemd

Chuyến đến thư mục etc/init.d/

> Note: thư mục này là nơi lưu các script của hầu hết các hệ điều hành Linux hiện này


Tiến hành khởi tạo 1 file script thông qua lệnh nano ( hoặc bạn có thể sử dụng bất kì 1 chương trình text editor nào khác)
` sudo nano nginx-passenger.sh` 

Sau khi màn hình text editor hiện ra, thực hiện chỉnh sửa file với nội dung như sau:

```
#!/bin/bash/
sudo /usr/local/nginx/sbin/nginx
```
![image](https://user-images.githubusercontent.com/66721505/84876391-5d587680-b0b1-11ea-99b7-e742d901ada8.png)


> Note: lệnh `sudo ...` sẽ tiến hành chạy các lệnh binaries của nginx ngay khi bắt đầu boot máy

Sau đó cần cấp quyền  chạy file ( execute )thông qua lệnh : `sudo chmod +x /etc/init.d/nginx-passenger.sh`

sau đó có thể test thông qua lệnh: `sudo /etc/init.d/nginx-passenger.sh`

> Note: Lệnh này sẽ tiến hành chạy script 

Tiếp theo đó chạy thêm lệnh : `sudo update-rc.d nginx-passenger.sh defaults`

> Note: Lệnh `update-rc.d` thực hiện thêm hoặc bớt các lệnh theo kiểu init script


