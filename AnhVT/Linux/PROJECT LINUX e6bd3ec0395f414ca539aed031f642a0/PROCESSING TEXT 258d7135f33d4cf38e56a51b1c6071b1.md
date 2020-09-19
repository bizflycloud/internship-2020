# PROCESSING TEXT

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled.png)

## 1. Giới thiệu

Một trong những tác vụ không thể thiếu trong khi sử dụng của sổ Terminal đó chính là việc chỉnh sửa, đọc dữ liệu trong các file text ( có thể là file log, file cnf, .... ) Vậy nên các thao tác cơ bản đối với các file này là vô cùng cần thiết cũng như sẽ cung cấp nhiều tiện ích trong quá trình sử dụng OS.

## 2. Các lệnh cơ bản như cat, join, paste

### 2.1 Lệnh `cat`

Mục đích sử dụng chính của lệnh này đó chính là in ra STDOUT của 1 file text ra màn hình Terminal. Ngoài ra cũng có thể sử dụng `cat` để nhâp vào dữ liệu. Ví dụ:

```bash
root@ubuntu-1vcpu-2gb-01-02:~# cat stat.txt 
cat: 0.txt: No such file or directory
hello
```

Chúng ta vừa sử dụng lệnh `cat` để đọc dữ liệu từ file `stat.txt` . Sau đây chúng ta sẽ đến với ví dụ sử dụng `cat` để ghi dữ liệu vào file :

```bash
root@ubuntu-1vcpu-2gb-01-02:~# cat <<EOF>> stat.txt 
> hi
> EOF
root@ubuntu-1vcpu-2gb-01-02:~# cat stat.txt 
cat: 0.txt: No such file or directory
hello

hi
```

Qua ví dụ trên hoàn toàn có thể thấy việc sử dụng lệnh `cat` là rất linh hoạt và tùy theo mục đích của người sử dụng

### 2.2 Lệnh `join`

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%201.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%201.png)

Lệnh này được sử dụng để join 2 file text dựa trên 1 cột có nội dung chung. Cú pháp câu lệnh này có dạng như sau:

```bash
$ join [OPTION] FILE1 FILE2
```

Ví dụ cơ bản :

```bash
$cat file1.txt
1 AAYUSH
2 APAAR
3 HEMANT
4 KARTIK

$cat file2.txt
1 101
2 102
3 103
4 104
```

Kết quả nhận được sau khi sử dụng lệnh `join` :

```bash
$ join file1.txt file2.txt
1 AAYUSH 101
2 APAAR 102
3 HEMANT 103
4 KARTIK 104
```

*Các option đi kèm:*

```bash
1. -a FILENUM : Hien thi cac dong khong khop
2. -e EMPTY : Thay the phan trong = EMPTY
3. -i - -ignore-case : Bo qua viet hoa
4. -j FIELD : Tuong duong voi "-1 FIELD -2 FIELD".
5. -o FORMAT : Tuan theo Format khi in ra output
6. -t CHAR : su dung phan tach cac phan tu bang CHAR
7. -v FILENUM : Chi in ra cac dong khong khop
8. -1 FIELD : Join phan nay cua file 1
9. -2 FIELD : Join phan nay cua file 2.
10. - -check-order : Kiem tra viec sap xep thu tu
11. - -nocheck-order : Khong kiem tra viec sap xep thu tu
12. - -help : hien thi muc help
13. - -version : hien thi phien ban
```

### 2.3 Lệnh `paste`

Lệnh này có mục đích gần tương tự như lệnh `join` tuy nhiên có sự khác biệt đó là việc không yêu cầu phải có 1 common field.  Cấu trúc câu lệnh như sau:

```bash
paste [OPTION]... [FILES]...
```

Ví dụ cơ bản:

```bash
$ cat state
Arunachal Pradesh
Assam
Andhra Pradesh
Bihar
Chhattisgrah

$ cat capital
Itanagar
Dispur
Hyderabad
Patna
Raipur
```

Kết quả nhận được sau khi sử dụng lệnh `paste` :

```bash
$ paste number state capital
1       Arunachal Pradesh       Itanagar
2       Assam   Dispur
3       Andhra Pradesh  Hyderabad
4       Bihar   Patna
5       Chhattisgrah    Raipur
```

*Các option cơ bản:*

```bash
1. -d Char : Su dung Char de phan tach cac phan tu
2. -s :  Ket qua hien thi o hang doc
3. -version : phien ban dang su dung
```

---

## 3. Các lệnh đọc file như `head` `tail` `less` `cut` `wc` :

### 3.1 Lệnh `head` :

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%202.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%202.png)

Lệnh này được sử dụng khi người dùng muốn in ra N dòng đầu của file. Mặc định lệnh này sẽ in ra 10 dòng đầu tiên của file nếu không có option đi kèm chỉ thị. Cú pháp :

```bash
head [OPTION]... [FILE]...
```

Ví dụ:

```bash
$ cat state.txt
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh
Goa
Gujarat
Haryana
Himachal Pradesh
Jammu and Kashmir
Jharkhand
Karnataka
Kerala
Madhya Pradesh
Maharashtra
Manipur
Meghalaya
Mizoram
Nagaland
Odisha
Punjab
Rajasthan
Sikkim
Tamil Nadu
Telangana
Tripura
Uttar Pradesh
Uttarakhand
West Bengal

```

```bash
$ head state.txt
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh
Goa
Gujarat
Haryana
Himachal Pradesh
Jammu and Kashmir
```

*Các option đi kèm:* 

```bash
1. -n Num : in ra 'Num' dong cua file
2. -c Num : in ra 'Num' bytes cua file
3. -q file 1 file 2 : in ra 10 dong dau tien cua file 1 va file 2
4. -v : hien thi ten file truoc khi hien thi du lieu
```

Một số cách kết hợp:

1. Kết hợp với lệnh `tail` để in ra các dòng giữa M và N dòng

```bash
# Lenh head se in ra 20 dong dau tien va lenh tail in ra 10 dong tinh tu dong cuoi
# Y tuong co ban la in tu dong 10 den 20
$ head -n 20 state.txt | tail -10
Jharkhand
Karnataka
Kerala
Madhya Pradesh
Maharashtra
Manipur
Meghalaya
Mizoram
Nagaland
Odisha
```

2. Kết hợp với lệnh `ls -t` để in ra các file gần đây có sử dụng hoặc có chỉnh sửa :

```bash
# Hien thi tat ca cac file su dung gan day
$ ls -t
e.txt 
d.txt
c.txt
b.txt  
a.txt

# Hien thi 3 file su dung gan day
$ ls -t | head -n 3
e.txt
d.txt
c.txt
```

### 3.2 Lệnh `tail`

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%203.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%203.png)

Lệnh này thực hiện in ra N dòng cuối của 1 file . Là phiên bản đổi lập của lệnh `head`. Cú pháp sử dụng:

```bash
tail [OPTION]... [FILE]...
```

Ví dụ:

```bash
$ cat state.txt
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh
Goa
Gujarat
Haryana
Himachal Pradesh
Jammu and Kashmir
Jharkhand
Karnataka
Kerala
Madhya Pradesh
Maharashtra
Manipur
Meghalaya
Mizoram
Nagaland
Odisha
Punjab
Rajasthan
Sikkim
Tamil Nadu
Telangana
Tripura
Uttar Pradesh
Uttarakhand
West Bengal
```

```bash
$ tail state.txt
Odisha
Punjab
Rajasthan
Sikkim
Tamil Nadu
Telangana
Tripura
Uttar Pradesh
Uttarakhand
West Bengal
```

*Một số các option:*

```bash
1. -n Num : in ra 'Num' dong cuoi 
2. -c Num : in ra 'Num' byte cuoi
3. -v : Hien thi ten file truoc khi hien thi du lieu
4. -version : Hien thi phien ban su dung
```

---

## 4. Các lệnh tìm kiếm `grep` `sed` `awk` :

### 4.1 Lệnh `grep` :

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%204.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%204.png)

Lệnh grep cho phép người sử dụng tìm kiếm các file theo 1 khuôn mẫu xác định. Cú pháp sử dụng:

```bash
grep [options] pattern [files]
```

Ví dụ :

```bash
vutuananh@vutuananh-virtual-machine:~$ ls -l
total 1620
drwxrwxr-x 4 vutuananh vutuananh    4096 Thg 7  15 20:38 Decom
drwxr-xr-x 4 vutuananh vutuananh    4096 Thg 9   2 07:15 Desktop
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Documents
drwxr-xr-x 4 vutuananh vutuananh    4096 Thg 9   2 07:24 Downloads
-rw-rw-r-- 1 vutuananh vutuananh 1604511 Thg 8   8 07:01 Firefox_wallpaper.png
drwxrwxr-x 6 vutuananh vutuananh    4096 Thg 7  25 19:25 LinuxVcc
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Music
drwxr-xr-x 3 vutuananh vutuananh    4096 Thg 7  25 19:49 Pictures
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Public
drwxrwxr-x 3 vutuananh vutuananh    4096 Thg 6  20 13:37 PycharmProjects
drwxr-xr-x 4 vutuananh vutuananh    4096 Thg 7   1 08:03 snap
-rw-rw-r-- 1 vutuananh vutuananh     134 Thg 9  15 15:05 stat.txt
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Templates
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Videos
```

```bash
vutuananh@vutuananh-virtual-machine:~$ ls -l | grep Music
drwxr-xr-x 2 vutuananh vutuananh    4096 Thg 5  22 19:46 Music
```

*Các option đi kèm:*

```bash
1. -i : Khong phan biet viet hoa hay thuong
2. -c : Hien thi so ket qua tim duoc
3. -w char : Neu 'char' nam trong 1 substring thi in ra cac ket qua do
4. -o char : Mac dinh grep se in ra toan bo dong co chua 'char'. Option -o giup chi in ra phan co ket qua 'char'
5. -n char : In ra so thu tu cua dong co xuat hien 'char'
6. "^char" : in ra cac dong bat dau voi 'char'
7. "char%" : in ra cac dong ket thuc voi 'char'

```

### 4.2 Lệnh `sed` :

![PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%205.png](PROCESSING%20TEXT%20258d7135f33d4cf38e56a51b1c6071b1/Untitled%205.png)

Lệnh này có thể sử dụng để thực hiện 1 số các yêu cầu khác nhau như tìm kiếm file, tìm kiếm và thay thế hay xóa. Đây là 1 câu lệnh mạnh mẽ cung cấp khả năng tìm kiếm và thay thế. Cú pháp

```bash
sed OPTIONS... [SCRIPT] [INPUTFILE...]
```

*Các ứng dụng*:

```bash
# Xet vi du sau
$cat > geekfile.txt
unix is great os. unix is opensource. unix is free os.
learn operating system.
unix linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
```

1. Tìm kiếm và thay thế từ đầu tiên trong các dòng:

```bash
$sed 's/unix/linux/' geekfile.txt
```

```bash
linux is great os. unix is opensource. unix is free os.
learn operating system.
linux linux which one you choose.
linux is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
```

→ Việc thay thế chỉ diễn ra 1 lần trong 1 dòng 

2. Thay thế phần tử thứ n trong dòng:

```bash
$sed 's/unix/linux/2' geekfile.txt
```

```bash
unix is great os. linux is opensource. unix is free os.
learn operating system.
unix linux which one you choose.
unix is easy to learn.linux is a multiuser os.Learn unix .unix is a powerful.
```

→ Các phần tử 'unix' thứ 2 sẽ được thay thế bằng 'linux'

3. Thay thế toàn bộ các phần tử có kết quả trùng:

```bash
$sed 's/unix/linux/g' geekfile.txt
```

```bash
linux is great os. linux is opensource. linux is free os.
learn operating system.
linux linux which one you choose.
linux is easy to learn.linux is a multiuser os.Learn linux .linux is a powerful.
```

4. Thay thế từ phần tử thứ n đến sau theo từng dòng :

```bash
$sed 's/unix/linux/3g' geekfile.txt
```

```bash
unix is great os. unix is opensource. linux is free os. # phan tu thu bi thay the
learn operating system.
unix linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn linux .linux is a powerful. # Cac phan tu bat dau tu vi tri thu 3 bi thay the
```

5. Thay thế toàn bộ tại 1 dòng xác định 

```bash
$sed '3 s/unix/linux/' geekfile.txt
```

```bash
unix is great os. unix is opensource. unix is free os.
learn operating system.
linux linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
```

---

## Nguồn tham khảo

[Text Processing](https://learnbyexample.gitbooks.io/linux-command-line/content/Text_Processing.html#paste)

[join Command in Linux - GeeksforGeeks](https://www.geeksforgeeks.org/join-command-linux/)

[Paste command in Linux with examples - GeeksforGeeks](https://www.geeksforgeeks.org/paste-command-in-linux-with-examples/)

[grep command in Unix/Linux - GeeksforGeeks](https://www.geeksforgeeks.org/grep-command-in-unixlinux/)

[Head command in Linux with examples - GeeksforGeeks](https://www.geeksforgeeks.org/head-command-linux-examples/)

[Tail command in Linux with examples - GeeksforGeeks](https://www.geeksforgeeks.org/tail-command-linux-examples/)

[Sed Command in Linux/Unix with examples - GeeksforGeeks](https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/)