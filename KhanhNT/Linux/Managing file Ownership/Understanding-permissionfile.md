# Phân quyền cho 1 file/thư mục
## 1. Khái niệm:
- 3 quyền hạn cơ bản của 1 user/group trên file/folder bao gồm:
   + __r__ (read)- Quyền đọc file. (4)
   + __w__ (write)- Quyền ghi, sửa nội dung file. (2)
   + __x__ (execute)-Quyền thực thi(truy cập) thư mục. (1)

```
corgi@corgi:~/KhanhNT/internship-2020/KhanhNT$ ls -l
total 16
-rw-rw-r--  1 corgi corgi 1586 Th08 18 21:19 git.md
-rw-rw-r--  1 corgi corgi 1942 Th08 18 21:19 gitver2.md
drwxrwxr-x 10 corgi corgi 4096 Th09  8 15:20 Linux
drwxrwxr-x 12 corgi corgi 4096 Th09  8 10:26 Network
```
Trong đó:

```
-rw-rw-r-- 
drwxrwxr-x : Các chỉ số phân quyền, chữ `d` chỉ thư mục.
Dấu gach ngang (-) có nghĩa là phân đủ quyền cho nó, mỗi dấu gạch ngang mô tả cho 1 quyền. 
```
```
- rw-: đối tượng thứ nhất là quyền user sở hữu nó.
- rw-: đối tượng thứ 2 là quyền cho các user thuộc group sở hữu nó.
- r--: đối tượng thứ 3 là quyền dành cho mọi user không.
```

## 2. Thay đổi phân quyền cho file/folder
- `chmod [option] [Phân quyền] [file/folder_name]`
   + `-v`: báo cáo sau khi chạy lệnh.
   + `-c`: Hiện thị báo cáo khi làm xong tất cả.
   + `-R`: nếu chmod 1 folder thì áp dụng luôn vào các folder/file bên trong. 

```
corgi@ubuntu:~$ ls -l
total 4
drwxrwxr-x 2 corgi corgi 4096 Sep  8 15:48 test
corgi@ubuntu:~$ sudo chmod -v 400 test/
[sudo] password for corgi: 
mode of 'test/' changed from 0775 (rwxrwxr-x) to 0400 (r--------)

```

## 3. Thay đổi chủ sở hữu file/folder
- `chown -R [user_name]:[Group_name] [file/folder]`




