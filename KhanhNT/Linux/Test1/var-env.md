# Biến môi trường 
## 1. Khái niệm
- Biến môi trường của hệ thống Linux là một tập hợp các giá trị động được đặt tên.
- Được lưu trữ trong hệ thống được sử dụng bởi các ứng dụng được khởi chạy trong shell hoặc subshells.
- Xem các biến môi trường hiện có:
 
```
corgi@corgi:~$ env | tail -5
LC_TIME=vi_VN
LC_NAME=vi_VN
XAUTHORITY=/home/corgi/.Xauthority
OLDPWD=/home/corgi/KhanhNT/internship-2020/KhanhNT/Linux
_=/usr/bin/env
```
## 2. Cách thiết lập các biến môi trường trên Linux

- Hiển thị giá trị của 1 biến cụ thể

```
corgi@corgi:~$ echo $PATH
/home/corgi/bin:/home/corgi/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

```
- Xuất 1 giá trị biến mới

```
corgi@ubuntu:~$ export VARIABLE=value
corgi@ubuntu:~$ env
VARIABLE=value
LC_PAPER=vi_VN
XDG_SESSION_ID=1
LC_ADDRESS=vi_VN
LC_MONETARY=vi_VN
TERM=xterm-256color
SHELL=/bin/bash
SSH_CLIENT=10.0.2.2 37984 22
LC_NUMERIC=vi_VN

```

## 3. Biến môi trường `$HOME`
- Là biến môi trường đại diện cho thư mục home của người dùng.
- `~` thường viết tắt cho `$HOME`

```
corgi@ubuntu:~$ echo $HOME
/home/corgi
corgi@ubuntu:~$ pwd
/home/corgi

```

## 4. Biến môi trường `$PATH`
- `PATH` là danh sách các đường dẫn được quét khi lệnh được đưa ra để tìm chương trình hoặc tập lệnh thích hợp để chạy.

```
corgi@ubuntu:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
```


