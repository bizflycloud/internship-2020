# Manager software
========================================================================
## Packages:
+ Package files: đơn vị cơ bản nhất của 1 package, là một dạng file chứa tất cả thông tin cần thiết để cài đặt chương trình  
+ Repository: Nơi tập chung chứa các package file, một distribution có thể có vài repo với các mục đích khác nhau
+ Dependencies: 1 package rất ít khi mang tính standalone mà nó thường được xây dựng trên các package khác, gói chứa meta-data, cho phép ứng dụng và phụ thuộc được cài đặt với 1 lệnh, cho phép hệ điều hành quản lí bản cập nhật các gói
+ 2 loại package system phổ biến : Debian và Red Hat
+ Binary package: Các gói được chuẩn bị trên hệ thống để cài đặt dễ dàng hơn

#### Tool:
+ Low-level package tool: chịu trách nhiệm cho các tác vụ như install, remove
+ High-level package tool: xử lí tác vụ liên quan tìm kiếm thông tin và cài đặt dependencies

============================================================================================
## Chương trình nén và giải nén trong linux
+ Nén file có đuôi .gz <gzip>
    - Nén: gzip <tên file>
    - Kiểm tra: gzip -l <ten file đã nén> 
    - Giải nén: gzip -d filename
+ Zip
    -Nén: zip filename.zip filename1 filename2: filename.zip là file zip được tạo từ việc nén filename1 và filename2
    - zip -r test.zip folder1: nén toàn bộ folder và các file bên trong
    - Giải nén: unzip filename
+ Tar
        - c: tạo file lưu trữ
        - x: giải nén file lưa trữ
        - z: nén với gzip
        - j: nén với bunzip2
        - f: chỉ đến file lưu trữ sẽ tạo
        - v: hiện thị tập tin đang làm việc lên màn hình
    -  Giải nén file tar: tar -xvf filename.tar
    - Với file nén zip: tar -xzvf filename.tar.gz
                  tar -xjvf filename.tar.bz2
========================================================================================
## Debian package
+ dpkg:
    - Công cụ cài đặt gói Debian có sẵn (không cần tải bất kì thứ gì), sử dụng tùy chọn -i hoặc -install
    - Giải nén dpkg --unpack filename.deb
    - Khi bị trùng tệp --force-overwrite
    - Xóa gói dpkg -r or --remove
    - dpkg -L: hiển thị các gói 
        + apt, apt-get, aptitude
    - Cài đặt sudo apt install <app name>
    - -purge hoặc apt remove để xóa các tệp cấu hình
    - apt-get update: đọc tập tin /etc.apt.source.list và cập nhật dữ liệu hệ thống gói sẵn để cài đặt
    - apt-get upgrade: nâng cấp các gói có bản cập nhật có sẵn  
=============================================================================
### Cài đặt 1 chương trình từ source trên Linux
+ Cài mã nguồn của gói (định dạng file .gz hoặc .bz2)
+ Giải nén bằng gunzip hoặc bunzip2, hoặc tar -xvf, tar -zxvf
+ Tìm tập tin install có phần hướng dẫn cài đặt 
+ Hầu hết tuần tự theo các bước sau
	- ./configure
	- make
	- make install
+ Sau khi thực hiện lệnh make xong thì toàn bộ mã nguồn của gói đã được biên dịch sang dạng thực thi 
+ Nhưng các file thực thi vẫn còn trên thư mục
+ Thực hiện thêm lệnh "make install" để chép các file thực thi đó sang vị trí của nó trên hệ thống
+ /usr/bin chứa các file thực thi cho các gói đã cài đặt trên máy
