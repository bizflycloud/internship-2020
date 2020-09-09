# 7 init runlevel trong Linux
## 1. Init là gì?
- Khi kernel được khởi chạy xong, nó sẽ call 1 chương trình với tên chung là init (ID=1)
- Chương trình đảm nhận công việc: bật, tắt, restart các chương trình cần bật lên cùng máy tính (phần mềm quản lí kết nối mạng, chương trình giao diện).
- Init là tên chung chỉ các chương trình được Kernel chạy đầu tiên khi khởi động máy tính.

## 2. Các init phổ biến
- SysV
- Úpstart
- Systemd

### 2.1 Systemd
#### 2.1.1 Tổng quan
- Chương trình quản lí (bật/tắt/khởi động) các dịch vụ dựa trên máy từ lúc bật đến khi tắt máy.
- Quản lí system cụ thể:
   + hostname
   + loopback interface
   + /sys/proc...
- systemd là process chạy đầu tiên trong máy (ID=1)

#### 2.1.2 Khái niệm liên quan
- Systemd quản lí các `unit`
- Unit sẽ được cấu hình trong 1 unit file, thường trong thư mục:
   + `/etc/systemd/system`: file config do người dùng thêm
   + `/lib/systemd/system`: unit file do phần mềm cài vào.
- Unit `service` là unit sẽ quản lí 1 chương trình khởi động khi bật máy và luôn chạy ở chế độ nền và gọi là `daemon`.

#### 2.1.3 Systemctl
- `systemctl` là câu lệnh giám sát và điều khiển, cụ thể nó tương tác với các unit

`systemctl -t service | head -n3`

#### 2.1.4 Điều khiển 1 service
- `systemctl start <>`
- `systemctl stop <>`
- `systemctl status <>`
- `systemctl restart <>` : chạy stop rồi start lại service

#### 2.1.5 Các thành phần của Systemd
- `systemctl`: quản lí tạng thái dịch vụ của hệ thống.
- `journald`: quản lí nhật kí hoạt động của hệ thống (ghi log).
- `logind`: quản lí việc đăng nhập và đăng xuất cảu người dùng.
- `networkd`: quản lí các kết nối mạng thông qua cấu hình mạng.
- `timedated`: quản lí thời gian hệ thống hoặc thời gian mạng.
- `udev`: quản lí các thiết bị và firmware.

### 2.2 Run level /etc/inittab
- Run level 0: Shutdown hệ thống.
- Run level 1: Level dùng cho 1 người dùng để sửa lỗi tập tin.
- Run level 2: Không sử dụng.
- Run level 3: Level dùng cho nhiều người dùng nhưng chỉ ở dạng text, không có giao diện.
- Run level 4: không sử dụng.
- Run level 5: Giao diện dùng cho nhiều người dùng và có giao diện đồ họa.
- Run level 6: Level Reboot hệ thống. 

- Sau khi xác định run level. Chương trình /sbin/init sẽ thực thi các file startup script được đặt trong thư mục `/etc/rc.d`

```
corgi@corgi:~$ ls -l /etc/rc
rc0.d/    rc2.d/    rc4.d/    rc6.d/    rcS.d/    
rc1.d/    rc3.d/    rc5.d/    rc.local 
```
```
corgi@corgi:~$ ls -l /etc/rc1.d
lrwxrwxrwx 1 root root  18 Th08 20 22:22 K03virtlogd -> ../init.d/virtlogd
lrwxrwxrwx 1 root root  17 Th08 20 22:22 K05rsyslog -> ../init.d/rsyslog
-rw-r--r-- 1 root root 369 Th01 20  2016 README
lrwxrwxrwx 1 root root  19 Th07  8 16:47 S01killprocs -> ../init.d/killprocs
lrwxrwxrwx 1 root root  16 Th07  8 16:47 S02single -> ../init.d/single
```
- Tập tin bắt đầu bằng chữ `S`: thực thi khi khởi động hệ thống.
- Tập tin bắt đầu bằng chữ `K`: thực thi khi kết thúc hệ thống.

__Tài liệu tham khảo__
- https://techtalk.vn/blog/posts/7-init-runlevel-cua-he-thong-linux
- https://tuts-linux.blogspot.com/2014/09/lenh-init-trong-linux.html
- FAMILUG: 7 init runlevel của hệ thống Linux


