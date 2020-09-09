# Syslog

## 1. Khái niệm
- Syslog là giao thức dùng để xử lí các file log trong Linux.
- File log có thể ở trong chính máy đó hoặc di chuyển sang 1 máy khác. 
- Đặc điểm:
   + Syslog có thể gửi qua UDP hoặc TCP.
   + Các dữ liệu log được gửi dưới dạng cleartext.
   + Syslog mặc định dùng cổng 514.
- Syslog là 1 `giao thức` và được sử dụng bởi dịch vụ __Rsyslog__.
- __Rsyslog__ đưa ra các quyết định sử dụng port nào vận chuyển log, sau bao lâu log được xoay vòng...

```
syslog: giao thức dùng để xử lí file log trong Linux

Rsyslog: Dịch vụ sử dụng Syslog
```
## 2. Cấu hình Syslog 
- Trong Ubuntu:
  + File cấu hình `/etc/rsyslog.conf`
  + Các rule được định nghĩa trong file: `/etc/rsyslog.d/50-default.conf`

```
#cron.*				/var/log/cron.log
#daemon.*			-/var/log/daemon.log
kern.*				-/var/log/kern.log
#lpr.*				-/var/log/lpr.log
mail.*				-/var/log/mail.log
#user.*				-/var/log/user.log
```
- File cấu hình cho ta thấy nơi lưu log của các service trong hệ thống.

## 3. Mức cảnh báo của Log (Severity Level)

| Code | Mức cảnh báo | Ý nghĩa |
|------|--------------|---------|
|0|emerg|Tình trạng khẩn cấp|
|1|alert|Hệ thống cần can thiệp ngay|
|2|crit|Tình trạng nguy kịch|
|3|error|Lỗi hệ thống|
|4|warn|Mức cảnh báo đối với hệ thống|
|5|notice|Chú ý với hệ thống|
|6|info|Thông tin hệ thống|
|7|debug|Quá trình kiểm tra hệ thống|

## 4. Log Rotation
- Để tránh các file log trở nên cồng kềnh và khó kiểm soát, một hệ thống quay vòng các log file được cài đặt (a log file rotation scheme).
- `Cron` sẽ đưa ra các lệnh để thiết lập những log files mới, file cũ được thêm 1 con số ở hậu tố.
- Tiện ích thi hành `rotation` là `logrorate`.
  + `cat /etc/logrotate.conf`

```
corgi@ubuntu:~$ cat /etc/logrotate.conf 
# see "man logrotate" for details
# rotate log files weekly
weekly 

# use the syslog group by default, since this is the owning group
# of /var/log/syslog.
su root syslog

# keep 4 weeks worth of backlogs
rotate 4

# create new (empty) log files after rotating old ones
create

# uncomment this if you want your log files compressed
#compress

# packages drop log rotation information into this directory
include /etc/logrotate.d

# no packages own wtmp, or btmp -- we'll rotate them here
/var/log/wtmp {
    missingok
    monthly
    create 0664 root utmp
    rotate 1
}

/var/log/btmp {
    missingok
    monthly
    create 0660 root utmp
    rotate 1
}

# system-specific logs may be configured here
```

trong đó
```
weekly: hệ thống quay vòng log files hàng tuần
rotate 4: Lưu lại thông tin log đáng giá trong 4 tuần
Rotation được thiết lập cho 2 file /var/log/wtmp và /var/log/btmp
```



**Tài liệu tham khảo**
- https://blogd.net/linux/cac-file-log-quan-trong-tren-linux/ 
- https://quantrimang.com/he-thong-ghi-log-trong-unix-linux-157655
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan3/
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan1/
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan2/



