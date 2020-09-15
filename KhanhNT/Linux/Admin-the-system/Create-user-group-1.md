# Quản lí user và group trên Linux
## 1. Xác định người dùng hiện tại 
- `whoami`
- `who -a`

```
corgi@ubuntu:~$ whoami
corgi

```
```
corgi@ubuntu:~$ who -a
           system boot  Sep  9 09:29
           run-level 2  Sep  9 09:29
LOGIN      tty4         Sep  9 09:29               824 id=4
LOGIN      tty5         Sep  9 09:29               827 id=5
LOGIN      tty2         Sep  9 09:29               832 id=2
LOGIN      tty3         Sep  9 09:29               833 id=3
LOGIN      tty6         Sep  9 09:29               835 id=6
LOGIN      tty1         Sep  9 09:29              1011 id=1
corgi    + pts/0        Sep  9 09:34   .          1030 (10.0.2.2)
```
## 2. User và group trên Linux
- User định danh cho 1 người dùng trên hệ thống. 
- Group định danh cho 1 nhóm người dùng.
- Linux gắn cho mỗi User 1 ID (bắt đầu từ ID 1000 trở lên)
- Kiểm soát user trong group qua file
  + `/etc/group`
  + `/etc/passwd`

```
corgi@ubuntu:~$ tail -5 /etc/group
ssh:x:108:
landscape:x:109:
corgi:x:1000:
lpadmin:x:110:corgi
sambashare:x:111:corgi

corgi@ubuntu:~$ tail -5 /etc/passwd
syslog:x:101:104::/home/syslog:/bin/false
messagebus:x:102:106::/var/run/dbus:/bin/false
landscape:x:103:109::/var/lib/landscape:/bin/false
sshd:x:104:65534::/var/run/sshd:/usr/sbin/nologin
corgi:x:1000:1000:corgi,,,:/home/corgi:/bin/bash
```

trong đó:

```
corgi: username
x: password
1000 first: user ID (0: root, 1-99: tài khoản hệ thống)
1000 second: group ID
corgi second: group ID info
/home/corgi: home directory 
/bin/bash: shell
```

## 3. Tạo và xóa người dùng
### 3.1.
- Sử dụng lệnh `useradd` để tạo username

  + `useradd <username>`

- Để đặt mật khẩu hoặc đặt lại mật khẩu cho username

  + `passwd <username>`

- Xóa user
  + `userdel <username>`

```
corgi@ubuntu:~$ sudo useradd husky
[sudo] password for corgi: 
corgi@ubuntu:~$ sudo passwd husky
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
```

### 3.2 Tạo nhiều user

```
    #!/bin/bash
    for i in $( cat users.txt ); do
    useradd $i
    echo "user $i added successfully!"
    echo $i:$i"123" | chpasswd
    echo "Password for user $i changed successfully"
    done
```


## 4. Tạo/Xóa Group
- Tạo group
  + `groupadd <groupname>
- Thêm user vào group
  + `useradd -a -G <groupname> <username>`
- Xóa group 
  + `groupdel <groupname>`
 
 __ Tài liệu tham khảo__
 - https://blogd.net/linux/quan-ly-nguoi-dung-va-nhom-tren-linux/ 
  


