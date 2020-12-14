# PHÂN QUYỀN TẬP TIN VÀ THƯ MỤC TRÊN LINUX
Mục Lục.

[I. Phân quyền là như thế nào?](#1)

[II. Phân quyền nâng cao SUID, GUID, Sticky Bit và chỉ sô Umask](#2)

- [2.1 Set User IDentity](#2.1)
- [2.2 Set Group IDentity](#2.2)
- [2.3 Sticky Bit](#2.3)
- [2.4 Umask( User file-creation mode mask)](#2.4)

---

## <a name="1"> I. Phân quyền là như thế nào? </a>

Tất cả các file trên những hệ thống giống như Unix đều có quyền được gán cho cả ba lớp và chúng xác định hành động nào có thể được thực hiện bởi các lớp đã nói đối với file đã cho.

Ba hành động có sẵn trên một hệ thống giống như Unix là: read (đọc - khả năng mở và xem nội dung của file), write (ghi - khả năng mở và sửa đổi nội dung của file) và execute (thực thi - khả năng chạy file như một chương trình thực thi).

Nói cách khác, các quyền của file xác định xem:

- Chủ sở hữu có thể đọc, viết và thực thi file không.
Nhóm có thể đọc, viết và thực thi file.
- Bất cứ ai khác có thể đọc, viết và thực thi file không.

Quyền truy cập file Linux có thể được hiển thị ở hai định dạng.

- Định dạng đầu tiên được gọi là symbolic notation (ký hiệu tượng trưng), ​​là một chuỗi gồm 10 ký tự: Một ký tự đại diện cho loại file và 9 ký tự đại diện cho các quyền đọc (r), ghi (w) và thực thi (x) của file theo thứ tự chủ sở hữu, nhóm, và những người dùng khác. Nếu không được phép, biểu tượng dấu gạch ngang (-) sẽ được sử dụng.

    Ví dụ:
    `-rwxr-xr--`

    Quyền đối với file trong Linux: Điều này có nghĩa nó là một file thông thường với quyền đọc, ghi và thực thi cho chủ sở hữu, đọc và thực thi cho nhóm và chỉ đọc cho những người khác.

- Định dạng thứ hai được gọi là numeric notation (ký hiệu số), là một chuỗi gồm ba chữ số, mỗi chữ số tương ứng với user, nhóm và các quyền khác. Mỗi chữ số có thể nằm trong khoảng từ 0 đến 7 và mỗi giá trị của chữ số có được bằng cách tính tổng các quyền của lớp:

    - 0 có nghĩa là không có quyền nào được cho phép.
    - +1 nếu lớp có thể thực thi file.
    - +2 nếu lớp có thể ghi vào file.
    - +4 nếu lớp có thể đọc file.

    Nói cách khác, ý nghĩa của từng giá trị chữ số là:

    - 0: Không được phép thực hiện bất kỳ quyền nào
    - 1: Thực thi
    - 2: Viết
    - 3: Viết và thực thi
    - 4: Đọc
    - 5: Đọc và thực thi
    - 6: Đọc và viết
    - 7: Đọc, viết và thực thi


Ví dụ 
```
-rw-rw-r--     1      root    root   0      Sep 21 19:47 testfile
drwxrwxr-x     2      root    root  4096   Sep 21 19:47 testfolder
__________________________________________^-- Ngày tháng tạo ra file và tên file
^ ^  ^  ^      ^      ^      ^    ^
| |  |  |      |      |      |    \--- Dung lượng của file/folder
| |  |  |      |      |      \-------- Tên group sở hữu
| |  |  |      |      \--------------- Tên user sở hữu
| |  |  |      \---------------------- Số này khó giải thích, bỏ qua vì không quan trọng
| |  |  |
| \--\--\----------------------------- Các chỉ số phân quyền
\------------------------------------- Loại file (chữ d nghĩa là thư mục)
```

Trong đó :
- Dấu (-) đảu tiên chưa bật đủ quyền dành cho nó.
- rw-: Đối tượng thứ nhất chính là quyền dành cho user sở hữu nó.
- rw-: Đối tượng thứ hai chính là quyền dành cho CÁC user thuộc group đang sở hữu nó.
- r--: Đối tượng thứ ba chính là quyền dành cho MỌI user không thuộc quyền sở hữu và không thuộc group sở hữu.

## <a name="2"> II. Phân quyền nâng cao SUID, GUID, Sticky Bit và chỉ sô umask </a>

<a name="2.1"></a>
### 2.1 SUID(Set User IDentity)
SUID bit được thiết lập cho một ứng dụng hay file có thể thực thi nào đó điều này có nghĩa là một người dùng không phải chủ sở hữu của ứng dụng hoặc thư mục cũng có thể sử dụng và chạy như chính chủ sở hữu của nó.
```
[root@localhost -]# II /usr/bin/passwd
-rwsr-xr-x. 1 root root 27832 Jun 10 2014 /usr/bin/passwd
```

Ta hãy để ý phân quyền file rws: Lệnh passwd thay đổi mật khẩu đã được thiết lập SUID bit. Tuy passwd thuộc root nhưng vì đã được thiết lập SUID nên người dùng cũng có thể  thực hiện passwd như quyền root.

<a name="2.2"></a>
### 2.2 SGID (Set Group IDentity)
SGID sẽ được áp dụng vào một tập thư mục, tập tin và thư mục hay tập tin mới được tạo ra trong thư mục đó sẽ thừa hưởng  các đặc tính trong nhóm đó.

<a name="2.3"></a>
### 2.3 Sticky bit 
Người dùng sẽ chỉ có thể xóa những file mà họ tạo ra chứa trong thư mục được đánh sticky bit.

<a name="2.4"></a>
### 2.4 Chỉ số Umask 
Umask ( User file-creation mode mask): Giá trị mask sẽ che đi một số bit trong base permistion để tạo ra quyền truy cập chính thức cho file.


Base Permission mặc định đối với:
- File thông thường là  666
- Thư mục là 777.


Sau khi tạo thì nó sẽ được sư dụng Umask để thay đôi quyền hạn.
- Thông thường mask mặc định của user là 002.
    - Quyền hạn sử dụng cho file là 664.
    - Quyền hạn sử dụng cho thư mục là 775

- Thông thường mask mặc định của root là 022.
    - Quyền hạn sử dụng cho file là 644.
    - Quyền hạn sử dụng cho thư mục là 755.


```
The file type is one of the following characters:
    -  regular file
    b  block special file
    c  character special file
    C  high performance ("contiguous data") file
    d  directory
    D  door (Solaris 2.5 and up)
    l  symbolic link
    M  off-line ("migrated") file (Cray DMF)
    n  network special file (HP-UX)
    p  FIFO (named pipe)
    P  port (Solaris 10 and up)
    s  socket
    ?  some other file type
```

