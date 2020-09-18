# Phân quyền trên Linux
## 1. Quyền sở hữu (Ownership) tập tin

| Lệnh | Chức năng |
| -----|-----------|
|chown| Sử dụng để thay đổi `quyền sở hữu của người dùng đối với tệp hoặc thư mục`|
| chgrp| Sử dụng để `thay đổi quyền sở hữu nhóm`|
| chmod| Sử dụng để `thay đổi các quyền trên tệp`, có thể `thực hiện riêng cho chủ sở hữu, nhóm và người dùng` khác|

## 2. Quyền (Permission) có thể cấu hình cho tập tin

| Chế độ | Tên | Mô tả |
|--------|-----|-------|
|r|read|Đọc tập tin/liệt kê các tập tin cho thư mục|
|w|write|Ghi tập tin/tạo tập tin mới cho thưc muc|
|x|excute| Thực thi tập tin/ xem đệ quy 1 cây thư mục|

```
-rw-rw-r--  1 corgi corgi   33 Sep  9 15:25 abc.sh
 u  g   o
```

```
u: người dùng hoặc chủ sở hữu
g: nhóm
o: người khác
```

## 3. Lệnh chmod
- Cho phép thay đổi quyền (permission) cho 1 file hayb folder.
- Phân quyền theo chế độ số.
| Số | Loại quyền | Kí hiệu |
|----|------------|---------|
|0|Không cho phép|---|
|1|Thực thi|--x|
|2|Ghi|-w-|
|3|Viết và thực thi|-wx|
|4|Đọc|r--|
|5|Đọc và thực thi|r-w|
|6|Đọc và ghi|rw-|
|7|Đọc, ghi và thực thi|rwx|

- Phân quyền theo chế độ tượng trưng (Symbolic)

|Tham chiếu|Nhóm|Mô tả|
|----------|----|-----|
|u|Người dùng|Chủ sở hữu tập tin|
|g|Nhóm|Các người dùng thuộc nhóm của tập tin|
|o|Người dùng khác|Các người dùng không thuộc nhóm cũng không phải thuộc chủ sở hữu|
|a|Tất cả|Tất cả 3 lớp trên| 

|Toán tử|Chức năng|
|-------|---------|
|+|Thêm quyền|
|-|Xóa quyền|
|=|Đặt quyền ghi đè các quyền được đặt trước đó|

```
corgi@ubuntu:~$ ls -l
total 16
-rw-rw-r--  1 corgi corgi   33 Sep  9 15:25 abc.sh
drwxrwxr-x  3 corgi corgi 4096 Sep 15 12:18 kubernetes
drwxrwxr-x 16 corgi corgi 4096 Sep  8 22:19 kubernetes-ingress
drwxrwxrwx  2 corgi corgi 4096 Sep  8 15:48 test
-rw-rw-r--  1 corgi corgi    0 Sep 15 12:15 test.txt
corgi@ubuntu:~$ chmod uo+x abc.sh 
corgi@ubuntu:~$ ls -l
total 16
-rwxrw-r-x  1 corgi corgi   33 Sep  9 15:25 abc.sh
drwxrwxr-x  3 corgi corgi 4096 Sep 15 12:18 kubernetes
drwxrwxr-x 16 corgi corgi 4096 Sep  8 22:19 kubernetes-ingress
drwxrwxrwx  2 corgi corgi 4096 Sep  8 15:48 test
-rw-rw-r--  1 corgi corgi    0 Sep 15 12:15 test.txt
```

## 4. Lệnh chown
- User và group được nagwn cách nhau bằng dấu `:`.
- Thay đổi người dùng sở hữu
   + `chown user file`
- Thay đổi người dùng sở hữu và nhóm
   + `chown user:group file`
- Thay đổi chửu sở hữu cảu 1 thư mục và tất cả nội dung bên trong 
   + `chown -R user folder`

## 5. Lệnh chgrp
- Thay đổi chủ sở hữu của tập tin hoặc thư mục
  + `chgrp group file`
- Thay đổi chủ sở hữu thư mục và tất cả nội dung bên trong nó.
  + `chgrp -R group folder`




