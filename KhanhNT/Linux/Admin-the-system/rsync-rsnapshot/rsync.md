# Rsync
## 1. Khái niệm
- `Rsync (Remote Sync)` là 1 công cụ dùng để sao chép và đồng bộ file/thư mục phổ biến.
- Thường dùng để đồng bộ dữ liệu giữa server và local hoặc giữa các server với nhau.

## 2. Tính năng
- `Rsync` hỗ trợ copy giữ nguyên thông số của file/folder như:
   + `Symbolic links`
   + `Permissions`
   + `TimeStamp`
   + `Owner và Group`

## 3. Sử dụng Rsync
- Cài đặt
  + `sudo apt-get install rsync`
- Cú pháp 
  + `rsync options source destination`
- Đồng bộ hóa trên local 

```
root@ubuntu:~/dir1# ls
a.txt  b.txt

root@ubuntu:~# rsync -r dir1/ dir2

root@ubuntu:~/dir2# ls
a.txt  b.txt
```

```
root@ubuntu:~# rsync -r -v -a dir1/ dir2
sending incremental file list
./
a.txt
b.txt

sent 161 bytes  received 57 bytes  436.00 bytes/sec
total size is 0  speedup is 0.00
root@ubuntu:~# 
```
- Các option
 + `-v`: Hiển thị trạng thái kết quả.
 + `-r`: copy dữ liệu nhưng không đảm bảo thông số
 + `-a`: copy nhưng giữ nguyên thông số
 + `-z`: nén dữ liệu transfer (tiết kiệm băng thông nhưng tốn thêm 1 chút tgian)
 + `-h`: output kết quả đọc
 
- Copy file và thư mục giữa các server
 
```
root@ubuntu:~# rsync -avz dir1/ root@192.168.17.44:/home/
root@192.168.17.44's password: 
sending incremental file list
./
a.txt
b.txt

sent 155 bytes  received 57 bytes  38.55 bytes/sec
total size is 0  speedup is 0.00
root@ubuntu:~# 
```

```
root@ubuntu:/home# ls
a.txt  b.txt
root@ubuntu:/home# 

```
- Hiển thị tiến trình khi transfer dữ liệu `rsync`

```
root@ubuntu:~# rsync -avz --progress dir2/ root@192.168.17.44:/root
root@192.168.17.44's password: 
sending incremental file list
./
a.txt
              0 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=1/3)
b.txt
              0 100%    0.00kB/s    0:00:00 (xfr#2, to-chk=0/3)

sent 155 bytes  received 57 bytes  60.57 bytes/sec
total size is 0  speedup is 0.00
```

- `--include 'R*'`: Các file bắt đầu bằng R
- `--exclude '*'`: các file và thư mục còn lại 
- Copy từ Remote server về Local
 + In local
  
```
root@ubuntu:~# rsync -avzh --progress root@192.168.17.50:/root/test /root
Enter passphrase for key '/root/.ssh/id_rsa': 
receiving incremental file list
test/
test/c.txt
              0 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=1/3)
test/d.txt
              0 100%    0.00kB/s    0:00:00 (xfr#2, to-chk=0/3)

sent 66 bytes  received 166 bytes  35.69 bytes/sec
total size is 0  speedup is 0.00
root@ubuntu:~# 
```

- `Rsync qua SSH
  + `rsync -avzhe ssh root@x.x.x.x:/root/install.log /tmp/`
  + Copy từ Local lên Remote server SSH
     - `rsync -avzhe ssh --progress /home/folder root@x.x.x.x:/root/folder`

- Cấu hình băng thông qua truyền tải:
  + `rsync --bwlimit=100 -avzhe ssh /var/lib/rpm root@x.x.x.x:/root/tmp`


__(192.168.17.50: ip server)__

**Tài liệu tham khảo**
- https://viblo.asia/p/rsync-command-dong-bo-du-lieu-tren-linux-djeZ1R7YlWz
