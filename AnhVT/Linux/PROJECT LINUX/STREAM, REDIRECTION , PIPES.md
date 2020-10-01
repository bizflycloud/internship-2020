# STREAM, REDIRECTION , PIPES

## 1. Giới thiệu

![STREAM,%20REDIRECTION%20,%20PIPES/Untitled.png](STREAM,%20REDIRECTION%20,%20PIPES/Untitled.png)

Trong hệ điều hành Linux, để tiết kiệm khoảng thời gian thực hiện các lệnh, cơ chế ống lệnh thường được sử dụng rất nhiều.

---

## 2. Các luồng dữ liệu ( Data Stream) kết nối với 1 chương trình

Trước khi đến với định nghĩa của hệ thống ống lệnh (pipeline), chúng ta cần tìm hiểu xem nó thực sự hoạt động hay giao tiếp với dữ liệu nào. Ở trong hệ điều hành Linux, mỗi chương trình khi chạy thường được kết nối với 3 nguồn data stream cơ bản đó là :

1.  STDIN ( INPUT ) : Phần dữ liệu được nhập vào cho chương trình. Mặc định được in ra tại cửa sổ Terminal
2. STDOUT ( OUTPUT) : Phần dữ liệu được xuất ra bởi chương trình sau khi đã thực hiện xong 1 số yêu cầu. Mặc định sẽ được in ra tại cửa sổ Terminal
3. STDERR ( ERROR) : Phần thông báo hiển thị lỗi

![STREAM,%20REDIRECTION%20,%20PIPES/Untitled%201.png](STREAM,%20REDIRECTION%20,%20PIPES/Untitled%201.png)

Kỹ thuật ống lệnh có thể hiểu đơn giản là cách chúng ta nối các data stream này của các chương trình ứng dụng theo cách người dùng mong muốn để có được kết quả.

---

## 3. Một số ví dụ

### 3.1. Chuyển dữ liệu sang 1 file cụ thể :

```bash
root@ubuntu-1vcpu-2gb-01-02:~# ls # liet ke cac file trong pwd
cat  install.log  root@xxx
root@ubuntu-1vcpu-2gb-01-02:~# ls > stat.txt # Redirect du lieu vao 1 file stat.txt
root@ubuntu-1vcpu-2gb-01-02:~# cat stat.txt # Kiem tra file stat.txt 
cat
install.log
root@xxxx
stat.txt
```

Vậy là chúng ta đã có 1 ví dụ đơn giản và dễ hiểu nhất về cơ chế hoạt động ống lệnh. Ở đây chúng ta đã redirect STDOUT của lệnh ls vào 1 file `stat.txt` . Bạn có thể tự áp dụng với 1 số câu lệnh khác và trải nghiệm.

Một lưu ý đó là nếu file chúng ta redirect kết quả không tồn tại thì hệ thống sẽ tự động tạo 1 file theo yêu cầu của chúng ta.

Và 1 điều nữa đó chính là việc chúng ta sử dụng `>` . Syntax này có ý nghĩa như sau: sẽ xóa toàn bộ dữ liệu hiện có trong file và ghi dữ liệu vừa nhận được từ cơ chế ống lệnh.

### 3.2. Thêm dữ liệu vào 1 file cụ thể

```bash
root@ubuntu-1vcpu-2gb-01-02:~# ls -al >> stat.txt 
root@ubuntu-1vcpu-2gb-01-02:~# cat stat.txt 
cat
install.log
root@123.30.234.238
stat.txt
total 116
drwx------  7 root root  4096 Sep 15 15:06 .
drwxr-xr-x 22 root root  4096 Sep  9 22:48 ..
-rw-r--r--  1 root root 46068 Sep 14 23:02 .bash_history
-rw-r--r--  1 root root  3106 Apr  9  2018 .bashrc
drwx------  2 root root  4096 Mar 19  2019 .cache
drwx------  3 root root  4096 Aug 28 11:24 .emacs.d
drwx------  3 root root  4096 Mar 19  2019 .gnupg
drwxr-xr-x  3 root root  4096 Aug 20 10:24 .local
-rw-------  1 root root   304 Sep 12 00:13 .mysql_history
-rw-------  1 root root  1129 Sep 11 21:58 .ndb_mgm_history
-rw-r--r--  1 root root   148 Aug 17  2015 .profile
drwx------  2 root root  4096 Aug 31 08:49 .ssh
-rw-r--r--  1 root root   168 Sep  5 19:07 .wget-hsts
-rw-r--r--  1 root root    31 Jul 30 11:42 cat
-rw-r--r--  1 root root     1 Jul 30 11:42 install.log
-rw-r--r--  1 root root  1870 Aug 31 08:48 root@123.30.234.238

```

Điểm khác biệt đối với ví dụ 1 đó chính là việc chúng ta không hề xóa đi dữ liệu có trong file `stat.txt` mà thay vào đo là thêm ( append ) vào. Syntax sử dụng khác biệt với ví dụ 1 đó chính là `>>` .

### 3.3 Redirect STDERR

```bash
root@ubuntu-1vcpu-2gb-01-02:~# cat 0.txt 2> stat.txt 
root@ubuntu-1vcpu-2gb-01-02:~# cat stat.txt 
cat: 0.txt: No such file or directory
```

Ngoài STDIN và STDOUT chúng ta hoàn toàn có thể redirect dữ liệu từ STDERR ra 1 file cụ thể. Ở đây chúng ta cần chú ý câu lệnh sử dụng `2>` ( 0 - STDIN ; 1 - STDOUT ; 2 - STDERR ). Ngoài ra nếu không muốn xóa toàn bộ dữ liệu trong file đã có ta có thể chuyển câu lệnh thành `2>>`

### 3.4 Kết hợp các loại Redirect

```bash
root@ubuntu-1vcpu-2gb-01-02:~# wc -l < stat.txt > new.txt
root@ubuntu-1vcpu-2gb-01-02:~# wc -l
root@ubuntu-1vcpu-2gb-01-02:~# cat new.txt 
1
```

Ở đây chúng ta sử dụng `wc -l` để đếm số dòng trong file `stat.txt` rồi sau đó chuyển OUTPUT của lệnh này vào trong file `new.txt`

---

## 4. Pipe ( Ống lệnh )

Cơ chế ống lệnh được sử dụng trong các hệ điều hành Linux và Unix khác nhau. Dựa trên cơ chế chuyển dữ liệu linh hoạt. Cơ chế hoạt động với 2 lệnh được kết hợp với nhau. STDIN của lệnh 2 chính là STDOUT của lệnh 1 và tương tự như vậy đối với các ống lệnh đằng sau. Luồng dữ liệu hoạt động từ trái sang phải. 

Ở đây chúng ta có 1 ví dụ đơn giản về cơ chế ống lệnh. Chúng ta sẽ lấy đầu ra của lệnh `ls -al` vốn có dạng như sau :

```bash
root@ubuntu-1vcpu-2gb-01-02:~# ls -al
total 120
drwx------  7 root root  4096 Sep 15 15:24 .
drwxr-xr-x 22 root root  4096 Sep  9 22:48 ..
-rw-r--r--  1 root root 46068 Sep 14 23:02 .bash_history
-rw-r--r--  1 root root  3106 Apr  9  2018 .bashrc
drwx------  2 root root  4096 Mar 19  2019 .cache
drwx------  3 root root  4096 Aug 28 11:24 .emacs.d
drwx------  3 root root  4096 Mar 19  2019 .gnupg
drwxr-xr-x  3 root root  4096 Aug 20 10:24 .local
-rw-------  1 root root   304 Sep 12 00:13 .mysql_history
-rw-------  1 root root  1129 Sep 11 21:58 .ndb_mgm_history
-rw-r--r--  1 root root   148 Aug 17  2015 .profile
drwx------  2 root root  4096 Aug 31 08:49 .ssh
-rw-r--r--  1 root root   168 Sep  5 19:07 .wget-hsts
-rw-r--r--  1 root root    31 Jul 30 11:42 cat
-rw-r--r--  1 root root     1 Jul 30 11:42 install.log
-rw-r--r--  1 root root     2 Sep 15 15:26 new.txt
-rw-r--r--  1 root root  1870 Aug 31 08:48 root@123.30.234.238
-rw-r--r--  1 root root    38 Sep 15 15:18 stat.txt
```

Sau đó đầu ra STDOUT này sẽ được làm STDIN cho lệnh `grep stat.txt` ( có tác dụng tìm kiếm file ), được kết quả như sau

```bash
root@ubuntu-1vcpu-2gb-01-02:~# ls -al | grep stat.txt 
-rw-r--r--  1 root root    38 Sep 15 15:18 stat.txt
```

**Vậy là chúng ta đã có cái nhìn cơ bản về phần Data Stream và cơ chế Pipe trong Linux!**

## Nguồn tham khảo

[Learn Piping and Redirection - Linux Tutorial](https://ryanstutorials.net/linuxtutorial/piping.php#theory)

[Pipe, Grep and Sort Command in Linux/Unix with Examples](https://www.guru99.com/linux-pipe-grep.html)