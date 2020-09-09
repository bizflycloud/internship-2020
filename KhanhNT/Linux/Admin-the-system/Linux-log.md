# Linux logging
## 1. Log
### 1.1. Log là gì?
- File log là 1 tập hợp các bản ghi mà Linux duy trì để admin theo dõi.
- File log sẽ chứa thông báo về máy chủ, bao gồm kernel, dịch vụ và ứng dụng đang chạy trên nó.
- File log trong thư mục `/var/log`

### 1.2. Các loại file log (4)
- Application Logs: Nhật kí ứng dụng
- Event Logs: Nhật kí sự kiện
- Service Logs: Nhật kí dịch vụ
- System Logs: Nhật kí hệ thống

### 1.3 Các file log quan trọng

#### 1.3.1. `/var/log/messages`
- `cat /var/log/messages` hoặc `cat /var/log/syslog`
- Chứa nhật kí hoạt động của hệ thống (system logs)
- Xem file log này để theo dõi các lỗi khởi động, lỗi dịch vụ và các thông báo ghi lại trong quá trình khởi động hệ thống.

#### 1.3.2. `/var/log/auth.log` (`var/log/secure` đối với RedHat)
- Chứa thông tin xác thực hệ thống.
- Log về SSH


#### 1.3.3. `/var/log/boot.log`
- Lưu trữ các thông tin liên quan đến khởi động hệ thống.
- Liên quan đến shutdơn máy không đúng cách, lỗi khởi động.

#### 1.3.4. `/var/log/dmesg`
- Thông tin về các thiết bị phần cứng và trình điều khiển.

#### 1.3.5. `/var/log/kern.log`
- Chứa các thông tin ghi bởi kernel.

#### 1.3.6. `/var/log/faillog`
- Chứa các thông tin người dùng đăng nhập thất bại.

#### 1.3.7 `/var/log/cron`
- Lưu thông tin về `cron`

#### 1.3.8. `/var/log/dpkg.log`
- Ghi lại thông tin gói được cài đặt hoặc gỡ bỏ.

### 1.4. Vai trò của log
- TroubleShooting trong quá trình cài đặt các service.
- Tra cứu nhanh các thông tin của hệ thống.
- Truy vết các event đã và đang xảy ra

## 2. Các câu lệnh log hay dùng 
- Xem file log realtime 
   + `tail -f`.
- Log thông tin với `grep`
   + `cat /var/log/cron | grep ...`
- `grep -Rin "<key_word>" /var/log`


**Tài liệu tham khảo**
- https://blogd.net/linux/cac-file-log-quan-trong-tren-linux/ 
- https://quantrimang.com/he-thong-ghi-log-trong-unix-linux-157655
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan3/
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan1/
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan2/



